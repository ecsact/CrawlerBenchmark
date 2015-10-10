package main

import (
	"net/http"
	"sync"
)

func main() {
	var wg sync.WaitGroup

	for i := 0; i < 5; i++ {
		wg.Add(1)
		go func() {
			for i := 0; i < 100; i++ {
				http.Get("https://api.ipify.org?format=json")
			}
			wg.Done()
		}()
	}

	wg.Wait()
}
