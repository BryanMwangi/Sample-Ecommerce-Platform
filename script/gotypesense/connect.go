package gotypesense

import (
	"script/config"
	"time"

	"github.com/typesense/typesense-go/v2/typesense"
)

var (
	TypeSenseClient   *typesense.Client
	TYPESENSE_APY_KEY = config.GoDotEnvVariable("TYPESENSE_API_KEY")
)

func InitializeClient() {
	client := typesense.NewClient(
		typesense.WithServer("http://localhost:8108"),
		typesense.WithAPIKey(TYPESENSE_APY_KEY),
		typesense.WithNumRetries(5),
		typesense.WithRetryInterval(1*time.Second),
		typesense.WithHealthcheckInterval(2*time.Minute),
	)

	TypeSenseClient = client
}
