package auth

import (
	"fmt"
	"net/http"
	"time"

	"github.com/BryanMwangi/pine"
	"github.com/BryanMwangi/pine/logger"
	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/config"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
	"golang.org/x/crypto/bcrypt"
)

var (
	SECRET_KEY            = config.GoDotEnvVariable("SECRET_KEY")
	secretKey             = []byte(SECRET_KEY)
	AccessTokenTTL        = 168 * time.Hour
	RefreshTokenTTL       = 730 * time.Hour
	ResetPasswordTokenTTL = 15 * time.Minute
)

func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
}

func CheckPasswordHash(password, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}

func CreateToken(uid uuid.UUID, displayName string) (string, error) {
	token := jwt.NewWithClaims(jwt.SigningMethodHS256,
		jwt.MapClaims{
			"uid":         uid,
			"displayName": displayName,
			"exp":         time.Now().Add(AccessTokenTTL).Unix(),
		})

	tokenString, err := token.SignedString(secretKey)
	if err != nil {
		return "", err
	}
	return tokenString, nil
}

func CreateResetPasswordToken(email string) (string, error) {
	token := jwt.NewWithClaims(jwt.SigningMethodHS256,
		jwt.MapClaims{
			"email": email,
			"exp":   time.Now().Add(ResetPasswordTokenTTL).Unix(),
		})

	tokenString, err := token.SignedString(secretKey)
	if err != nil {
		return "", err
	}
	return tokenString, nil
}

func CreateRefreshToken(uid uuid.UUID, displayName string) (string, error) {
	token := jwt.NewWithClaims(jwt.SigningMethodHS256,
		jwt.MapClaims{
			"uid":         uid,
			"displayName": displayName,
			"exp":         time.Now().Add(RefreshTokenTTL).Unix(),
		})
	tokenString, err := token.SignedString(secretKey)
	if err != nil {
		return "", err
	}
	return tokenString, nil
}

func VerifyToken(tokenString string) error {
	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		return secretKey, nil
	})
	if err != nil {
		return err
	}
	if !token.Valid {
		logger.Error("invalid token caught")
		return fmt.Errorf("invalid token")
	}
	return nil
}

func ValidateToken(tokenString string) (models.Claims, error) {
	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		return secretKey, nil
	})
	if err != nil {
		logger.Error("Error parsing token:" + err.Error())
		return models.Claims{}, err
	}

	if !token.Valid {
		logger.Error("Invalid token")
		return models.Claims{}, err
	}

	// Extract claims
	if claims, ok := token.Claims.(jwt.MapClaims); ok && token.Valid {
		uid, ok := claims["uid"].(string)
		if !ok {
			logger.Error("invalid token claims. uid is not a uuid")
			return models.Claims{}, fmt.Errorf("invalid token claims")
		}
		displayName, ok := claims["displayName"].(string)
		if !ok {
			logger.Error("invalid token claims. Missing displayName")
			return models.Claims{}, fmt.Errorf("invalid token claims")
		}
		uuid := uuid.MustParse(uid)
		return models.Claims{
			Uid:         uuid,
			DisplayName: displayName,
		}, nil
	}

	return models.Claims{}, fmt.Errorf("invalid token claims")
}

func ValidateRefreshToken(tokenString string) (models.ResetClaims, error) {
	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		return secretKey, nil
	})
	if err != nil {
		logger.Error("Error parsing token:" + err.Error())
		return models.ResetClaims{}, err
	}

	if !token.Valid {
		logger.Error("Invalid token")
		return models.ResetClaims{}, err

	}
	// Extract claims
	if claims, ok := token.Claims.(jwt.MapClaims); ok && token.Valid {
		email, ok := claims["email"].(string)
		if !ok {
			logger.Error("invalid token claims. Missing email")
			return models.ResetClaims{}, fmt.Errorf("invalid token claims")
		}
		return models.ResetClaims{
			Email: email,
		}, nil
	}
	return models.ResetClaims{}, fmt.Errorf("invalid token claims")
}
func AuthMiddleware(next pine.Handler) pine.Handler {
	return func(c *pine.Ctx) error {
		cookie, err := c.ReadCookie("session_id")
		if err != nil {
			logger.Error("error reading cookie" + err.Error())
			return c.SendStatus(http.StatusInternalServerError)
		}
		if cookie == nil {
			logger.Error("cookie is nil")
			return c.SendStatus(http.StatusUnauthorized)
		}
		claims, err := ValidateToken(cookie.Value)
		if err != nil {
			logger.Error("could not verify cookie" + " " + err.Error())
			return c.SendStatus(http.StatusUnauthorized)
		}
		c.Locals("claims", claims)
		// Call the next handler if authentication is successful
		return next(c)
	}
}

func RefreshMiddleware(next pine.Handler) pine.Handler {
	return func(c *pine.Ctx) error {
		cookie, err := c.ReadCookie("refresh_token")
		if cookie == nil || err != nil {
			logger.Error("cookie is nil")
			return c.SendStatus(http.StatusUnauthorized)
		}
		claims, err := ValidateToken(cookie.Value)
		if err != nil {
			logger.Error("could not verify cookie" + err.Error())
			return c.SendStatus(http.StatusUnauthorized)
		}
		c.Locals("claims", claims)
		// Call the next handler if authentication is successful
		return next(c)
	}
}

func ResetPasswordMiddleware(next pine.Handler) pine.Handler {
	return func(c *pine.Ctx) error {
		cookie, err := c.ReadCookie("reset_token")
		if cookie == nil || err != nil {
			// user did not make a request to reset password
			return c.SendStatus(http.StatusContinue)
		}
		claims, err := ValidateRefreshToken(cookie.Value)
		if err != nil {
			logger.Error("could not verify cookie" + err.Error())
			return c.SendStatus(http.StatusUnauthorized)
		}
		c.Locals("resetclaims", claims)
		return next(c)
	}
}
