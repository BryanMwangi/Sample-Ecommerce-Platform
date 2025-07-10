package models

import (
	"database/sql"
	"time"

	"github.com/google/uuid"
)

type Post struct {
	Id          int       `json:"id"`
	StoreId     int       `json:"storeId"`
	Price       float64   `json:"price"`
	Image       string    `json:"image"`
	Name        string    `json:"name"`
	LikeCount   int64     `json:"likes"`
	ImageUrl    string    `json:"imageUrl"`
	Type        uuid.UUID `json:"type"`
	Ingredients []string  `json:"ingredients"`
	Category    string    `json:"category"`
	Store       Store     `json:"store"`
	Currency    string    `json:"currency"`
	Likes       sql.NullInt64
}

type PostCategory struct {
	PostId int    `json:"postId"`
	CatId  string `json:"categoryId"`
}

type PostIngredient struct {
	PostId int    `json:"postId"`
	IngId  string `json:"ingredientId"`
}

type Ingredient struct {
	Id   int    `json:"id"`
	Name string `json:"name"`
}
type Category struct {
	Id   uuid.UUID `json:"uuid"`
	Name string    `json:"name"`
}

type Likes struct {
	Id        uuid.UUID `json:"id"`
	PostId    int       `json:"postId"`
	Uid       uuid.UUID `json:"uid"`
	CreatedAt time.Time `json:"createdAt"`
}
