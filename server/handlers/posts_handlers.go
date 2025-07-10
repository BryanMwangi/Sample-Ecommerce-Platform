package handlers

import (
	"strconv"

	"github.com/BryanMwangi/pine"
	"github.com/BryanMwangi/pine/logger"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/repo"
)

func FetchPostsHandler(c *pine.Ctx) error {
	page := c.Query("page")
	if page == "" {
		logger.Error("bad request missing page or limit")
		return c.SendStatus(400)
	}
	category := c.Query("category")
	pageInt, err := strconv.Atoi(page)
	if err != nil {
		logger.Error("bad request" + err.Error())
		return c.SendStatus(400)
	}
	if category != "" {
		posts, err := repo.GetPostsByCategory(c.Request.Context(), pageInt, category)
		if err != nil {
			logger.Error("error fetching posts" + err.Error())
			return c.SendStatus(500)
		}
		c.JSON(posts)
		return nil
	}
	posts, err := repo.GetPosts(c.Request.Context(), pageInt)
	if err != nil {
		logger.Error("error fetching posts" + err.Error())
		return c.SendStatus(500)
	}
	c.JSON(posts)
	return nil
}

func FetchPostByIdHandler(c *pine.Ctx) error {
	id, err := c.ParamsInt("id")
	if err != nil {
		logger.Error("bad request" + err.Error())
		return c.SendStatus(400)
	}
	post, err := repo.GetPostById(c.Request.Context(), id)
	if err != nil {
		if err == repo.ErrPostNotFound {
			return c.SendStatus(404)
		}
		logger.Error("error fetching post" + err.Error())
		return c.SendStatus(500)
	}

	return c.JSON(post)
}

func FetchIngredientsHandler(c *pine.Ctx) error {
	ingredients, err := repo.GetAllIngredients(c.Request.Context())
	if err != nil {
		logger.Error("error fetching ingredients" + err.Error())
		return c.SendStatus(500)
	}
	c.JSON(ingredients)
	return nil
}

func FetchCategoriesHandler(c *pine.Ctx) error {
	categories, err := repo.GetAllCategories(c.Request.Context())
	if err != nil {
		logger.Error("error fetching categories" + err.Error())
		return c.SendStatus(500)
	}
	c.JSON(categories)
	return nil
}
