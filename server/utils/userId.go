package utils

import (
	"github.com/google/uuid"
)

func GenerateId() uuid.UUID {
	return uuid.New()
}
