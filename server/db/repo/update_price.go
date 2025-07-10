package repo

import (
	"context"

	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db"
)

func UpdatePrice(ctx context.Context, id int, price float64) error {
	_, err := db.DBPool.Exec(ctx, `UPDATE posts SET price = $1 WHERE id = $2`, price, id)
	return err
}
