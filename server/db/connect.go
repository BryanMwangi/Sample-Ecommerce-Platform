package db

import (
	"context"
	"fmt"
	"os"

	"github.com/BryanMwangi/pine/logger"
	"github.com/jackc/pgx/v5/pgxpool"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/config"
)

var (
	DATABASE_URL = config.GoDotEnvVariable("DATABASE_URL")

	DBPool *pgxpool.Pool
)

func ConnectToDB(ctx context.Context) {
	fmt.Println("connecting to postgres...")
	pool, err := pgxpool.New(ctx, DATABASE_URL)
	if err != nil {
		logger.Error("Error connecting to postgres " + err.Error())
		os.Exit(1)
	}

	logger.Success("Connected to postgres!")
	DBPool = pool

}

func ShutDownClient(ctx context.Context) {
	DBPool.Close()
}
