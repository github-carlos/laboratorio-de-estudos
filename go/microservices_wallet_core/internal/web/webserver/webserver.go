package webserver

import (
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

type WebServer struct {
	Router        chi.Router
	Handlers      map[string]http.HandlerFunc
	WebServerPort string
}

func NewWebServer(router chi.Router, handlers map[string]http.HandlerFunc, port string) *WebServer {
	return &WebServer{
		Router:        router,
		Handlers:      handlers,
		WebServerPort: port,
	}
}

func (w *WebServer) AddHandler(path string, handler http.HandlerFunc) {
	w.Handlers[path] = handler
}

func (w *WebServer) Start() {
	w.Router.Use(middleware.Logger)

	for path, handler := range w.Handlers {
		w.Router.Post(path, handler)
	}
	http.ListenAndServe(w.WebServerPort, w.Router)
}
