package handlers

import (
	"encoding/json"
	"net/http"
	"time"

	"github.com/BryanMwangi/pine"
	"github.com/BryanMwangi/pine/logger"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/repo"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/pkg/auth"
)

func HandlePasswordResetRequest(c *pine.Ctx) error {
	type PasswordResetRequest struct {
		Email string `json:"email"`
	}
	var request PasswordResetRequest
	err := json.NewDecoder(c.Request.Body).Decode(&request)
	if err != nil {
		logger.Error("error decoding request body" + err.Error())
		return c.SendStatus(http.StatusBadRequest)
	}
	err = repo.PasswordResetRequest(c.Context(), request.Email)
	if err != nil {
		logger.Error("error requesting password reset" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	token, err := auth.CreateResetPasswordToken(request.Email)
	if err != nil {
		logger.Error("error creating token" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	ttl := (time.Minute * 15).Milliseconds()

	return c.SetCookie(pine.Cookie{
		Name:     "reset_token",
		Value:    token,
		Path:     "/",
		MaxAge:   int(ttl),
		Secure:   true,
		HttpOnly: true,
		SameSite: 0,
	}).JSON("success")
}

func CheckUserResetPasswordRequest(c *pine.Ctx) error {
	return c.SendStatus(http.StatusFound)
}

func ProcessResetPasswordRequestConfirm(c *pine.Ctx) error {
	claimsData := c.Locals("resetclaims").(models.ResetClaims)
	type codeBody struct {
		Code int `json:"token"`
	}
	var requestBody codeBody
	err := json.NewDecoder(c.Request.Body).Decode(&requestBody)
	if err != nil {
		logger.Error("error decoding request body" + err.Error())
		return c.SendStatus(http.StatusBadRequest)
	}
	err = repo.PasswordResetConfirm(c.Context(), claimsData.Email, requestBody.Code)
	if err != nil {
		if err == repo.ErrCodeNotFound {
			logger.Error("code not found")
			return c.SendStatus(http.StatusGone)
		}
		logger.Error("error confirming password reset" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	return c.SendStatus(http.StatusOK)
}

func ProcessResetPasswordRequest(c *pine.Ctx) error {
	claimsData := c.Locals("resetclaims").(models.ResetClaims)
	type newPasswordBody struct {
		Password string `json:"password"`
	}
	var requestBody newPasswordBody
	err := json.NewDecoder(c.Request.Body).Decode(&requestBody)
	if err != nil {
		logger.Error("error decoding request body" + err.Error())
		return c.SendStatus(http.StatusBadRequest)
	}
	err = repo.ResetPassword(c.Context(), claimsData.Email, requestBody.Password)
	if err != nil {
		logger.Error("error resetting password" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	return c.SendStatus(http.StatusOK)
}
