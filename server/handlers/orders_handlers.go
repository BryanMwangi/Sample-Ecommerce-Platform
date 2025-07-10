package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/BryanMwangi/pine"
	"github.com/BryanMwangi/pine/logger"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/repo"
)

func CreateOrderHandler(c *pine.Ctx) error {
	claims := c.Locals("claims").(models.Claims)
	var order models.OrderRequest
	err := json.NewDecoder(c.Request.Body).Decode(&order)
	if err != nil {
		logger.Error("invalid request")
		return c.SendStatus(http.StatusBadRequest)
	}
	err = repo.CreateOrder(c.Context(), claims.Uid.String(), order.ItemIds, order.AddressId, order.StoreId)
	if err != nil {
		logger.Error("error creating order" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	return c.SendStatus(http.StatusCreated)
}

func FetchAllCustomerOrdersHandler(c *pine.Ctx) error {
	claims := c.Locals("claims").(models.Claims)
	orders, err := repo.FetchAllCustomerOrders(c.Context(), claims.Uid.String())
	if err != nil {
		logger.Error("error fetching all orders" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	return c.JSON(orders, http.StatusOK)
}
