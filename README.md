# Gateway
> Ruby on Rails API Gateway

API gateway serves as single point of entry to microservices and for all client types.
The idea is to provide a single entry point for all the fine-grained APIs of the individual services.
This is a simple api routing app.

## Technologies
- Ruby 2.4.0
- Rails 5.0.1 (Rails API)
- PostgreSQL 9.4.5

## Installation

`git clone git@github.com:rzkmrs/gateway.git`

`cd gateway`

`bundle install`

## Setup

`rails db:create`

`rails db:migrate`

### Start server

`rails s`

## Add service api

`POST host/services`
```
{
  "name": "servce_name",
  "url": "http://localhost:3003",
  "token": ""
}
```

## Add Route api

`POST host/routes`

```
{
  "service_id": "service_id",
  "verb": "get",
  "url_pattern": "users/:id",
  "version": "v1"
}
```

### Rake to view services and its routes

`rake service_routes`
