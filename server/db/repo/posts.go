package repo

import (
	"context"
	"errors"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
)

var (
	ErrPostNotFound = errors.New("post not found")
)

// here we will get a list of posts with their categories and ingredients
// we will employ pagination to have a feel of infinite scroll on the frontend
// we will fetch 10 posts at a time
func GetPosts(ctx context.Context, page int) ([]models.Post, error) {
	var posts []models.Post
	limit := 30 // Fetch 30 posts at a time
	offset := (page - 1) * limit
	query := `
        SELECT p.*, s.* 
        FROM posts p
        JOIN stores s ON p.store = s.id
        LIMIT $1 OFFSET $2`
	rows, err := db.DBPool.Query(ctx, query, limit, offset)
	if err != nil {
		return posts, err
	}
	defer rows.Close()
	for rows.Next() {
		var post models.Post
		var store models.Store
		err := rows.Scan(&post.Id, &post.StoreId, &post.Price, &post.Image, &post.Type, &post.Likes, &post.ImageUrl, &post.Name,
			&store.Id, &store.UUID, &store.Name, &store.ProfilePicture, &store.CreatedAt, &store.UpdatedAt, &store.Type)
		if err != nil {
			return posts, err
		}

		// Handle Likes
		if post.Likes.Valid {
			post.LikeCount = post.Likes.Int64
		} else {
			post.LikeCount = 0
		}

		// Set store fields as needed
		store.UUID = uuid.Nil
		store.CreatedAt = ""
		store.UpdatedAt = ""

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

func GetPostsByCategory(ctx context.Context, page int, category string) ([]models.Post, error) {
	var posts []models.Post
	limit := 30 // Fetch 30 posts at a time
	offset := (page - 1) * limit
	query := `
        SELECT p.*, s.*
		FROM posts p
		JOIN post_categories pc ON p.id = "pc"."postId"
		JOIN categories c ON "pc"."categoryId" = c.id
		JOIN stores s ON p.store = s.id
		WHERE c.name = $1
        LIMIT $2 OFFSET $3`
	rows, err := db.DBPool.Query(ctx, query, category, limit, offset)
	if err != nil {
		return posts, err
	}
	defer rows.Close()
	for rows.Next() {
		var post models.Post
		var store models.Store
		err := rows.Scan(&post.Id, &post.StoreId, &post.Price, &post.Image, &post.Type, &post.Likes, &post.ImageUrl, &post.Name,
			&store.Id, &store.UUID, &store.Name, &store.ProfilePicture, &store.CreatedAt, &store.UpdatedAt, &store.Type)
		if err != nil {
			return posts, err
		}

		// Handle Likes
		if post.Likes.Valid {
			post.LikeCount = post.Likes.Int64
		} else {
			post.LikeCount = 0
		}

		// Set store fields as needed
		store.UUID = uuid.Nil
		store.CreatedAt = ""
		store.UpdatedAt = ""

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

func GetPostById(ctx context.Context, id int) (models.Post, error) {
	var post models.Post
	row := db.DBPool.QueryRow(ctx, `SELECT id, store, price, image, type, likes, "imageUrl", name FROM posts WHERE id=$1`, id)
	err := row.Scan(&post.Id, &post.StoreId, &post.Price, &post.Image, &post.Type, &post.Likes, &post.ImageUrl, &post.Name)
	if err != nil {
		if err == pgx.ErrNoRows {
			return models.Post{}, ErrPostNotFound
		}
		return models.Post{}, err
	}
	// Fetch the categories for the post
	categories, err := GetCategoryForPost(ctx, post.Id)
	if err != nil {
		return models.Post{}, err
	}
	ingredients, err := GetIngredientsForPost(ctx, post.Id)
	if err != nil {
		return models.Post{}, err
	}
	store, err := GetStoreForPost(ctx, post.Id)
	if err != nil {
		return models.Post{}, err
	}
	post.Type = uuid.Nil
	post.Store = store
	post.Ingredients = ingredients
	post.Category = categories[0]
	if post.Likes.Valid {
		post.LikeCount = post.Likes.Int64
	} else {
		post.LikeCount = 0
	}
	post.Currency = "USD"
	return post, nil
}
