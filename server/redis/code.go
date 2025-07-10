package goredis

import (
	"context"
	"encoding/json"
	"time"

	"github.com/BryanMwangi/pine/logger"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
)

func GetCode(ctx context.Context, email string) (models.Code, error) {
	rdb := RedisClient
	if rdb == nil {
		return models.Code{}, nil
	}

	jsonCode, err := rdb.Get(ctx, email).Result()
	if err != nil {
		logger.Error("Error getting code from redis: " + err.Error())
		return models.Code{}, err
	}

	var code models.Code
	err = json.Unmarshal([]byte(jsonCode), &code)
	if err != nil {
		logger.Error("Error unmarshaling code from JSON: " + err.Error())
		return models.Code{}, err
	}
	return code, nil
}

func SaveCode(ctx context.Context, code models.Code) error {
	rdb := RedisClient
	if rdb == nil {
		return nil
	}

	jsonCode, err := json.Marshal(code)
	if err != nil {
		logger.Error("Error marshaling code to JSON: " + err.Error())
		return err
	}

	_, err = rdb.Set(ctx, code.Email, jsonCode, 15*time.Minute).Result()
	if err != nil {
		logger.Error("Error saving code to redis: " + err.Error())
		return err
	}
	return nil
}
