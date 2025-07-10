package handlers

import (
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/BryanMwangi/pine"
	"github.com/BryanMwangi/pine/logger"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/config"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/repo"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/pkg/auth"
)

var (
	TTL        = config.GoDotEnvVariable("AccessTokenTTL")
	RefreshTTL = config.GoDotEnvVariable("RefreshTokenTTL")
)

func SignUpHandler(c *pine.Ctx) error {
	var requestBody models.UserSignUpRequest
	err := json.NewDecoder(c.Request.Body).Decode(&requestBody)
	if err != nil {
		logger.Error("invalid request")
		return c.SendStatus(http.StatusBadRequest)
	}
	passwordHash, err := auth.HashPassword(requestBody.Password)
	if err != nil {
		logger.Error("error hashing passord" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	//create user in postgres
	uid, displayName, err := repo.CreateUser(c.Request.Context(), requestBody, passwordHash)
	if err != nil {
		if err == repo.ErrUserExists {
			logger.Error("user already exists")
			return c.SendStatus(http.StatusAlreadyReported)
		}
		logger.Error("error creating user " + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	//generate a JWT for the newly created user
	jwtCookie, err := auth.CreateToken(uid, displayName)
	if err != nil {
		logger.Error("error creating jwt cookie" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	ttl_int, err := strconv.Atoi(TTL)
	if err != nil {
		logger.Error("error converting ttl " + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	refreshToken, err := auth.CreateRefreshToken(uid, displayName)
	if err != nil {
		logger.Error("error creating jwt cookie" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	refreshttl_int, err := strconv.Atoi(RefreshTTL)
	if err != nil {
		logger.Error("error converting refreshttl" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}

	return c.SetCookie(pine.Cookie{
		Name:     "session_id",
		Value:    jwtCookie,
		Path:     "/",
		MaxAge:   ttl_int,
		Secure:   true,
		HttpOnly: true,
		SameSite: 0,
	}, pine.Cookie{
		Name:     "refresh_token",
		Value:    refreshToken,
		Path:     "/",
		MaxAge:   refreshttl_int,
		Secure:   true,
		HttpOnly: true,
		SameSite: 0,
	}).SendStatus(http.StatusOK)
}

func LoginHandler(c *pine.Ctx) error {
	var requestBody models.UserLoginRequest
	err := json.NewDecoder(c.Request.Body).Decode(&requestBody)
	if err != nil {
		logger.Error("invalid request")
		return c.SendStatus(http.StatusBadRequest)
	}
	user, err := repo.GetUserByEmail(c.Request.Context(), requestBody.Email)
	if err != nil {
		if err == repo.ErrUserNotFound {
			logger.Error("user not found")
			return c.SendStatus(http.StatusNotFound)
		}
		logger.Error("internal server error" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}

	passwordMatch := auth.CheckPasswordHash(requestBody.Password, user.Password)

	if passwordMatch {
		jwtCookie, err := auth.CreateToken(user.Id, user.DisplayName)
		if err != nil {
			logger.Error("error creating jwt cookie" + err.Error())
			return c.SendStatus(http.StatusInternalServerError)
		}
		refreshToken, err := auth.CreateRefreshToken(user.Id, user.DisplayName)
		if err != nil {
			logger.Error("error creating jwt cookie" + err.Error())
			return c.SendStatus(http.StatusInternalServerError)
		}
		ttl_int, err := strconv.Atoi(TTL)
		if err != nil {
			logger.Error("error converting ttl " + err.Error())
			return c.SendStatus(http.StatusInternalServerError)
		}
		refreshttl_int, err := strconv.Atoi(RefreshTTL)
		if err != nil {
			logger.Error("error converting refreshttl" + err.Error())
			return c.SendStatus(http.StatusInternalServerError)
		}

		return c.SetCookie(pine.Cookie{
			Name:     "session_id",
			Value:    jwtCookie,
			Path:     "/",
			MaxAge:   ttl_int,
			Secure:   true,
			HttpOnly: true,
			SameSite: 0,
		}, pine.Cookie{
			Name:     "refresh_token",
			Value:    refreshToken,
			Path:     "/",
			MaxAge:   refreshttl_int,
			Secure:   true,
			HttpOnly: true,
			SameSite: 0,
		}).SendStatus(http.StatusOK)
	}
	return c.SendStatus(http.StatusUnauthorized)
}

func RefreshTokenHandler(c *pine.Ctx) error {
	claimsData := c.Locals("claims").(models.Claims)
	jwtCookie, err := auth.CreateToken(claimsData.Uid, claimsData.DisplayName)
	if err != nil {
		logger.Error("error creating jwt cookie" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	refreshToken, err := auth.CreateRefreshToken(claimsData.Uid, claimsData.DisplayName)
	if err != nil {
		logger.Error("error creating jwt cookie" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}

	ttl_int, err := strconv.Atoi(TTL)
	if err != nil {
		logger.Error("error converting ttl " + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	refreshttl_int, err := strconv.Atoi(RefreshTTL)
	if err != nil {
		logger.Error("error converting refreshttl" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}

	return c.SetCookie(pine.Cookie{
		Name:     "session_id",
		Value:    jwtCookie,
		Path:     "/",
		MaxAge:   ttl_int,
		Secure:   true,
		HttpOnly: true,
		SameSite: 0,
	}, pine.Cookie{
		Name:     "refresh_token",
		Value:    refreshToken,
		Path:     "/",
		MaxAge:   refreshttl_int,
		Secure:   true,
		HttpOnly: true,
		SameSite: 0,
	}).SendStatus(http.StatusOK)
}

func LogoutHandler(c *pine.Ctx) error {
	return c.DeleteCookie("session_id", "refresh_token").SendStatus(http.StatusOK)
}
