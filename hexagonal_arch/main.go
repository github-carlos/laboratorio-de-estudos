package main

import (
	"database/sql"

	"carlos.com/adapters/db"
	"carlos.com/application"
)

func main() {
	sqlite, _ := sql.Open("sqlite3", "sqlite.db")
	productDbAdapter := db.NewProductDb(sqlite)
	productService := application.NewProductService(productDbAdapter)
	product, _ := productService.Create("Product Exemple", 30)
	productService.Enable(product)
}