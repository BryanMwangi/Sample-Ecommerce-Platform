package handlers

import (
	"net/http"

	"github.com/BryanMwangi/pine"
	typesenseSearch "gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/typesense/search"
)

func SearchHandler(c *pine.Ctx) error {
	query := c.Query("q")
	if query == "" {
		return c.SendStatus(http.StatusBadRequest)
	}
	results, err := typesenseSearch.Search(query)
	if err != nil {
		return c.SendStatus(http.StatusInternalServerError)
	}
	return c.JSON(results)
}
