package cmd

import (
	"context"
	"time"

	"github.com/BryanMwangi/pine"
	"github.com/BryanMwangi/pine/cors"
	"github.com/BryanMwangi/pine/logger"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/emails"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/pkg"
	goredis "gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/redis"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/routes"
	gotypesense "gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/typesense"
)

func Run(port, certFile, keyFile string, ctx context.Context) {
	app := pine.New()
	app.Use(cors.New(
		cors.Config{
			AllowedOrigins:   []string{"http://localhost:5173"},
			AllowCredentials: true,
		},
	))

	//register routes
	routes.ServerRoutes(ctx, app)

	//start  database client
	db.ConnectToDB(ctx)
	// connect to typesense
	gotypesense.InitializeClient()
	// initialize redis client
	goredis.InitializeClient(ctx)
	//Initialize Email client
	emails.InitializeClient()
	// register tasks
	pkg.RegisterTasks(app)

	logger.Success("Server is running on port " + port)
	ch := make(chan error, 1)
	go func() {
		// Listen on the specified port and send the error to the channel
		//certFile and Keyfile is optional
		ch <- app.Start(port, certFile, keyFile)
	}()
	select {
	case <-ctx.Done():
		logger.Warning("Server shutting down gracefully...")
		timeout, cancel := context.WithTimeout(context.Background(), 5*time.Second)
		defer cancel()

		err := gracefulShutdown(timeout)
		if err != nil {
			logger.Error("error shutting down clients")
		}

		// Close the Fiber app and send shutdown signal
		if err := app.ServeShutDown(ctx); err != nil {
			logger.Error("Error during shutdown " + err.Error())
		}
	case err := <-ch:
		// Server exited with an error
		if err != nil {
			logger.Error("Error starting server: " + err.Error())
		}
	}

	close(ch)
	logger.Success("Server stopped")
}

func gracefulShutdown(ctx context.Context) error {
	logger.Warning("starting client shut down...")

	//shut down the database connection/client
	db.ShutDownClient(ctx)
	// Close Redis client
	defer goredis.RedisClient.Close()
	logger.Success("client shut down complete!")
	//implement shutdown logic here
	return nil
}

// cors.Config{
// 	AllowedOrigins: []string{"http://localhost:5173", "http://localhost:8000"},
// 	AllowedMethods: []string{"GET", "POST", "PUT"},
// }
