package main

import (
	"net/http"
)

func main() {
	for i := 0; i < 100; i++ {
		http.Get("https://api.ipify.org?format=json")
	}
}
