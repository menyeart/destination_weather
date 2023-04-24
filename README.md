# Destination Weather REST API

    Destination Weather (Whether, Sweater?) is a student project for the Turing School of Software and Design Backend Software Engineering program. It demonstrates skills in consuming external APIs, creating API endpoints that return objects serialized to JSON:API spec, displaying CRUD fuctionality and showing a strong understanding of MVC and OOD principles in the context of a Ruby on Rails application.

# Built With

  ![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white) 
  ![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white) 
  ![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

### Prerequisites

  - Ruby Version 3.1.1
  - Rails Version 7.0.4.x

## Install
    
    bundle install

## Run the app

    rails s

## Run the tests

    bundle exec rspec

# REST API

  The REST API to the example app is described below.

## Get the weather forecast for a location

### Request

`GET /api/v0/forecast`

    GET /api/v0/forecast?location=cincinatti,oh
    Content-Type: application/json
    Accept: application/json

### Response

<details>
  <pre>
    <code>
    {
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "last_updated": "2023-04-24 17:00",
                "temperature": 48.9,
                "feels_like": 45.1,
                "humidity": 39,
                "uvi": 4.0,
                "visibility": 9.0,
                "condition": "Partly cloudy",
                "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
            },
            "daily_weather": [
                {
                    "date": "2023-04-24",
                    "sunrise": "06:49 AM",
                    "sunset": "08:23 PM",
                    "max_temp": 53.4,
                    "min_temp": 31.6,
                    "condition": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "date": "2023-04-25",
                    "sunrise": "06:47 AM",
                    "sunset": "08:24 PM",
                    "max_temp": 59.5,
                    "min_temp": 33.1,
                    "condition": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
                },
                {
                    "date": "2023-04-26",
                    "sunrise": "06:46 AM",
                    "sunset": "08:25 PM",
                    "max_temp": 60.1,
                    "min_temp": 42.4,
                    "condition": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
                },
                {
                    "date": "2023-04-27",
                    "sunrise": "06:45 AM",
                    "sunset": "08:26 PM",
                    "max_temp": 54.0,
                    "min_temp": 39.7,
                    "condition": "Moderate rain",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/302.png"
                },
                {
                    "date": "2023-04-28",
                    "sunrise": "06:43 AM",
                    "sunset": "08:27 PM",
                    "max_temp": 59.5,
                    "min_temp": 45.5,
                    "condition": "Patchy rain possible",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/176.png"
                }
            ],
            "hourly_weather": [
                {
                    "time": "2023-04-24 00:00",
                    "temperature": 35.4,
                    "conditions": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
                },
                {
                    "time": "2023-04-24 01:00",
                    "temperature": 34.9,
                    "conditions": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
                },
                {
                    "time": "2023-04-24 02:00",
                    "temperature": 34.2,
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "2023-04-24 03:00",
                    "temperature": 33.4,
                    "conditions": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
                },
                {
                    "time": "2023-04-24 04:00",
                    "temperature": 33.3,
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "2023-04-24 05:00",
                    "temperature": 32.9,
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "2023-04-24 06:00",
                    "temperature": 32.0,
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "2023-04-24 07:00",
                    "temperature": 31.6,
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "2023-04-24 08:00",
                    "temperature": 35.1,
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "2023-04-24 09:00",
                    "temperature": 39.0,
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "2023-04-24 10:00",
                    "temperature": 42.1,
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "2023-04-24 11:00",
                    "temperature": 44.6,
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "2023-04-24 12:00",
                    "temperature": 47.1,
                    "conditions": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
                },
                {
                    "time": "2023-04-24 13:00",
                    "temperature": 49.3,
                    "conditions": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
                },
                {
                    "time": "2023-04-24 14:00",
                    "temperature": 50.9,
                    "conditions": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
                },
                {
                    "time": "2023-04-24 15:00",
                    "temperature": 53.4,
                    "conditions": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
                },
                {
                    "time": "2023-04-24 16:00",
                    "temperature": 53.1,
                    "conditions": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
                },
                {
                    "time": "2023-04-24 17:00",
                    "temperature": 53.1,
                    "conditions": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
                },
                {
                    "time": "2023-04-24 18:00",
                    "temperature": 50.9,
                    "conditions": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
                },
                {
                    "time": "2023-04-24 19:00",
                    "temperature": 50.2,
                    "conditions": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
                },
                {
                    "time": "2023-04-24 20:00",
                    "temperature": 43.9,
                    "conditions": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
                },
                {
                    "time": "2023-04-24 21:00",
                    "temperature": 40.1,
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "2023-04-24 22:00",
                    "temperature": 38.8,
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "2023-04-24 23:00",
                    "temperature": 37.9,
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                }
            ]
        }
      }
    }
        </code>
  </pre>
</details>

## Create a new user

### Request

`POST /api/v0/users`

    POST /api/v0/users
    Content-Type: application/json
    Accept: application/json

    {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

### Response
<details>
  <pre>
    <code>
    {
        "data": {
            "id": "1",
            "type": "user",
            "attributes": {
                "email": "whatever@example.com",
                "api_key": "apikey"
            }
        }
    }
      </code>
  </pre>
</details>

## Log In 

### Request

`POST /api/v0/sessions`

    POST /api/v0/sessions
    Content-Type: application/json
    Accept: application/json

    {
      "email": "whatever@example.com",
      "password": "password"
    }

### Response

<details>
  <pre>
    <code>
    {
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "email": "whatever@example.com",
            "api_key": "apikey"
        }
      }
    }
      </code>
  </pre>
</details>  

## Create a road trip

### Request

`POST /api/v0/road_trip`

    POST /api/v0/road_trip
    Content-Type: application/json
    Accept: application/json

    {
      "origin": "Cincinatti,OH",
      "destination": "Chicago,IL",
      "api_key": "api_key"
    }

### Response

<details>
  <pre>
    <code>
    {
    "data": {
        "id": null,
        "type": "road_trip",
        "attributes": {
            "start_city": "Cincinatti,OH",
            "end_city": "Chicago,IL",
            "travel_time": "04:41:30",
            "weather_at_eta": {
                "datetime": "2023-04-24 20:00",
                "temperature": 43.2,
                "condition": "Cloudy"
            }
        }
      }
    }
      </code>
  </pre>
</details>  


## Contributors

Matt Enyeart

Github: https://github.com/menyeart
LinkedIn https://www.linkedin.com/in/matt-enyeart/