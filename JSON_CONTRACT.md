## API Endpoints



### 1. New User
* **GET api/v0/users/create**
 - Controller: Api::V0::UsersController#create
 - Example Request:
  ```
  curl -X POST https://weather-together-be.onrender.com/users
	-d {
  "email": “new@gmail.com",
  "username": “new”,
  "password": “New1!!”,
  "password_confirmation": “New1!!”
	}
	^ must create unique user
  ```
 - Example Response:
  ```html
 {
  "data": {
    "id": "229",
    "type": "user",
    "attributes": {
      "email": “new@gmail.com",
      "username": “new”
    }
  }
}
  ```
2. ### To Daily Round from Email Verification
* **GET api/v0/users/:id/verify_account/:token**
 - Controller: Api::V0::UsersController#verify_account(named route: verify_account)
 - Example Request:
  ```
  curl -X GET https://weather-together-be.onrender.com/verify_account
  ```
 - Example Response:
  ```html
  	{
	 "message": "Successfully verified user"
	}
  OR
	{
	"errors":[{
	"detail":"Email does not match verification token"
		}]
	}
  ```
3. ### To Daily Round from Login
* **GET api/v0/users/login**
 - Controller: Api::V0::UsersController#login(named route: login)
 - Example Request:
  ```
  curl -X GET https://weather-together-be.onrender.com/api/v0/users/login -d ‘”email”: “new@email.com” , “password”: “New1!!”’
  ```
 - Example Response:
  ```html
{
    "data": {
        "id": "240",
        "type": "user",
        "attributes": {
            "email": “new@gmail.com",
            "username": “new”
        }
    }
}
  ```
15. ### To User Profile
* **GET api/v0/users/:id**
 - Controller: Api::V0::UsersController#show
 - Example Request:
  ```
  curl -X GET https://weather-together-be.onrender.com/api/v0/users/240 -d ‘”email”: new@email.com , “password”: New1!!’
  ```
 - Example Response:
  ```html
{
    "data": {
        "id": "240",
        "type": "user",
        "attributes": {
            "email": “new@gmail.com",
            "username": “new”
        }
    }
}
```
16. ### To Daily Round from Login
* **PATCH api/v0/users/:id**
 - Controller: Api::V0::UsersController#show
 - Example Request:
  ```
  curl -X PATCH https://weather-together-be.onrender.com/api/v0/users/240 -d ‘”email”: new@email.com , “password”: New1!!’
  ```
 - Example Response:
  ```html
  {
    "data": {
        "id": "240",
        "type": "user",
        "attributes": {
            "email": “new@gmail.com",
            "username": “new”
    		    }
   		 }
	}
```


### Recent Rounds
* **GET /api/v0/rounds/recent_rounds**
  - Controller: Api::V0::RoundsController#recent_rounds
  - Example Request:
    ```
    curl -X GET https://weather-together-be.onrender.com/api/v0/rounds/recent_rounds
    ```
  - Example Response:
    ```json
    {
    "data": [
        {
            "id": "92",
            "type": "round",
            "attributes": {
                "close_date": "2024-01-13",
                "number_of_votes": 12,
                "target_weather_stats": "{\"location\":{\"name\":\"Ialibu\",\"region\":\"Southern Highlands\",\"country\":\"Papua New Guinea\",\"lat\":-6.32,\"lon\":143.96,\"tz_id\":\"Pacific/Port_Moresby\",\"localtime_epoch\":1705081061,\"localtime\":\"2024-01-13 3:37\"},\"weather_data\":{\"maxtemp_c\":19.4,\"maxtemp_f\":66.9,\"mintemp_c\":10.6,\"mintemp_f\":51.1,\"avgtemp_c\":13.9,\"avgtemp_f\":57.1,\"maxwind_mph\":3.1,\"maxwind_kph\":5.0,\"totalprecip_mm\":23.06,\"totalprecip_in\":0.91,\"totalsnow_cm\":0.0,\"avgvis_km\":6.6,\"avgvis_miles\":4.0,\"avghumidity\":95,\"daily_will_it_rain\":1,\"daily_chance_of_rain\":100,\"daily_will_it_snow\":0,\"daily_chance_of_snow\":0,\"condition\":{\"text\":\"Light rain shower\",\"icon\":\"//cdn.weatherapi.com/weather/64x64/day/353.png\",\"code\":1240},\"uv\":7.0}}",
                "status": "open",
                "game_id": 18,
                "votes": [
                    {
                        "vote_id": 900,
                        "user_id": 222,
                        "round_id": 92,
                        "status": "unprocessed",
                        "target_weather_stats": "{\"location\":{\"name\":\"Ialibu\",\"region\":\"Southern Highlands\",\"country\":\"Papua New Guinea\",\"lat\":-6.32,\"lon\":143.96,\"tz_id\":\"Pacific/Port_Moresby\",\"localtime_epoch\":1705081061,\"localtime\":\"2024-01-13 3:37\"},\"weather_data\":{\"maxtemp_c\":19.4,\"maxtemp_f\":66.9,\"mintemp_c\":10.6,\"mintemp_f\":51.1,\"avgtemp_c\":13.9,\"avgtemp_f\":57.1,\"maxwind_mph\":3.1,\"maxwind_kph\":5.0,\"totalprecip_mm\":23.06,\"totalprecip_in\":0.91,\"totalsnow_cm\":0.0,\"avgvis_km\":6.6,\"avgvis_miles\":4.0,\"avghumidity\":95,\"daily_will_it_rain\":1,\"daily_chance_of_rain\":100,\"daily_will_it_snow\":0,\"daily_chance_of_snow\":0,\"condition\":{\"text\":\"Light rain shower\",\"icon\":\"//cdn.weatherapi.com/weather/64x64/day/353.png\",\"code\":1240},\"uv\":7.0}}",
                        "latitude": "12.745354201417783",
                        "longitude": "15.68749978648961",
                        "weather_stats": null,
                        "score": null
                    }
                ]
            }
        }]
    }
    ```

