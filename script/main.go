package main

import (
	"context"
	"script/gotypesense"
	"script/gotypesense/repo"
)

func main() {
	ctx := context.Background()
	gotypesense.InitializeClient()
	err := repo.CreateClientAPIKey(ctx)
	if err != nil {
		panic(err)
	}
	_, err = repo.GetAllKeys(ctx)
	if err != nil {
		panic(err)
	}

}
