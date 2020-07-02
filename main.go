package main

import "net/http"

func main() {
    http.HandleFunc("/", IndexHandler) // 绑定具体路径和处理handler
    http.ListenAndServe("0.0.0.0:8382", nil) // 绑定host和port
}

func IndexHandler(w http.ResponseWriter, h *http.Request) {
    w.Write([]byte("hello world1"))
}