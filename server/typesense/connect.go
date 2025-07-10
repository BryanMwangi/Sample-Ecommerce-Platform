package gotypesense

import (
	"fmt"
	"time"

	"github.com/BryanMwangi/pine/logger"
	"github.com/typesense/typesense-go/v2/typesense"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/config"
)

var (
	TypeSenseClient   *typesense.Client
	TYPESENSE_APY_KEY = config.GoDotEnvVariable("TYPESENSE_API_KEY")
	TYPESENSE_HOST    = config.GoDotEnvVariable("TYPESENSE_HOST")
	TYPESENSE_PORT    = config.GoDotEnvVariable("TYPESENSE_PORT")
)

func InitializeClient() {
	fmt.Println("connecting to typesense...")
	client := typesense.NewClient(
		typesense.WithServer("http://"+TYPESENSE_HOST+":"+TYPESENSE_PORT),
		typesense.WithAPIKey(TYPESENSE_APY_KEY),
		typesense.WithNumRetries(5),
		typesense.WithRetryInterval(1*time.Second),
		typesense.WithHealthcheckInterval(2*time.Minute),
	)

	TypeSenseClient = client
	logger.Success("connected to typesense!")
}
