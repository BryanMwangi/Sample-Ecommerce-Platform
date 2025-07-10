package repo

import (
	"context"

	"github.com/jackc/pgx/v5"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
)

func CreateAddress(ctx context.Context, address models.AddressRequest, uid string) error {
	newAdress := models.Address{
		Latitude:  address.Latitude,
		Longitude: address.Longitude,
		Street:    address.Street,
		City:      address.City,
		State:     address.State,
		Zip:       address.Zip,
	}
	_, err := db.DBPool.Exec(ctx, `
	INSERT INTO addresses 
	(uid, latitude, longitude, street, city, state, zip, "createdAt", "updatedAt") 
	VALUES ($1, $2, $3, $4, $5, $6, $7, NOW(), NOW())`,
		uid, newAdress.Latitude, newAdress.Longitude, newAdress.Street, newAdress.City, newAdress.State, newAdress.Zip)
	if err != nil {
		return err
	}
	return nil
}

func GetAddressById(ctx context.Context, id int) (models.Address, error) {
	var address models.Address
	row := db.DBPool.QueryRow(ctx, "SELECT * FROM addresses WHERE id=$1", id)
	err := row.Scan(&address.Id, &address.Uid, &address.Latitude, &address.Longitude, &address.Street, &address.City, &address.State, &address.Zip, &address.CreatedAt, &address.UpdatedAt)
	if err != nil {
		if err == pgx.ErrNoRows {
			return models.Address{}, ErrPostNotFound
		}
		return models.Address{}, err
	}
	return address, nil
}

func FetchAllUserAddresses(ctx context.Context, uid string) ([]models.Address, error) {
	var addresses []models.Address
	rows, err := db.DBPool.Query(ctx, "SELECT * FROM addresses WHERE uid=$1", uid)
	if err != nil {
		return addresses, err
	}
	defer rows.Close()
	for rows.Next() {
		var address models.Address
		err := rows.Scan(&address.Id, &address.Uid, &address.Latitude, &address.Longitude, &address.Street, &address.City, &address.State, &address.Zip, &address.CreatedAt, &address.UpdatedAt)
		if err != nil {
			return addresses, err
		}
		addresses = append(addresses, address)
	}
	return addresses, nil
}
