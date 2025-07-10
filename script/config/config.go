package config

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

func GoDotEnvVariable(key string) string {
	// Check if the application is running in production
	production := os.Getenv("PRODUCTION")

	if production == "true" {
		// Running in production, use environment variables directly
		return os.Getenv(key)
	}

	// Load .env file for local development
	err := godotenv.Load("./Config/.env")
	if err != nil {
		log.Println("Error loading .env file")
		// Handle the error, e.g., use default values or terminate the application
	}

	return os.Getenv(key)
}
