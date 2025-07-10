package emails

import (
	"bytes"
	"context"
	"html/template"

	"github.com/resend/resend-go/v2"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/config"
)

type Email struct {
	To        string
	Code      int
	FirstName string
}

var (
	ViewsDir = config.GoDotEnvVariable("VIEWS_DIR")
)

func SendResetPasswordEmail(email string, code int, name string, ctx context.Context) error {
	emailData := Email{
		To:        email,
		Code:      code,
		FirstName: name,
	}
	emailBody, err := ConstructResetPasswordEmail(emailData, code)
	if err != nil {
		return err
	}

	params := &resend.SendEmailRequest{
		To:      []string{email},
		From:    "Yumzies <notifications@yumzies.xyz>",
		Subject: "Reset your password",
		Html:    emailBody.String(),
	}

	_, err = EmailClient.Emails.Send(params)
	if err != nil {
		return err
	}
	return nil
}

func ConstructResetPasswordEmail(emailData Email, code int) (bytes.Buffer, error) {
	tmpl, err := template.ParseFiles(ViewsDir + "/reset.html")
	if err != nil {
		return bytes.Buffer{}, err
	}
	var emailBody bytes.Buffer
	err = tmpl.Execute(&emailBody, emailData)
	if err != nil {
		return bytes.Buffer{}, err
	}

	return emailBody, nil
}
