package emails

import (
	"github.com/resend/resend-go/v2"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/config"
)

var (
	RESEND_API_KEY = config.GoDotEnvVariable("RESEND_API_KEY")
	EmailClient    *resend.Client
)

func InitializeClient() error {
	client := resend.NewClient(RESEND_API_KEY)
	EmailClient = client
	return nil
}
