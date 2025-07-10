package auth

import (
	"math/rand"
)

func GenerateCode() int {
	code := 100000 + rand.Intn(900000)
	return code
}

func CompareCode(code int, savedCode int) bool {
	return code == savedCode
}
