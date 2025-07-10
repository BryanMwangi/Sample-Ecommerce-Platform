package repo

import (
	"context"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
)

func GetStoreForPost(ctx context.Context, postId int) (models.Store, error) {
	var store models.Store
	row := db.DBPool.QueryRow(ctx,
		`SELECT s.*
		FROM stores s
		JOIN posts p ON s.id = p.store
		WHERE p.id = $1`, postId)
	err := row.Scan(&store.Id, &store.UUID, &store.Name, &store.ProfilePicture, &store.CreatedAt, &store.UpdatedAt, &store.Type)
	if err != nil {
		if err == pgx.ErrNoRows {
			return models.Store{}, ErrPostNotFound
		}
		return models.Store{}, err
	}
	// we need to remove the uuid from the store
	store.UUID = uuid.Nil
	// obfuscate the createdAt and updatedAt
	store.CreatedAt = ""
	store.UpdatedAt = ""
	return store, nil
}

func FetchAllStores(ctx context.Context) ([]models.Store, error) {
	var stores []models.Store
	var store models.Store
	rows, err := db.DBPool.Query(ctx, "SELECT * FROM stores")
	if err != nil {
		return stores, err
	}
	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&store.Id, &store.UUID, &store.Name, &store.ProfilePicture, &store.CreatedAt, &store.UpdatedAt, &store.Type)
		if err != nil {
			if err == pgx.ErrNoRows {
				return stores, ErrPostNotFound
			}
			return stores, err
		}
		store.UUID = uuid.Nil
		store.CreatedAt = ""
		store.UpdatedAt = ""
		stores = append(stores, store)
	}
	return stores, nil
}

func GetStoreById(ctx context.Context, id int) (models.Store, error) {
	var store models.Store
	row := db.DBPool.QueryRow(ctx, `SELECT id, uid, name, "profilePicture", "createdAt", "updatedAt", type FROM stores WHERE id=$1`, id)
	err := row.Scan(&store.Id, &store.UUID, &store.Name, &store.ProfilePicture, &store.CreatedAt, &store.UpdatedAt, &store.Type)
	if err != nil {
		if err == pgx.ErrNoRows {
			return models.Store{}, ErrPostNotFound
		}
		return models.Store{}, err
	}
	store.UUID = uuid.Nil
	store.CreatedAt = ""
	store.UpdatedAt = ""
	return store, nil
}

func GetStorePosts(ctx context.Context, storeId int) ([]models.Post, error) {
	var posts []models.Post
	var post models.Post
	rows, err := db.DBPool.Query(ctx,
		`SELECT p.*, s.*, c.name 
		FROM posts p
		JOIN stores s ON p.store = s.id
		JOIN post_categories pc ON p.id = pc."postId"
		JOIN categories c ON pc."categoryId" = c.id
		WHERE p.store = $1`, storeId)
	if err != nil {
		return posts, err
	}
	defer rows.Close()
	for rows.Next() {
		var store models.Store
		err := rows.Scan(&post.Id, &post.StoreId, &post.Price, &post.Image, &post.Type, &post.Likes, &post.ImageUrl, &post.Name,
			&store.Id, &store.UUID, &store.Name, &store.ProfilePicture, &store.CreatedAt, &store.UpdatedAt, &store.Type,
			&post.Category)
		if err != nil {
			return posts, err
		}
		post.Store = store
		if post.Likes.Valid {
			post.LikeCount = post.Likes.Int64
		} else {
			post.LikeCount = 0
		}
		post.Currency = "USD"
		posts = append(posts, post)
	}
	return posts, nil
}
