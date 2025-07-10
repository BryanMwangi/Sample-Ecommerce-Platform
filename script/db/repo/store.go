package repo

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"script/db"
	"script/db/models"
	"time"

	"github.com/BryanMwangi/logger/v3"
	"github.com/google/uuid"
)

var (
	DAYS_OF_THE_WEEK = []string{"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}
	StoreFile        = "./data/stores.json"
)

// we now construct random working days based on the operating hours
// of the store as from the store file data
func ConstructWorkingDays(store models.Store) ([]models.WorkingHours, error) {
	opening := store.WorkingHours.Opening
	closing := store.WorkingHours.Closing

	var workingHours []models.WorkingHours

	for i := 0; i < 7; i++ {
		var workingHour models.WorkingHours
		workingHour.ID = uuid.New()
		workingHour.StoreID = store.ID
		workingHour.Day = DAYS_OF_THE_WEEK[i]
		workingHour.Opening = opening
		workingHour.Closing = closing
		workingHour.IsOpen = true

		workingHours = append(workingHours, workingHour)
	}

	return workingHours, nil
}

func SaveStore(store models.Store, ctx context.Context) error {
	_, err := db.DB.Exec(ctx,
		`INSERT INTO stores (id, uid, name, "profilePicture","type", "createdAt", "updatedAt") 
		VALUES ($1, $2, $3, $4, $5, $6, $7)`,
		store.ID,
		store.UID,
		store.Name,
		store.ProfilePicture,
		store.Type,
		time.Now(),
		time.Now(),
	)
	if err != nil {
		return fmt.Errorf("error creating store: %w", err)
	}
	return nil
}
func SaveWorkingHours(hours []models.WorkingHours, ctx context.Context) error {
	for _, h := range hours {
		_, err := db.DB.Exec(ctx,
			`INSERT INTO "workingHours"("storeId",opening,closing,day,"isOpen")
		VALUES($1,$2,$3,$4,$5)`,
			h.StoreID,
			h.Opening,
			h.Closing,
			h.Day,
			h.IsOpen,
		)
		if err != nil {
			return err
		}
	}
	return nil
}

func SaveStoresToDB(ctx context.Context) error {
	var stores []models.Store
	if _, err := os.Stat(StoreFile); os.IsNotExist(err) {
		logger.Error(err.Error())
		return err
	} else {
		//if the file exists, read its contents
		storeData, err := os.ReadFile(StoreFile)
		if err != nil {
			logger.Error(err.Error())
			return err
		}
		if err := json.Unmarshal(storeData, &stores); err != nil {
			logger.Error(err.Error())
			return err
		}
	}
	for _, store := range stores {
		workingDays, err := ConstructWorkingDays(store)
		if err != nil {
			logger.Error(err.Error())
			return err
		}
		//we first save the store to the database
		if err := SaveStore(store, ctx); err != nil {
			logger.Error(err.Error())
			return err
		}
		//we then save the working hours
		if err := SaveWorkingHours(workingDays, ctx); err != nil {
			logger.Error(err.Error())
			return err
		}
	}
	return nil
}

func UpdateStore(store models.Store, ctx context.Context) error {
	_, err := db.DB.Exec(ctx,
		`UPDATE stores SET "profilePicture" = $1 WHERE id = $2`,
		store.ProfilePicture,
		store.ID,
	)
	if err != nil {
		return fmt.Errorf("error updating store: %w", err)
	}
	return nil
}

func UpdateStores(ctx context.Context) error {
	var stores []models.Store
	if _, err := os.Stat(StoreFile); os.IsNotExist(err) {
		logger.Error(err.Error())
		return err
	} else {
		//if the file exists, read its contents
		storeData, err := os.ReadFile(StoreFile)
		if err != nil {
			logger.Error(err.Error())
			return err
		}
		if err := json.Unmarshal(storeData, &stores); err != nil {
			logger.Error(err.Error())
			return err
		}
	}
	for _, store := range stores {
		//we only update the stores profile picture
		if err := UpdateStore(store, ctx); err != nil {
			logger.Error(err.Error())
			return err
		}
	}
	return nil
}
