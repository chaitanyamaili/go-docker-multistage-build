package main

import (
	"fmt"
	"net/http"
)

func main() {
	// Run the server
	RunServer()
}

func RunServer() {
	// Create a new server
	server := http.Server{
		Addr:    ":8080",
		Handler: http.HandlerFunc(helloWorldHandler),
	}
	server.ListenAndServe()
}

func helloWorldHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, World!")
}
