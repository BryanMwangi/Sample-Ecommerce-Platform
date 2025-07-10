package repo

import (
	"context"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
)

func GetAllCategories(ctx context.Context) ([]models.Category, error) {
	var categories []models.Category
	var category models.Category
	rows, err := db.DBPool.Query(ctx, "SELECT * FROM categories")
	if err != nil {
		return categories, err
	}
	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&category.Id, &category.Name)
		if err != nil {
			if err == pgx.ErrNoRows {
				return categories, ErrPostNotFound
			}
			return categories, err
		}
		category.Id = uuid.Nil
		categories = append(categories, category)
	}
	return categories, nil
}

func GetCategoryForPost(ctx context.Context, postId int) ([]string, error) {
	var categories []models.Category
	var category models.Category
	rows, err := db.DBPool.Query(ctx,
		`SELECT c.name
		FROM post_categories pc
		JOIN categories c ON "pc"."categoryId" = c.id
		WHERE "pc"."postId" = $1`, postId)
	if err != nil {
		return []string{}, err
	}
	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&category.Name)
		if err != nil {
			if err == pgx.ErrNoRows {
				return []string{}, ErrPostNotFound
			}
			return []string{}, err
		}
		categories = append(categories, category)
	}
	var categoriesNames []string
	for _, category := range categories {
		categoriesNames = append(categoriesNames, category.Name)
	}
	return categoriesNames, nil
}
