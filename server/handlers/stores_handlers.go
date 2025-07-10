package handlers

import (
	"net/http"

	"github.com/BryanMwangi/pine"
	"github.com/BryanMwangi/pine/logger"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/repo"
)

func FetchAllStoresHandler(c *pine.Ctx) error {
	stores, err := repo.FetchAllStores(c.Request.Context())
	if err != nil {
		if err == repo.ErrPostNotFound {
			return c.SendStatus(http.StatusNotFound)
		}
		logger.Error("error fetching stores" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	return c.JSON(stores, http.StatusOK)
}
func FetchStoreByIdHandler(c *pine.Ctx) error {
	id, err := c.ParamsInt("id")
	if err != nil {
		return c.SendStatus(http.StatusBadRequest)
	}
	store, err := repo.GetStoreById(c.Request.Context(), id)
	if err != nil {
		if err == repo.ErrPostNotFound {
			return c.SendStatus(http.StatusNotFound)
		}
		logger.Error("error fetching store" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	return c.JSON(store, http.StatusOK)
}

func FetchStorePostsHandler(c *pine.Ctx) error {
	id, err := c.ParamsInt("id")
	if err != nil {
		return c.SendStatus(http.StatusBadRequest)
	}
	posts, err := repo.GetStorePosts(c.Request.Context(), id)
	if err != nil {
		if err == repo.ErrPostNotFound {
			return c.SendStatus(http.StatusNotFound)
		}
		logger.Error("error fetching store posts" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	return c.JSON(posts, http.StatusOK)
}

func FetStoreHoursHandler(c *pine.Ctx) error {
	id, err := c.ParamsInt("id")
	day := c.Query("day")
	if err != nil {
		return c.SendStatus(http.StatusBadRequest)
	}
	if day == "" {
		return c.SendStatus(http.StatusBadRequest)
	}
	hours, err := repo.GetWorkingHoursForStore(c.Request.Context(), id, day)
	if err != nil {
		if err == repo.ErrPostNotFound {
			return c.SendStatus(http.StatusNotFound)
		}
		logger.Error("error fetching store hours" + err.Error())
		return c.SendStatus(http.StatusInternalServerError)
	}
	return c.JSON(hours, http.StatusOK)
}
