package repo

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"script/db"
	"script/db/models"
	"strings"
	"time"

	"github.com/BryanMwangi/logger/v3"
	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
)

// error variables
var (
	ErrUserExists    = errors.New("user exists")
	ErrUserNotFound  = errors.New("user not found")
	ErrStoreNotFound = errors.New("store not found")
)

// store owner variables
var (
	Password   = "password"
	Role       = "store"
	STORE_FILE = "./data/suppliers_with_uid.json"
	DefaultPP  = "https://i.pinimg.com/564x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg"
)

func ConstructStoreOwner(name string, uid uuid.UUID) (models.User, error) {
	// Hash the password
	passwordData, err := bcrypt.GenerateFromPassword([]byte(Password), bcrypt.DefaultCost)
	if err != nil {
		return models.User{}, err
	}
	passwordHash := string(passwordData)

	// Split the name
	nameParts := strings.Split(name, " ")
	if len(nameParts) < 2 {
		return models.User{}, fmt.Errorf("name must contain at least first and last parts")
	}
	firstName := nameParts[0]
	lastName := nameParts[len(nameParts)-1]

	// Create the username
	userName := strings.ToLower(firstName + lastName)

	return models.User{
		Id:             uid,
		Email:          userName + "@test.com",
		Password:       passwordHash,
		FirstName:      firstName,
		LastName:       lastName,
		UserName:       userName,
		DisplayName:    name,
		Deleted:        false,
		PhoneNumber:    "",
		ProfilePicture: "",
		Role:           Role,
		CreatedAt:      time.Now(),
		UpdatedAt:      time.Now(),
	}, nil
}

// we now loop over the suppliers_with_uid.json to create users that we can
// use to add stores
func GenerateSuppliers() error {
	var suppliers []models.Supplier
	if _, err := os.Stat(STORE_FILE); os.IsNotExist(err) {
		logger.Error(err.Error())
		return err
	} else {
		suppliersData, err := os.ReadFile(STORE_FILE)
		if err != nil {
			logger.Error(err.Error())
			return err
		}
		if err := json.Unmarshal(suppliersData, &suppliers); err != nil {
			logger.Error(err.Error())
			return err
		}
	}
	var users []models.User
	for _, supplier := range suppliers {
		parsedUID := uuid.MustParse(supplier.Uid)

		user, err := ConstructStoreOwner(supplier.Name, parsedUID)
		if err != nil {
			logger.Error(err.Error())
			return err
		}
		users = append(users, user)
	}
	//we now save the file temporarily locally as json
	//we will use this file to create the database
	jsonData, err := json.MarshalIndent(users, "", " ")
	if err != nil {
		logger.Error(err.Error())
		return err
	}
	if err := os.WriteFile(STORE_FILE, jsonData, 0644); err != nil {
		logger.Error(err.Error())
		return err
	}
	return nil
}

func CreateUser(ctx context.Context, newUser models.User) error {
	_, err := db.DB.Exec(ctx, `
    INSERT INTO users (id, email, password, "firstName", "lastName", "userName", "displayName", deleted, "phoneNumber", "profilePicture", role, "createdAt", "updatedAt") 
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)`,
		newUser.Id,
		newUser.Email,
		newUser.Password,
		newUser.FirstName,
		newUser.LastName,
		newUser.UserName,
		newUser.DisplayName,
		false,
		"",
		DefaultPP,
		Role,
		time.Now(),
		time.Now(),
	)

	if err != nil {
		return fmt.Errorf("error creating user: %w", err)
	}
	return nil
}

// we now loop over the suppliers_with_uid.json to create users that we can
// we can add users to the database
func AddUsersToDB(ctx context.Context) error {
	var users []models.User
	//we check if the file is created or not
	if _, err := os.Stat(STORE_FILE); os.IsNotExist(err) {
		logger.Error(err.Error())
		return err
	} else {
		//if the file exists, read its contents
		usersData, err := os.ReadFile(STORE_FILE)
		if err != nil {
			logger.Error(err.Error())
			return err
		}
		if err := json.Unmarshal(usersData, &users); err != nil {
			logger.Error(err.Error())
			return err
		}
	}
	for _, user := range users {
		logger.Info(fmt.Sprintf("Creating user: %s", user.DisplayName))
		if err := CreateUser(ctx, user); err != nil {
			logger.Error("Error creating user: " + err.Error())
			return err
		}
		logger.Success(fmt.Sprintf("User created: %s", user.DisplayName))
	}
	return nil
}
