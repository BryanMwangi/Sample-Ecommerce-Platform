package pkg

import (
	"time"

	"github.com/BryanMwangi/pine"
	refreshprice "gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/pkg/refreshPrice"
)

//here we register tasks and packages that need to run at the server's
//runtime

func RegisterTasks(app *pine.Server) {
	//register tasks here
	task1 := pine.BackgroundTask{
		Fn:   refreshprice.GetLatestPrices,
		Time: 30 * time.Minute,
	}

	app.AddQueue(task1)
}
