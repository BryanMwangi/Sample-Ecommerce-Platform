package refreshprice

import (
	"context"
	"crypto/tls"
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
	"time"

	"github.com/BryanMwangi/pine/logger"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/repo"
)

var (
	BASE_URL = "https://foodapi.golang.nixdev.co/suppliers"
)

func GetLatestPrices() error {
	logger.Warning("started background task...")
	ctx := context.Background()
	stores, err := repo.FetchAllStores(ctx)
	if err != nil {
		return err
	}
	var newItems []NewPrice
	for _, store := range stores {
		items, err := FetchStoreMenuItems(store.Id)
		if err != nil {
			return err
		}
		for _, item := range items {
			newItem := NewPrice{
				Id:    item.Id,
				Price: item.Price,
			}
			newItems = append(newItems, newItem)
		}
		// wait for 30 seconds before making a new API call
		fmt.Println("waiting for 30 seconds before making another API call...")
		time.Sleep(30 * time.Second)
	}
	logger.Warning("starting to update prices...")
	for _, item := range newItems {
		err := repo.UpdatePrice(ctx, item.Id, item.Price)
		if err != nil {
			return err
		}
	}
	now := time.Now()
	nextTime := now.Add(30 * time.Minute)

	logger.Success("updated prices successfully at " + now.Format(time.RFC1123))
	fmt.Println("Next update will be performed at " + nextTime.Format(time.RFC1123))
	return nil
}

func FetchStoreMenuItems(storeId int) ([]item, error) {
	customTransport := &http.Transport{
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	}
	client := http.Client{
		Transport: customTransport,
	}
	req, err := http.NewRequest("GET", BASE_URL+"/"+strconv.Itoa(storeId)+"/menu", nil)
	if err != nil {
		return nil, err
	}
	resp, err := client.Do(req)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()
	var response response
	err = json.NewDecoder(resp.Body).Decode(&response)
	if err != nil {
		return nil, err
	}
	return response.Menu, nil
}