### Current Community Round
* **GET /api/v0/rounds/current_community_round**
  - Controller: Api::V0::RoundsController#current_community_round
  - Example Request:
    ```
    curl -X GET https://weather-together-be.onrender.com/api/v0/rounds/current_community_round
    ```
  - Example Response:
    ```json
    {
    "data": {
        "id": "92",
        "type": "round",
        "attributes": {
            "close_date": "2024-01-13",
            "number_of_votes": 12,
            "target_weather_stats": "{\"location\":{\"name\":\"Ialibu\",\"region\":\"Southern Highlands\",\"country\":\"Papua New Guinea\",\"lat\":-6.32,\"lon\":143.96,\"tz_id\":\"Pacific/Port_Moresby\",\"localtime_epoch\":1705081061,\"localtime\":\"2024-01-13 3:37\"},\"weather_data\":{\"maxtemp_c\":19.4,\"maxtemp_f\":66.9,\"mintemp_c\":10.6,\"mintemp_f\":51.1,\"avgtemp_c\":13.9,\"avgtemp_f\":57.1,\"maxwind_mph\":3.1,\"maxwind_kph\":5.0,\"totalprecip_mm\":23.06,\"totalprecip_in\":0.91,\"totalsnow_cm\":0.0,\"avgvis_km\":6.6,\"avgvis_miles\":4.0,\"avghumidity\":95,\"daily_will_it_rain\":1,\"daily_chance_of_rain\":100,\"daily_will_it_snow\":0,\"daily_chance_of_snow\":0,\"condition\":{\"text\":\"Light rain shower\",\"icon\":\"//cdn.weatherapi.com/weather/64x64/day/353.png\",\"code\":1240},\"uv\":7.0}}",
            "status": "open",
            "game_id": 18,
            "votes": [
                {
                    "vote_id": 900,
                    "user_id": 222,
                    "round_id": 92,
                    "status": "unprocessed",
                    "target_weather_stats": "{\"location\":{\"name\":\"Ialibu\",\"region\":\"Southern Highlands\",\"country\":\"Papua New Guinea\",\"lat\":-6.32,\"lon\":143.96,\"tz_id\":\"Pacific/Port_Moresby\",\"localtime_epoch\":1705081061,\"localtime\":\"2024-01-13 3:37\"},\"weather_data\":{\"maxtemp_c\":19.4,\"maxtemp_f\":66.9,\"mintemp_c\":10.6,\"mintemp_f\":51.1,\"avgtemp_c\":13.9,\"avgtemp_f\":57.1,\"maxwind_mph\":3.1,\"maxwind_kph\":5.0,\"totalprecip_mm\":23.06,\"totalprecip_in\":0.91,\"totalsnow_cm\":0.0,\"avgvis_km\":6.6,\"avgvis_miles\":4.0,\"avghumidity\":95,\"daily_will_it_rain\":1,\"daily_chance_of_rain\":100,\"daily_will_it_snow\":0,\"daily_chance_of_snow\":0,\"condition\":{\"text\":\"Light rain shower\",\"icon\":\"//cdn.weatherapi.com/weather/64x64/day/353.png\",\"code\":1240},\"uv\":7.0}}",
                    "latitude": "12.745354201417783",
                    "longitude": "15.68749978648961",
                    "weather_stats": null,
                    "score": null
                         },
                          ...
                ]
            }
        }]
    }
    ```

