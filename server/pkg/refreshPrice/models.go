package refreshprice

type response struct {
	Menu []item `json:"menu"`
}
type item struct {
	Id          int      `json:"id"`
	Name        string   `json:"name"`
	Type        string   `json:"type"`
	Image       string   `json:"image"`
	Price       float64  `json:"price"`
	Ingredients []string `json:"ingredients"`
}

type NewPrice struct {
	Id    int     `json:"id"`
	Price float64 `json:"price"`
}
