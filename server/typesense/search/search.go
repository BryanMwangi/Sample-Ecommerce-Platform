package typesenseSearch

import (
	"context"

	"github.com/BryanMwangi/pine/logger"
	"github.com/typesense/typesense-go/v2/typesense"
	"github.com/typesense/typesense-go/v2/typesense/api"
	"github.com/typesense/typesense-go/v2/typesense/api/pointer"
	gotypesense "gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/typesense"
	typesenseModels "gitlab.nixdev.co/cec/students/go/nix_go-course_2_07.2024/bryan-gichuru/server/typesense/models"
)

func Search(query string) ([]interface{}, error) {
	searchParameters := &api.SearchCollectionParams{
		Q:       pointer.String(query),
		QueryBy: pointer.String("name, category"),
	}
	resp, err := typesense.GenericCollection[*typesenseModels.TypeSenseResult](gotypesense.TypeSenseClient, "items").Documents().Search(context.Background(), searchParameters)
	if err != nil {
		logger.Error(err.Error())
		return []interface{}{}, err
	}
	var results []interface{}
	for _, hit := range *resp.Hits {
		document := *hit.Document
		document["currency"] = "USD"
		results = append(results, document)
	}
	return results, nil
}
