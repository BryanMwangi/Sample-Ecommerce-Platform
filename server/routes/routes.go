package routes

import (
	"context"

	"github.com/BryanMwangi/pine"
	"github.com/BryanMwangi/pine/logger"
	"github.com/BryanMwangi/pine/websocket"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/handlers"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/pkg/auth"
)

func ServerRoutes(ctx context.Context, app *pine.Server) {
	app.Get("/ping", func(c *pine.Ctx) error {
		logger.Info("ponged")
		return c.SendString("pong")
	})

	app.Get("/protectedPing", auth.AuthMiddleware(func(c *pine.Ctx) error {
		return c.SendString("protectedPong")
	}))

	app.Get("/status", func(c *pine.Ctx) error {
		return c.SendStatus(200)
	})

	app.Post("/signUp", handlers.SignUpHandler)

	app.Post("/login", handlers.LoginHandler)

	app.Get("/logout", handlers.LogoutHandler)

	app.Get("/refreshCookie", auth.RefreshMiddleware(handlers.RefreshTokenHandler))

	app.Get("/fetchUser", auth.AuthMiddleware(handlers.FetchUserHandler))

	app.Get("/allUsers", auth.AuthMiddleware(handlers.GetAllUsersHandler))

	app.Get("/posts", handlers.FetchPostsHandler)

	app.Get("/fetchPost/:id", handlers.FetchPostByIdHandler)

	app.Get("/fetchIngredients", handlers.FetchIngredientsHandler)

	app.Get("/fetchCategories", handlers.FetchCategoriesHandler)

	app.Get("/fetchAllStores", handlers.FetchAllStoresHandler)

	app.Get("/fetchStore/:id", handlers.FetchStoreByIdHandler)

	app.Get("/fetchStorePosts/:id", handlers.FetchStorePostsHandler)

	app.Get("/fetchStoreHours/:id", handlers.FetStoreHoursHandler)

	app.Get("/search", handlers.SearchHandler)

	app.Post("/createAddress", auth.AuthMiddleware(handlers.CreateAddressHandler))

	app.Get("/fetchAllAddresses", auth.AuthMiddleware(handlers.GetAllAddressHanlder))

	app.Post("/createOrder", auth.AuthMiddleware(handlers.CreateOrderHandler))

	app.Get("/fetchAllOrders", auth.AuthMiddleware(handlers.FetchAllCustomerOrdersHandler))

	app.Post("/resetPasswordRequest", handlers.HandlePasswordResetRequest)

	app.Get("/resetPasswordInitiatedCheck", auth.ResetPasswordMiddleware(handlers.CheckUserResetPasswordRequest))

	app.Post("/confirmResetPasswordCode", auth.ResetPasswordMiddleware(handlers.ProcessResetPasswordRequestConfirm))

	app.Post("/resetPassword", auth.ResetPasswordMiddleware(handlers.ProcessResetPasswordRequest))

	app.Get("/ws", websocket.New(func(conn *websocket.Conn, ctx *pine.Ctx) {
		websocket.WatchFile("server.log", conn)
		logger.Info("started watching server.log")
	}))
}
