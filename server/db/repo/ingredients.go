package repo

import (
	"context"

	"github.com/jackc/pgx/v5"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
)

func GetAllIngredients(ctx context.Context) ([]models.Ingredient, error) {
	var ingredients []models.Ingredient
	var ingredient models.Ingredient
	rows, err := db.DBPool.Query(ctx, "SELECT * FROM ingredients")
	if err != nil {
		return ingredients, err
	}
	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&ingredient.Id, &ingredient.Name)
		if err != nil {
			if err == pgx.ErrNoRows {
				return ingredients, ErrPostNotFound
			}
			return ingredients, err
		}
		ingredients = append(ingredients, ingredient)
	}
	return ingredients, nil
}

func GetIngredientsForPost(ctx context.Context, postId int) ([]string, error) {
	var ingredients []models.Ingredient
	var ingredient models.Ingredient
	rows, err := db.DBPool.Query(ctx,
		`SELECT i.name
		FROM post_ingredients pi
		JOIN ingredients i ON pi.ingredient_id = i.id
		WHERE "pi"."postId" =$1`, postId)
	if err != nil {
		return []string{}, err
	}

	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&ingredient.Name)
		if err != nil {
			if err == pgx.ErrNoRows {
				return []string{}, ErrPostNotFound
			}
			return []string{}, err
		}
		ingredients = append(ingredients, ingredient)
	}
	var ingredientsNames []string
	for _, ingredient := range ingredients {
		ingredientsNames = append(ingredientsNames, ingredient.Name)
	}
	return ingredientsNames, nil
}
