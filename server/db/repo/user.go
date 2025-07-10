package repo

import (
	"context"
	"errors"
	"fmt"
	"time"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/utils"
)

type UserRepository interface {
	Create(models.User) (bool, error)
	GetByEmail(email string) (models.User, error)
	GetAll() (models.UsersFile, error)
	Update(newUser models.User) (models.User, error)
	Delete(id string) (bool, error)
}

// error variables
var (
	ErrUserExists   = errors.New("user exists")
	ErrUserNotFound = errors.New("user not found")
)

// general variables
var (
	DefaultPP = "https://i.pinimg.com/564x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg"
)

// we now use db
func CheckIfEmailExists(ctx context.Context, email string) (bool, error) {
	var existingEmail string
	err := db.DBPool.QueryRow(ctx, "SELECT email FROM users WHERE email = $1", email).Scan(&existingEmail)
	if err != nil {
		if err == pgx.ErrNoRows {
			return false, nil
		}
		return false, err
	}
	return true, nil
}

func CreateUser(ctx context.Context, newUser models.UserSignUpRequest, passwordHash string) (uuid.UUID, string, error) {
	exists, err := CheckIfEmailExists(ctx, newUser.Email)
	if err != nil {
		return uuid.Nil, "", err
	}
	if exists {
		return uuid.Nil, "", ErrUserExists

	}
	validEmail, email, err := utils.ValidateEmail(newUser.Email)
	if err != nil {
		return uuid.Nil, "", err
	}
	if !validEmail {
		return uuid.Nil, "", fmt.Errorf("invalid email: %s", email)
	}

	validName, name, err := utils.ValidateName(newUser.Name)
	if err != nil {
		return uuid.Nil, "", err
	}
	if !validName {
		return uuid.Nil, "", fmt.Errorf("invalid name: %s", name)
	}
	validUserName, userName, err := utils.ValidateName(newUser.UserName)
	if err != nil {
		return uuid.Nil, "", err
	}
	if !validUserName {
		return uuid.Nil, "", fmt.Errorf("invalid username: %s", userName)
	}
	firstName, lastName := utils.SplitName(name)
	displayName := firstName + " " + lastName
	var userID uuid.UUID
	err = db.DBPool.QueryRow(ctx, `
    INSERT INTO users (id, email, password, "firstName", "lastName", "userName", "displayName", deleted, "phoneNumber", "profilePicture", role, "createdAt", "updatedAt") 
    VALUES (gen_random_uuid(), $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)
    RETURNING id`,
		email,
		passwordHash,
		firstName,
		lastName,
		userName,
		displayName,
		false,
		"",
		DefaultPP,
		"customer",
		time.Now(),
		time.Now(),
	).Scan(&userID)

	if err != nil {
		return uuid.Nil, "", err
	}
	return userID, displayName, nil
}

func GetUserByEmail(ctx context.Context, email string) (models.User, error) {
	var u models.User
	row := db.DBPool.QueryRow(ctx, "SELECT * FROM users WHERE email=$1", email)
	err := row.Scan(&u.Id, &u.Email, &u.Password, &u.FirstName, &u.LastName, &u.UserName, &u.DisplayName, &u.Deleted, &u.PhoneNumber, &u.ProfilePicture, &u.Role, &u.CreatedAt, &u.UpdatedAt)
	if err != nil {
		if err == pgx.ErrNoRows {
			return models.User{}, ErrUserNotFound
		}
		return models.User{}, err
	}

	return u, nil
}
func GetUserById(ctx context.Context, id uuid.UUID) (models.UserResponse, error) {
	var u models.User
	row := db.DBPool.QueryRow(ctx, "SELECT * FROM users WHERE id=$1", id)
	err := row.Scan(&u.Id, &u.Email, &u.Password, &u.FirstName, &u.LastName, &u.UserName, &u.DisplayName, &u.Deleted, &u.PhoneNumber, &u.ProfilePicture, &u.Role, &u.CreatedAt, &u.UpdatedAt)
	if err != nil {
		if err == pgx.ErrNoRows {
			return models.UserResponse{}, ErrUserNotFound
		}
		return models.UserResponse{}, err
	}

	user := models.UserResponse{
		Email:          u.Email,
		FirstName:      u.FirstName,
		LastName:       u.LastName,
		UserName:       u.UserName,
		DisplayName:    u.DisplayName,
		PhoneNumber:    u.PhoneNumber,
		ProfilePicture: u.ProfilePicture,
	}
	return user, nil
}

func GetAllUsers() (models.UsersFile, error) {
	var users []models.User
	var user models.User
	rows, err := db.DBPool.Query(context.Background(), "SELECT * FROM users")
	if err != nil {
		return models.UsersFile{}, err
	}
	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&user.Id, &user.Email, &user.Password, &user.FirstName, &user.LastName, &user.UserName, &user.DisplayName, &user.Deleted, &user.PhoneNumber, &user.ProfilePicture, &user.Role, &user.CreatedAt, &user.UpdatedAt)
		if err != nil {
			if err == pgx.ErrNoRows {
				return models.UsersFile{}, ErrUserNotFound
			}
			return models.UsersFile{}, err
		}
		users = append(users, user)
	}
	return users, nil
}
