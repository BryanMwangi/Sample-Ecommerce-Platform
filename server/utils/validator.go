package utils

import (
	"fmt"
	"regexp"
	"strings"
)

func ValidateName(name string) (bool, string, error) {
	// Define the regex patterns
	nameRegex := `^[A-Za-z\s'-À-ÖØ-öø-ÿ]+$`
	sanitizerRegex := `[\/\?<>\\:\*\|":]`

	// Compile the regex for illegal characters
	sanitizerRe, err := regexp.Compile(sanitizerRegex)
	if err != nil {
		return false, "", fmt.Errorf("failed to compile sanitizer regex: %v", err)
	}

	// Remove illegal characters
	sanitizedString := sanitizerRe.ReplaceAllString(name, "")

	// Compile the regex for name validation
	re, err := regexp.Compile(nameRegex)
	if err != nil {
		return false, "", fmt.Errorf("failed to compile name regex: %v", err)
	}

	if re.MatchString(sanitizedString) {
		// Check if the sanitized string is empty
		if sanitizedString == "" {
			return false, "", fmt.Errorf("name contains only illegal characters")
		}
		return true, sanitizedString, nil
	} else {
		return false, "", fmt.Errorf("name contains only illegal characters")
	}
}

func SplitName(name string) (string, string) {
	split := strings.Split(name, " ")
	if len(split) > 1 {
		firstName := split[0]
		lastName := split[len(split)-1]
		return firstName, lastName
	}
	return name, "" // Handle cases where there's only one name part
}

func ValidateEmail(email string) (bool, string, error) {
	// Define the regex patterns
	emailRegex := `^[a-zA-Z0-9.!#$%&'*+/=?^_` + "`" + `{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$`

	// Compile the regex for email validation
	re, err := regexp.Compile(emailRegex)
	if err != nil {
		return false, "", fmt.Errorf("failed to compile email regex: %v", err)
	}

	if re.MatchString(email) {
		// Check if the email is empty
		if email == "" {
			return false, "", fmt.Errorf("email is empty")
		}
		return true, email, nil
	} else {
		return false, "", fmt.Errorf("email is invalid")
	}
}
