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

type UserResponse struct {
	Email          string `json:"email"`
	FirstName      string `json:"firstName"`
	LastName       string `json:"lastName"`
	UserName       string `json:"userName"`
	DisplayName    string `json:"displayName"`
	PhoneNumber    string `json:"phoneNumber"`
	ProfilePicture string `json:"profilePicture"`
}

type UsersFile []User

type UserSignUpRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
	UserName string `json:"userName"`
	Name     string `json:"name"`
}
type UserLoginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type Claims struct {
	Uid         uuid.UUID
	DisplayName string
}

type ResetClaims struct {
	Email string
}
