package db

import (
	"context"
	"os"
	"script/config"

	"github.com/BryanMwangi/logger/v3"
	"github.com/jackc/pgx/v5"
)

var (
	DATABASE_URL = config.GoDotEnvVariable("DATABASE_URL")

	DB *pgx.Conn
)

func ConnectToDB(ctx context.Context) {
	logger.Warning("Connecting to postgres...")
	conn, err := pgx.Connect(ctx, DATABASE_URL)
	if err != nil {
		logger.Error("Error connecting to postgres " + err.Error())
		os.Exit(1)
	}

	logger.Success("Connected to postgres!")
	DB = conn
}

func ShutDownClient(ctx context.Context) {
	DB.Close(ctx)
}
