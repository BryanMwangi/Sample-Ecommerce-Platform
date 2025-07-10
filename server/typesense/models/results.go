package typesenseModels

type TypeSenseResult struct {
	ID          string         `json:"id"`
	StoreID     int            `json:"storeId"`
	Price       float64        `json:"price"`
	Name        string         `json:"name"`
	ImageUrl    string         `json:"imageUrl"`
	Category    string         `json:"category"`
	Ingredients []string       `json:"ingredients"`
	Store       TypeSenseStore `json:"store"`
}

type TypeSenseStore struct {
	ID             int    `json:"id"`
	Name           string `json:"name"`
	Type           string `json:"type"`
	ProfilePicture string `json:"profilePicture"`
}
