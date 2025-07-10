package handlers

import (
	"net/http"

	"github.com/BryanMwangi/pine"
	"github.com/BryanMwangi/pine/logger"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/repo"
)

func FetchUserHandler(c *pine.Ctx) error {
	claims := c.Locals("claims").(models.Claims)

	user, err := repo.GetUserById(c.Request.Context(), claims.Uid)
	if err != nil {
		if err == repo.ErrUserNotFound {
			logger.Error("user not found")
			return c.SendStatus(http.StatusNotFound)
		}
		logger.Error("internal server error" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	return c.JSON(map[string]interface{}{
		"user": user,
	})
}

func GetAllUsersHandler(c *pine.Ctx) error {
	users, err := repo.GetAllUsers()
	if err != nil {
		if err == repo.ErrUserNotFound {
			return c.SendStatus(http.StatusNotFound)
		}
		return c.SendStatus(http.StatusInternalServerError)
	}
	return c.Status(http.StatusOK).JSON(users)
}
