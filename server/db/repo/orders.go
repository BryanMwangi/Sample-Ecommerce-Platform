package repo

import (
	"context"
	"fmt"
	"strings"

	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db"
	"gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/db/models"
)

func CreateOrder(ctx context.Context, uid string, itemIds []int64, addressId int, storeId int64) error {
	placeholders := make([]string, len(itemIds))
	args := make([]interface{}, len(itemIds))

	for i, id := range itemIds {
		placeholders[i] = fmt.Sprintf("$%d", i+1)
		args[i] = id
	}

	query := fmt.Sprintf(`
	SELECT id, store, price, "imageUrl", name
	FROM posts 
	WHERE id IN (%s)`, strings.Join(placeholders, ","))
	rows, err := db.DBPool.Query(ctx, query, args...)
	if err != nil {
		return err
	}
	defer rows.Close()

	var orderItems []models.Post
	for rows.Next() {
		var item models.Post
		err := rows.Scan(&item.Id, &item.StoreId, &item.Price, &item.ImageUrl, &item.Name)
		if err != nil {
			return err
		}
		orderItems = append(orderItems, item)
	}

	if len(orderItems) == 0 {
		return fmt.Errorf("no items found for the provided IDs")
	}

	// Check if the store exists
	var exists bool
	err = db.DBPool.QueryRow(ctx, `SELECT EXISTS (SELECT 1 FROM stores WHERE id = $1)`, storeId).Scan(&exists)
	if err != nil {
		return err
	}
	if !exists {
		return fmt.Errorf("store with ID %d does not exist", storeId)
	}

	var total float64
	currency := "USD"
	for _, item := range orderItems {
		total += item.Price
	}

	order := models.Order{
		Uid:       uid,
		StoreId:   storeId,
		AddressId: addressId,
		Total:     total,
		Currency:  currency,
		Status:    "pending",
	}

	err = db.DBPool.QueryRow(ctx, `
		INSERT INTO orders (uid, "storeId", "addressId", total, currency, status, "createdAt", "updatedAt") 
		VALUES ($1, $2, $3, $4, $5, $6, NOW(), NOW()) RETURNING id`,
		order.Uid, order.StoreId, order.AddressId, order.Total, order.Currency, order.Status).Scan(&order.Id)
	if err != nil {
		return err
	}

	for _, item := range orderItems {
		_, err = db.DBPool.Exec(ctx, `
			INSERT INTO order_items (name, store, "orderId", price, "imageUrl") 
			VALUES ($1, $2, $3, $4, $5)`,
			item.Name, item.StoreId, order.Id, item.Price, item.ImageUrl)
		if err != nil {
			return err
		}
	}

	return nil
}

func FetchAllCustomerOrders(ctx context.Context, uid string) ([]models.Order, error) {
	var orders []models.Order

	// Query to fetch orders along with their items
	rows, err := db.DBPool.Query(ctx, `
		SELECT o.id, o.uid, o."storeId", o."addressId", o.total, o.currency, o.status, o."createdAt", o."updatedAt",
		       oi.name, oi.price, oi."imageUrl"
		FROM orders o
		JOIN order_items oi ON o.id = oi."orderId"
		WHERE o.uid = $1`, uid)
	if err != nil {
		return nil, err // Return nil for orders on error
	}
	defer rows.Close()

	// Map to hold unique orders
	orderMap := make(map[int]*models.Order)

	for rows.Next() {
		var order models.Order
		var item models.OrderItem

		// Scan the order details
		err := rows.Scan(&order.Id, &order.Uid, &order.StoreId, &order.AddressId, &order.Total, &order.Currency, &order.Status, &order.CreatedAt, &order.UpdatedAt,
			&item.Name, &item.Price, &item.ImageUrl)
		if err != nil {
			return nil, err // Return nil for orders on error
		}

		// Check if this order is already in the map
		if existingOrder, found := orderMap[order.Id]; found {
			// If it exists, append the item to the existing order's items
			existingOrder.Items = append(existingOrder.Items, item)
		} else {
			// If it doesn't exist, create a new order and add the item
			order.Items = []models.OrderItem{item} // Initialize with the first item
			orderMap[order.Id] = &order            // Add the new order to the map
		}
	}

	// Convert the map to a slice
	for _, order := range orderMap {
		orders = append(orders, *order)
	}

	return orders, nil
}
