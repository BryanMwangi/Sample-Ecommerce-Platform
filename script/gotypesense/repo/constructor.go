package repo

import (
	"encoding/json"
	"os"
	"script/gotypesense/models"

	"github.com/BryanMwangi/logger/v3"
)

var (
	PostFile       = "./data/items.json"
	StoresFile     = "./data/typesense_stores.json"
	LocalPostsFile = "./data/typesense_posts.json"
)

func SavePost(posts []models.Post) error {
	// we save the posts locally first
	jsonData, err := json.Marshal(posts)
	if err != nil {
		logger.Error(err.Error())
		return err
	}
	err = os.WriteFile(LocalPostsFile, jsonData, 0644)
	if err != nil {
		logger.Error(err.Error())
		return err
	}
	return nil
}

func ContsructPost() error {
	var posts []models.Post
	var stores []models.Store
	if _, err := os.Stat(PostFile); os.IsNotExist(err) {
		logger.Error(err.Error())
		return err
	}
	if _, err := os.Stat(StoresFile); os.IsNotExist(err) {
		logger.Error(err.Error())
		return err
	}
	//if the file exists, read its contents
	postData, err := os.ReadFile(PostFile)
	if err != nil {
		logger.Error(err.Error())
		return err
	}
	storeData, err := os.ReadFile(StoresFile)
	if err != nil {
		logger.Error(err.Error())
		return err
	}

	if err := json.Unmarshal(postData, &posts); err != nil {
		logger.Error(err.Error())
		return err
	}
	if err := json.Unmarshal(storeData, &stores); err != nil {
		logger.Error(err.Error())
		return err
	}

	storeMap := make(map[int]models.Store)
	for _, store := range stores {
		storeMap[store.ID] = store
	}

	for i, post := range posts {
		// we construct the post with the store
		if store, found := storeMap[post.StoreID]; found {
			post.Store = store
			posts[i] = post
		} else {
			logger.Error("error finding store for post " + post.Name)
			return err
		}
	}
	// we save the posts locally first
	err = SavePost(posts)
	if err != nil {
		logger.Error(err.Error())
		return err
	}
	return nil
}
