package repo

import (
	"context"
	"errors"

	"github.com/jackc/pgx/v5"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/emails"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/pkg/auth"
	goredis "gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/redis"
)

var (
	ErrCodeNotFound = errors.New("code not found")
)

func PasswordResetRequest(ctx context.Context, email string) error {
	var user models.User
	row := db.DBPool.QueryRow(ctx, "SELECT * FROM users WHERE email=$1", email)

	err := row.Scan(&user.Id, &user.Email, &user.Password, &user.FirstName, &user.LastName, &user.UserName, &user.DisplayName, &user.Deleted, &user.PhoneNumber, &user.ProfilePicture, &user.Role, &user.CreatedAt, &user.UpdatedAt)
	if err != nil {
		if err == pgx.ErrNoRows {
			return ErrUserNotFound
		}
		return err
	}
	// we now check if the user has a password
	if user.Password == "" {
		return ErrUserNotFound
	}
	code := auth.GenerateCode()
	NewCode := models.Code{
		Email: email,
		Code:  code,
	}
	err = goredis.SaveCode(ctx, NewCode)
	if err != nil {
		return err
	}

	err = emails.SendResetPasswordEmail(email, code, user.DisplayName, ctx)
	if err != nil {
		return err
	}
	return nil
}

func PasswordResetConfirm(ctx context.Context, email string, code int) error {
	savedCode, err := goredis.GetCode(ctx, email)
	if err != nil {
		return err
	}
	if savedCode.Code != code {
		return ErrCodeNotFound
	}
	return nil
}

func ResetPassword(ctx context.Context, email string, password string) error {
	hashedPassword, err := auth.HashPassword(password)
	if err != nil {
		return err
	}
	// we update the password in the database
	_, err = db.DBPool.Exec(ctx, "UPDATE users SET password=$1 WHERE email=$2", hashedPassword, email)
	if err != nil {
		return err
	}
	return nil
}