### Votes for a Round
* **GET /api/v0/rounds/:id/votes**
  - Controller: Api::V0::Rounds::VotesController#index
  - Example Request:
    ```
    curl -X GET https://weather-together-be.onrender.com/api/v0/rounds/1/votes
    ```
  - Example Response:
    ```json
    {
    "data": [
        {
            "id": "900",
            "type": "vote",
            "attributes": {
                "target_weather_stats": "{\"location\":{\"name\":\"Ialibu\",\"region\":\"Southern Highlands\",\"country\":\"Papua New Guinea\",\"lat\":-6.32,\"lon\":143.96,\"tz_id\":\"Pacific/Port_Moresby\",\"localtime_epoch\":1705081061,\"localtime\":\"2024-01-13 3:37\"},\"weather_data\":{\"maxtemp_c\":19.4,\"maxtemp_f\":66.9,\"mintemp_c\":10.6,\"mintemp_f\":51.1,\"avgtemp_c\":13.9,\"avgtemp_f\":57.1,\"maxwind_mph\":3.1,\"maxwind_kph\":5.0,\"totalprecip_mm\":23.06,\"totalprecip_in\":0.91,\"totalsnow_cm\":0.0,\"avgvis_km\":6.6,\"avgvis_miles\":4.0,\"avghumidity\":95,\"daily_will_it_rain\":1,\"daily_chance_of_rain\":100,\"daily_will_it_snow\":0,\"daily_chance_of_snow\":0,\"condition\":{\"text\":\"Light rain shower\",\"icon\":\"//cdn.weatherapi.com/weather/64x64/day/353.png\",\"code\":1240},\"uv\":7.0}}",
                "lat": "12.745354201417783",
                "lon": "15.68749978648961",
                "weather_stats": null,
                "score": null,
                "status": "unprocessed",
                "round_id": 92,
                "user_id": 222,
                "username": "HelpfulPug"
            }
        }
    ]
    }
    ```

### New Vote for a Round
* **POST /api/v0/users/:user_id/rounds/:round_id/votes/new**
  - Controller: Api::V0::Rounds::VotesController#create
  - Example Request:
    ```
    curl -X POST https://weather-together-be.onrender.com/api/v0/users/221/rounds/92/votes/new -d '"lat": 46.8, "lon": 10.3'
    ```
  - Example Response:
    ```json
    {
    "data": {
        "id": "901",
        "type": "vote",
        "attributes": {
            "target_weather_stats": "{\"location\":{\"name\":\"Ialibu\",\"region\":\"Southern Highlands\",\"country\":\"Papua New Guinea\",\"lat\":-6.32,\"lon\":143.96,\"tz_id\":\"Pacific/Port_Moresby\",\"localtime_epoch\":1705081061,\"localtime\":\"2024-01-13 3:37\"},\"weather_data\":{\"maxtemp_c\":19.4,\"maxtemp_f\":66.9,\"mintemp_c\":10.6,\"mintemp_f\":51.1,\"avgtemp_c\":13.9,\"avgtemp_f\":57.1,\"maxwind_mph\":3.1,\"maxwind_kph\":5.0,\"totalprecip_mm\":23.06,\"totalprecip_in\":0.91,\"totalsnow_cm\":0.0,\"avgvis_km\":6.6,\"avgvis_miles\":4.0,\"avghumidity\":95,\"daily_will_it_rain\":1,\"daily_chance_of_rain\":100,\"daily_will_it_snow\":0,\"daily_chance_of_snow\":0,\"condition\":{\"text\":\"Light rain shower\",\"icon\":\"//cdn.weatherapi.com/weather/64x64/day/353.png\",\"code\":1240},\"uv\":7.0}}",
            "lat": "46.8",
            "lon": "10.3",
            "weather_stats": null,
            "score": null,
            "status": "unprocessed",
            "round_id": 92,
            "user_id": 221,
            "username": "OutstandingMammoth"
                         }
             }
    }
    ```

###
* **POST /api/v0/users/:user_id/rounds/:round_id/votes/new**
  - Controller: Api::V0::Rounds::VotesController#create
  - Example Request:
    ```
    curl -X POST https://weather-together-be.onrender.com/api/v0/users/221/rounds/92/votes/new -d '"lat": 46.8, "lon": 10.3'
    ```
  - Example Response:
    ```json
    ```

### Health Check Route
* **GET /up**
  - Controller: Rails::HealthController#show (named route: rails_health_check)
  - Example Request:
    ```
    curl -X GET https://weather-together-be.onrender.com/up
    ```
  - Example Response:
    ```html
    <!DOCTYPE html>
    <html>
    <body style="background-color: green"></body>
    </html>
    ```