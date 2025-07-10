package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/BryanMwangi/pine"
	"github.com/BryanMwangi/pine/logger"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/repo"
)

func CreateAddressHandler(c *pine.Ctx) error {
	var address models.AddressRequest
	claimsData := c.Locals("claims").(models.Claims)

	err := json.NewDecoder(c.Request.Body).Decode(&address)
	if err != nil {
		logger.Error("invalid address request")
		return c.SendStatus(http.StatusBadRequest)
	}
	err = repo.CreateAddress(c.Context(), address, claimsData.Uid.String())
	if err != nil {
		logger.Error("error creating address" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	return c.SendStatus(http.StatusCreated)
}

func GetAllAddressHanlder(c *pine.Ctx) error {
	claimsData := c.Locals("claims").(models.Claims)
	addresses, err := repo.FetchAllUserAddresses(c.Context(), claimsData.Uid.String())
	if err != nil {
		logger.Error("error fetching all addresses" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	return c.JSON(addresses, http.StatusOK)
}
