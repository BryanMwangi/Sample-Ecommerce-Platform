package repo

import (
	"context"

	"github.com/jackc/pgx/v5"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
)

// we fetch the working hours for a specific store for a particular day
func GetWorkingHoursForStore(ctx context.Context, storeId int, day string) ([]models.WorkingHours, error) {
	var workingHours []models.WorkingHours
	var workingHour models.WorkingHours
	rows, err := db.DBPool.Query(ctx,
		`SELECT w.*
		FROM working_hours w
		WHERE w.day = $1 AND w."storeId" = $2`, day, storeId)
	if err != nil {
		return workingHours, err
	}
	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&workingHour.ID, &workingHour.StoreId, &workingHour.Opening, &workingHour.Closing, &workingHour.Day, &workingHour.IsOpen)
		if err != nil {
			if err == pgx.ErrNoRows {
				return workingHours, ErrPostNotFound
			}
			return workingHours, err
		}
		workingHours = append(workingHours, workingHour)
	}
	return workingHours, nil
}
