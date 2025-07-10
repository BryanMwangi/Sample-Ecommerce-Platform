package main

import (
	"context"
	"log"
	"os"
	"os/signal"

	"github.com/BryanMwangi/pine/logger"
	cmd "gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/cmd"
	config "gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/config"
)

//also note that the .env file in development is always located at ./config.env
//you can load the port and additional values there

// certFile and Keyfile is optional
var (
	PORT     = config.GoDotEnvVariable("PORT")
	CertFile = config.GoDotEnvVariable("") //path to cert file optional
	KeyFile  = config.GoDotEnvVariable("") //path to private key file optional
)

func main() {
	err := logger.Init("server.log", 100)
	if err != nil {
		log.Fatal(err)
	}

	ctx, cancel := signal.NotifyContext(context.Background(), os.Interrupt)
	defer cancel()

	//run server
	cmd.Run(":"+PORT, "", "", ctx)
}
