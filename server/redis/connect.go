package goredis

import (
	"context"

	"github.com/BryanMwangi/pine/logger"
	"github.com/redis/go-redis/v9"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/config"
)

var (
	RedisClient *redis.Client
)

func InitializeClient(ctx context.Context) {
	// Start redis client
	RedisClient = NewRedis(ctx)
}

func NewRedis(ctx context.Context) *redis.Client {
	// Create a new Redis client
	logger.Warning("Connecting to redis...")
	rdb := redis.NewClient(&redis.Options{
		Addr:     config.GoDotEnvVariable("REDIS_URL"),
		Password: config.GoDotEnvVariable("REDIS_PASSWORD"),
	})

	// Ping the server to check the connection
	err := rdb.Ping(ctx).Err()
	if err != nil {
		logger.Error("err connecting to redis")
		return nil
	}
	logger.Success("Connected to redis!")
	return rdb
}
