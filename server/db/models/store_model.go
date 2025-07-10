package models

import "github.com/google/uuid"

type WorkingHours struct {
	ID      int64  `json:"id"`
	Opening string `json:"opening"`
	Closing string `json:"closing"`
	Day     string `json:"day"`
	IsOpen  bool   `json:"isOpen"`
	StoreId int    `json:"storeId"`
}

type Store struct {
	Id             int       `json:"id"`
	UUID           uuid.UUID `json:"uuid"`
	Name           string    `json:"name"`
	ProfilePicture string    `json:"profilePicture"`
	CreatedAt      string    `json:"createdAt"`
	UpdatedAt      string    `json:"updatedAt"`
	Type           string    `json:"type"`
}

type StoreResponse struct {
	Id             int          `json:"id"`
	UUID           uuid.UUID    `json:"uuid"`
	Name           string       `json:"name"`
	ProfilePicture string       `json:"profilePicture"`
	WorkingHours   WorkingHours `json:"workingHours"`
	CreatedAt      string       `json:"createdAt"`
	UpdatedAt      string       `json:"updatedAt"`
	Type           string       `json:"type"`
}
