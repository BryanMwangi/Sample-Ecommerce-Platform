package models

type Post struct {
	ID          string   `json:"id"`
	StoreID     int      `json:"storeId"`
	Price       float64  `json:"price"`
	Name        string   `json:"name"`
	ImageUrl    string   `json:"imageUrl"`
	Category    string   `json:"category"`
	Ingredients []string `json:"ingredients"`
	Store       Store    `json:"store"`
}

type Store struct {
	ID             int    `json:"id"`
	Name           string `json:"name"`
	Type           string `json:"type"`
	ProfilePicture string `json:"profilePicture"`
}
