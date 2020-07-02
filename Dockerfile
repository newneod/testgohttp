FROM golang:1.14 AS builder

WORKDIR /app

COPY . .

#RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o test_http_multi . # mac下编译linux 64位可执行程序
#RUN CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o test_http_multi . # linux下编译mac 64位可执行程序
RUN go build -o test_http_multi .

FROM debian:buster

ENV project_dir /root/

WORKDIR ${project_dir}

COPY --from=builder /app/test_http_multi .

EXPOSE 8382

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
  && sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
  && apt update --fix-missing \
  && apt install -y apt-utils \
  && apt install -y procps \
  && apt install -y vim

ENTRYPOINT ["./test_http_multi"]
