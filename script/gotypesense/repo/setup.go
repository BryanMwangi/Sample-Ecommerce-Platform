package repo

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"script/config"
	"script/gotypesense"
	"script/gotypesense/models"
	"time"

	"github.com/BryanMwangi/logger/v3"
	"github.com/typesense/typesense-go/v2/typesense"
	"github.com/typesense/typesense-go/v2/typesense/api"
	"github.com/typesense/typesense-go/v2/typesense/api/pointer"
)

func CreateCollection(ctx context.Context) error {
	schema := &api.CollectionSchema{
		Name: "items",
		Fields: []api.Field{
			{Name: "id", Type: "string"},
			{Name: "storeId", Type: "int32"},
			{Name: "price", Type: "float"},
			{Name: "name", Type: "string"},
			{Name: "imageUrl", Type: "string"},
			{Name: "category", Type: "string"},
			{Name: "ingredients", Type: "string[]"},
			{Name: "store", Type: "object"},
		},
		EnableNestedFields: pointer.True(),
	}

	response, err := gotypesense.TypeSenseClient.Collections().Create(ctx, schema)
	if err != nil {
		logger.Error("Error creating collection: " + err.Error())
		return err
	}

	logger.Info("Collection created: " + response.Name)
	return nil
}

func InsertIntoCollection(ctx context.Context) error {
	var posts []models.Post
	if _, err := os.Stat(LocalPostsFile); os.IsNotExist(err) {
		logger.Error(err.Error())
		return err
	}
	//if the file exists, read its contents
	postData, err := os.ReadFile(LocalPostsFile)
	if err != nil {
		logger.Error(err.Error())
		return err
	}

	if err := json.Unmarshal(postData, &posts); err != nil {
		logger.Error(err.Error())
		return err
	}

	for _, post := range posts {
		_, err := gotypesense.TypeSenseClient.Collection("items").Documents().Upsert(ctx, post)
		if err != nil {
			logger.Error(err.Error())
			return err
		}
		// we construct the post with the store
	}
	return nil
}

func Search(ctx context.Context) error {
	type Store struct {
		ID             int    `json:"id"`
		Name           string `json:"name"`
		Type           string `json:"type"`
		ProfilePicture string `json:"profilePicture"`
	}

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
	searchParameters := &api.SearchCollectionParams{
		Q:       pointer.String("Pizza Florida"),
		QueryBy: pointer.String("name, category"),
	}
	_, err := typesense.GenericCollection[*Post](gotypesense.TypeSenseClient, "items").Documents().Search(context.Background(), searchParameters)
	if err != nil {
		logger.Error(err.Error())
		return err
	}

	return nil
}

func DeleteAllKeys(ctx context.Context) error {
	_, err := gotypesense.TypeSenseClient.Key(1).Delete(context.Background())
	if err != nil {
		logger.Error(err.Error())
		return err
	}
	return nil
}

func CreateClientAPIKey(ctx context.Context) error {
	expiry := time.Now().AddDate(0, 6, 0).Unix()
	KEY := config.GoDotEnvVariable("TYPESENSE_SEARCH_ONLY_KEY")

	keySchema := &api.ApiKeySchema{
		Description: "Search-only key.",
		Actions:     []string{"documents:search"},
		Collections: []string{"items"},
		ExpiresAt:   &expiry,
		Value:       &KEY,
	}

	newKey, err := gotypesense.TypeSenseClient.Keys().Create(context.Background(), keySchema)
	if err != nil {
		logger.Error(err.Error())
		return err
	}
	fmt.Println("New API Key created: ", *newKey.Value)
	return nil
}

func GetAllKeys(ctx context.Context) ([]*api.ApiKey, error) {
	keys, err := gotypesense.TypeSenseClient.Keys().Retrieve(context.Background())
	if err != nil {
		logger.Error(err.Error())
		return nil, err
	}

	for _, key := range keys {
		fmt.Printf("API Key: %v, Actions: %v, Collections: %v", key.Description, key.Actions, key.Collections)
		// Note: key.Value will be nil when retrieved later.
	}

	return keys, nil
}
