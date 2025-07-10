package repo

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"os"
	"script/db"
	"script/db/models"

	"github.com/BryanMwangi/logger/v3"
	"github.com/google/uuid"
)

var (
	PostFile   = "./data/items.json"
	Categories = []string{"pizza",
		"burger",
		"sushi",
		"frozen_meal",
		"appetizer",
		"dessert",
		"pastry"}
)

func SavePost(post models.Post, ctx context.Context) error {
	var categoryId uuid.UUID
	err := db.DB.QueryRow(ctx, `SELECT id FROM categories WHERE name = $1`, post.Type).Scan(&categoryId)
	if err != nil {
		return fmt.Errorf("error finding category: %w", err)
	}
	_, err = db.DB.Exec(ctx,
		`INSERT INTO posts (id, name, price, "image", "type", "store", "imageUrl") 
		VALUES ($1, $2, $3, $4, $5, $6, $7)`,
		post.ID,
		post.Name,
		post.Price,
		post.Image,
		categoryId,
		post.Store,
		post.ImageUrl,
	)
	if err != nil {
		return fmt.Errorf("error creating post: %w", err)
	}

	// Now, link the post with the category in the post_categories table
	_, err = db.DB.Exec(ctx,
		`INSERT INTO post_categories ("postId", "categoryId") VALUES ($1, $2)`,
		post.ID,
		categoryId,
	)
	if err != nil {
		return fmt.Errorf("error linking post with category: %w", err)
	}

	return nil
}

func SaveIngredientsToDB(ingredients []models.Ingredient, ctx context.Context) error {
	for _, ingredient := range ingredients {
		var ingredientID int

		// Check if the ingredient already exists in the 'ingredients' table
		err := db.DB.QueryRow(ctx,
			`SELECT id FROM ingredients WHERE name = $1`, ingredient.Ingredient,
		).Scan(&ingredientID)

		if err != nil {
			if err == sql.ErrNoRows || err.Error() == "no rows in result set" {
				// Insert the new ingredient into 'ingredients' table
				err = db.DB.QueryRow(ctx,
					`INSERT INTO ingredients (name) VALUES ($1) RETURNING id`, ingredient.Ingredient).Scan(&ingredientID)
				if err != nil {
					return fmt.Errorf("error inserting new ingredient: %w", err)
				}
			} else {
				// Return other unexpected errors
				return fmt.Errorf("error checking ingredient existence: %w", err)
			}
		}
		// Now, insert the relationship into the 'post_ingredients' table
		_, err = db.DB.Exec(ctx,
			`INSERT INTO post_ingredients ("postId", ingredient_id) 
			VALUES ($1, $2)`,
			ingredient.PostID, ingredientID)

		if err != nil {
			//lets skip over duplicate key errors
			if err.Error() != "duplicate key value violates unique constraint \"post_ingredients_pkey\"" {
				continue
			}

			return fmt.Errorf("error linking post to ingredient: %w", err)
		}
	}
	return nil
}

func SaveCategories(ctx context.Context) error {
	for _, category := range Categories {
		_, err := db.DB.Exec(ctx, `INSERT INTO categories (name) 
		VALUES ($1)`,
			category,
		)

		if err != nil {
			return fmt.Errorf("error inserting category: %w", err)
		}
	}
	return nil
}

func SavePostsToDB(ctx context.Context) error {
	var posts []models.Post
	if _, err := os.Stat(PostFile); os.IsNotExist(err) {
		logger.Error(err.Error())
		return err
	} else {
		//if the file exists, read its contents
		postData, err := os.ReadFile(PostFile)
		if err != nil {
			logger.Error(err.Error())
			return err
		}
		if err := json.Unmarshal(postData, &posts); err != nil {
			logger.Error(err.Error())
			return err
		}
	}

	for _, post := range posts {
		// if err := SavePost(post, ctx); err != nil {
		// 	logger.Error(err.Error())
		// 	return err
		// }
		// fmt.Println("saving post...", post.Name)
		//construct ingredients
		ingredients := post.Ingredients
		var saveIngredients []models.Ingredient
		for _, ingredient := range ingredients {
			fmt.Println("saving ingredient...", ingredient)
			newIngredient := models.Ingredient{
				PostID:     post.ID,
				Ingredient: ingredient,
			}
			saveIngredients = append(saveIngredients, newIngredient)
		}
		if err := SaveIngredientsToDB(saveIngredients, ctx); err != nil {
			logger.Error(err.Error())
			return err
		}
	}
	return nil
}
