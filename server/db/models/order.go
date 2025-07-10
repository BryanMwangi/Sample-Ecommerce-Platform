package models

import (
	"database/sql"
	"time"
)

type OrderItem struct {
	Id          int      `json:"id"`
	StoreId     int      `json:"storeId"`
	Price       float64  `json:"price"`
	Image       string   `json:"image"`
	Name        string   `json:"name"`
	LikeCount   int64    `json:"likes"`
	ImageUrl    string   `json:"imageUrl"`
	Type        string   `json:"type"`
	Ingredients []string `json:"ingredients"`
	Category    string   `json:"category"`
	Store       Store    `json:"store"`
	Currency    string   `json:"currency"`
	Likes       sql.NullInt64
}

type Address struct {
	Id        int       `json:"id"`
	Uid       string    `json:"uid"`
	Latitude  float64   `json:"latitude"`
	Longitude float64   `json:"longitude"`
	Street    string    `json:"street"`
	City      string    `json:"city"`
	State     string    `json:"state"`
	Zip       string    `json:"zip"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}

type AddressRequest struct {
	Latitude  float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
	Street    string  `json:"street"`
	City      string  `json:"city"`
	State     string  `json:"state"`
	Zip       string  `json:"zip"`
}

type Order struct {
	Id        int         `json:"id"`
	Uid       string      `json:"uid"`
	StoreId   int64       `json:"storeId"`
	AddressId int         `json:"addressId"`
	Total     float64     `json:"total"`
	Currency  string      `json:"currency"`
	Status    string      `json:"status"`
	CreatedAt time.Time   `json:"createdAt"`
	UpdatedAt time.Time   `json:"updatedAt"`
	Items     []OrderItem `json:"items"`
}

type OrderRequest struct {
	StoreId   int64   `json:"storeId"`
	AddressId int     `json:"addressId"`
	ItemIds   []int64 `json:"itemIds"`
}
