package models

import (
	"time"

	"github.com/google/uuid"
)

type User struct {
	Id             uuid.UUID `json:"id"`
	Email          string    `json:"email"`
	Password       string    `json:"password"`
	FirstName      string    `json:"firstName"`
	LastName       string    `json:"lastName"`
	UserName       string    `json:"userName"`
	DisplayName    string    `json:"displayName"`
	Deleted        bool      `json:"deleted"`
	CreatedAt      time.Time `json:"createdAt"`
	UpdatedAt      time.Time `json:"updatedAt"`
	Role           string    `json:"role"`
	PhoneNumber    string    `json:"phoneNumber"`
	ProfilePicture string    `json:"profilePicture"`
}

type Supplier struct {
	Name string `json:"name"`
	Uid  string `json:"uid"`
}

type Store struct {
	ID             int                   `json:"id"`
	UID            string                `json:"uid"`
	Name           string                `json:"name"`
	Type           string                `json:"type"`
	ProfilePicture string                `json:"image"`
	WorkingHours   TemporaryWorkingHours `json:"workingHours"`
	CreatedAt      time.Time             `json:"createdAt"`
	UpdatedAt      time.Time             `json:"updatedAt"`
}

type TemporaryWorkingHours struct {
	Opening string `json:"opening"`
	Closing string `json:"closing"`
}

type WorkingHours struct {
	ID      uuid.UUID `json:"id"`
	StoreID int       `json:"storeId"`
	Opening string    `json:"opening"`
	Closing string    `json:"closing"`
	Day     string    `json:"day"`
	IsOpen  bool      `json:"isOpen"`
}

type Post struct {
	ID          int      `json:"id"`
	Name        string   `json:"name"`
	Price       float64  `json:"price"`
	Image       string   `json:"image"`
	Type        string   `json:"type"`
	Ingredients []string `json:"ingredients"`
	Store       int      `json:"store"`
	ImageUrl    string   `json:"imageUrl"`
}

type Ingredient struct {
	PostID     int    `json:"postId"`
	Ingredient string `json:"ingredient"`
}
