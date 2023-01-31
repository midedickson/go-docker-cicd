##
## Build
##

FROM golang:1.18-alpine AS build

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY *.go ./

RUN go build -o /go-docker-roach

##
## Deploy
##

FROM alpine

WORKDIR /

COPY --from=build /go-docker-roach .

EXPOSE 8080




CMD ["/go-docker-roach"]