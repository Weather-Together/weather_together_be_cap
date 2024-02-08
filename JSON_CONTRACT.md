## API Endpoints



### 1. New User
* **POST api/v0/users/create**
 - Controller: Api::V0::UsersController#create
 - Example Request:
  ```json
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
  ```json
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

 ### 2.To Daily Round from Email Verification
* **GET api/v0/users/:id/verify_account/:token**
 - Controller: Api::V0::UsersController#verify_account(named route: verify_account)
 - Example Request:
  ```
  curl -X GET https://weather-together-be.onrender.com/verify_account
  ```
 - Example Responses:
  ```json
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
### 3. To Daily Round from Login
* **GET api/v0/users/login**
 - Controller: Api::V0::UsersController#login(named route: login)
 - Example Request:
  ```
  curl -X GET https://weather-together-be.onrender.com/api/v0/users/login -d ‘”email”: “new@email.com” , “password”: “New1!!”’
  ```
 - Example Response:
  ```json
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

  ### 4. Daily Round
* **GET /api/v0/users/:user_id/rounds/current_daily_round**
  - Controller: Api::V0::RoundsController#daily_round
  - Example Request:
    ```
    curl -X GET https://weather-together-be.onrender.com/api/v0/users/:user_id/rounds/current_daily_round
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
            "status": "open",
            "game_id": 18,
            "location_name": "Ialibu",
            "region": "Southern Highlands",
            "country": "Papua New Guinea",
            "maxtemp_f": 72.0,
            "mintemp_f": 58.6,
            "avgtemp_f": null,
            "maxwind_mph": 4.9,
            "totalprecip_in": 0.66,
            "avghumidity": 92,
            "daily_chance_of_rain": 100,
            "daily_chance_of_snow": 0,
            "votes": [
                {
                    "vote_id": 51,
                    "user_id": 1,
                    "round_id": 6,
                    "status": "unprocessed",
                    "latitude": "-15.74",
                    "longitude": "-54.34",
                    "score": null,
                    "location_name": null,
                    "region": null,
                    "country": null
                         },
                          ...
                ]
            }
        }]
    }
    ```

     ### 5. New Vote for a Daily Game
* **POST /api/v0/users/:user_id/rounds/current_daily_round/vote**
  - Controller: Api::V0::Users::RoundsController#daily_vote
  - Example Request:
    ```
    curl -X POST https://weather-together-be.onrender.com/api/v0/users/221/rounds/current_daily_round/vote -d '"lat": 46.8, "lon": 10.3'
    ```
  - Example Response:
    ```json
    {
    "data": {
        "id": "901",
        "type": "vote",
        "attributes": {
                "lat": "-15.74",
                "lon": "-54.34",
                "score": 23176.78,
                "status": "processed",
                "round_id": 1,
                "user_id": 1,
                "username": "username1",
                "location_name": "Alto Coite",
                "region": "Mato Grosso",
                "country": "Brazil",
                "maxtemp_f": 92.5,
                "mintemp_f": 68.8,
                "avgtemp_f": null,
                "maxwind_mph": 13.6,
                "totalprecip_in": 0.5,
                "avghumidity": 78,
                "daily_chance_of_rain": 100,
                "daily_chance_of_snow": 0
                         }
             }
    }
    ```

     ### 6. daily game stats
* **GET /api/v0/users/:user_id/votes**
  - Controller: Api::V0::Users::VotesController#index
  - Example Request:
    ```
    curl -X GET https://weather-together-be.onrender.com/api/v0/users/221/votes 
    ```
  - Example Response:
    ```json
    {
    "data": [
      {
        "id": "901",
        "type": "vote",
        "attributes": {
                "lat": "-15.74",
                "lon": "-54.34",
                "score": 23176.78,
                "status": "processed",
                "round_id": 1,
                "user_id": 1,
                "username": "username1",
                "location_name": "Alto Coite",
                "region": "Mato Grosso",
                "country": "Brazil",
                "maxtemp_f": 92.5,
                "mintemp_f": 68.8,
                "avgtemp_f": null,
                "maxwind_mph": 13.6,
                "totalprecip_in": 0.5,
                "avghumidity": 78,
                "daily_chance_of_rain": 100,
                "daily_chance_of_snow": 0
                         }
             }, 
             ...
             ]
    }
    ```

     ### 7. Competitive Game Stats
* **GET /api/v0/rounds/most_recent_competitive/votes**
  - Controller: Api::V0::Rounds::VotesController#index
  - Example Request:
    ```
    curl -X GET https://weather-together-be.onrender.com/api/v0/rounds/most_recent_competitive/votes
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
          "status": "open",
          "game_id": 18,
          "location_name": "Якутск",
          "region": "Sakha",
          "country": "Russia",
          "maxtemp_f": -9.7,
          "mintemp_f": -27.5,
          "avgtemp_f": null,
          "maxwind_mph": 5.1,
          "totalprecip_in": 0.0,
          "avghumidity": 97,
          "daily_chance_of_rain": 45,
          "daily_chance_of_snow": 0,
          "votes": [
              {
                  "vote_id": 900,
                  "user_id": 222,
                  "round_id": 92,
                  "status": "unprocessed",
                  "latitude": "12.745354201417783",
                  "longitude": "15.68749978648961",
                  "score": null,
                  "location_name": null,
                  "region": null,
                  "country": null
                      },
                        ...
              ]
          }

      }
  }
    ```

 ### 8. Private Game Index
* **GET /api/v0/users/:id/games**
  - Controller: Api::V0::Users::GamesController#index
  - Example Request:
    ```
    curl -X GET https://weather-together-be.onrender.com/api/v0/users/:id/games
    ```
  - Example Response:
    ```json
    {
    "data":[
       {
        "id": "92",
        "type": "game",
        "attributes": {
            "game_type": 0,
            "length_in_days": 145,
            "guess_lead_time": 12,
            "player_cap": 18,
            "status": 0,
            "start_date": "2024-02-02",
            "users": [
                          {
                  "id": "240",
                  "type": "user",
                  "attributes": {
                      "email": "new@gmail.com",
                      "username": "new"
                                }
                           },
                         ...
                      ]
                      }
         }, 
             ...
              ]
    }
    ```


     ### 9. Competitive Round
* **GET /api/v0/rounds/competitive_round**
  - Controller: Api::V0::RoundsController#competitive_round
  - Example Request:
    ```
    curl -X GET https://weather-together-be.onrender.com/api/v0/rounds/competitive_round
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
            "status": "open",
            "game_id": 18,
            "location_name": "Ialibu",
            "region": "Southern Highlands",
            "country": "Papua New Guinea",
            "maxtemp_f": 72.0,
            "mintemp_f": 58.6,
            "avgtemp_f": null,
            "maxwind_mph": 4.9,
            "totalprecip_in": 0.66,
            "avghumidity": 92,
            "daily_chance_of_rain": 100,
            "daily_chance_of_snow": 0,
            "votes": [
                {
                    "vote_id": 51,
                    "user_id": 1,
                    "round_id": 6,
                    "status": "unprocessed",
                    "latitude": "-15.74",
                    "longitude": "-54.34",
                    "score": null,
                    "location_name": null,
                    "region": null,
                    "country": null
                         },
                          ...
                ]
            }
        }
    }
    ```

    ### 10. New Vote for a Competitive Game
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
            "lat": "46.8",
            "lon": "10.3",
            "weather_stats": null,
            "score": null,
            "status": "unprocessed",
            "round_id": 92,
            "user_id": 221,
            "username": "OutstandingMammoth",
            "location_name": null,
            "region": null,
            "country": null,
            "maxtemp_f": null,
            "mintemp_f": null,
            "avgtemp_f": null,
            "maxwind_mph": null,
            "totalprecip_in": null,
            "avghumidity": null,
            "daily_chance_of_rain": null,
            "daily_chance_of_snow": null
                         }
             }
    }
    ```

     ### 11. NEW Private Game 
* **POST /api/v0/users/:id/games**
  - Controller: Api::V0::Users::GamesController#create
  - Example Request:
    ```
    curl -X POST https://weather-together-be.onrender.com/api/v0/users/:id/games
    	-d {
          "length_in_days": 145,
          "guess_lead_time": 12,
          "player_cap": 12,
          "invitees": ["email1@gmail.com, email2@gmail.com,
                      email3@gmail.com, ...]
          }
    ```
  - Example Response:
    ```json
   {
    "data": {
        "id": "92",
        "type": "game",
        "attributes": {
            "game_type": 0,
            "length_in_days": 145,
            "guess_lead_time": 12,
            "player_cap": 18,
            "status": 0,
            "start_date": "2024-02-02",
            "close_date": "2024-06-30",
            "users": [
                          {
                  "id": "240",
                  "type": "user",
                  "attributes": {
                      "email": "new@gmail.com",
                      "username": "new"
                                }
                           },
                         ...
                      ]
                      }
             }
    }
    ```

     ### 12. Private Game Show
* **GET /api/v0/users/:id/games/:id**
  - Controller: Api::V0::Users::GamesController#show
  - Example Request:
    ```
    curl -X GET https://weather-together-be.onrender.com/api/v0/users/:id/games/:id
    ```
  - Example Response:
    ```json
   {
    "data": {
        "id": "92",
        "type": "game",
        "attributes": {
            "game_type": 0,
            "length_in_days": 145,
            "guess_lead_time": 12,
            "player_cap": 18,
            "status": 0,
            "start_date": "2024-02-02",
            "users": [
                          {
                  "id": "240",
                  "type": "user",
                  "attributes": {
                      "email": "new@gmail.com",
                      "username": "new"
                                }
                           },
                         ...
                      ]
                      }
             }
    }
    ```





     ### 13. Private Game
* **GET /api/v0/games/:id/current_round**
  - Controller: Api::V0::Games::RoundsController#current_round
  - Example Request:
    ```
    curl -X GET https://weather-together-be.onrender.com/api/v0/games/:id/current_round
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
            "status": "open",
            "game_id": 18,
            "location_name": "Ialibu",
            "region": "Southern Highlands",
            "country": "Papua New Guinea",
            "maxtemp_f": 72.0,
            "mintemp_f": 58.6,
            "avgtemp_f": null,
            "maxwind_mph": 4.9,
            "totalprecip_in": 0.66,
            "avghumidity": 92,
            "daily_chance_of_rain": 100,
            "daily_chance_of_snow": 0,
            "votes": [
                {
                    "vote_id": 51,
                    "user_id": 1,
                    "round_id": 6,
                    "status": "unprocessed",
                    "latitude": "-15.74",
                    "longitude": "-54.34",
                    "score": null,
                    "location_name": null,
                    "region": null,
                    "country": null
                         },
                          ...
                ]
            }
        }
    }
    ```

     ### 14. New Vote for a Private Game
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
            "lat": "46.8",
            "lon": "10.3",
            "weather_stats": null,
            "score": null,
            "status": "unprocessed",
            "round_id": 92,
            "user_id": 221,
            "username": "OutstandingMammoth",
            "location_name": null,
            "region": null,
            "country": null,
            "maxtemp_f": null,
            "mintemp_f": null,
            "avgtemp_f": null,
            "maxwind_mph": null,
            "totalprecip_in": null,
            "avghumidity": null,
            "daily_chance_of_rain": null,
            "daily_chance_of_snow": null
                         }
             }
    }
    ```

### 15. To User Profile
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
### 16. Edit Account
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



  ### 17. Accept/Decline Invitation for Private Game
* **PATCH /api/v0/users/:user_id/games/:game_id**
  - Controller: Api::V0::Users::GamesController#create
  - Example Requests:
    ```
    curl -X PATCH https://weather-together-be.onrender.com/api/v0/users/221/games/92 -d '"rsvp": "accept"
    curl -X PATCH https://weather-together-be.onrender.com/api/v0/users/221/games/92 -d '"rsvp": "decline"
    ```
  - Example Response:
    
    ```json
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

    Status Code 202 : Succesfully Accepted Invitation

    Status Code 204 : Succesfully Deleted Invitation

    Status Code 404 : User/game relationship not found

      ### 18. Daily Game User Stats
* **GET api/v0/users/:id**
  - Controller: Api::V0::UsersController#daily_stats
  - Example Request:
  ```
  curl -X GET https://weather-together-be.onrender.com/api/v0/users/240/daily_stats 
  ```
  - Example Response:
  ```json
  {
    "daily_stats": {
        "daily_game_count": 6,
        "average_score_in_daily_games": null,
        "date_and_score_of_best_daily_score": {
            "date": "2024-02-04",
            "score": null
        },
        "grade_book_daily_round": {
            "0.00-500.00": 0,
            "500.01-1000.00": 0,
            "1000.01-2000.00": 0,
            "2000.01-5000.00": 0,
            "5000.01+": 0
        }
    }
  }
  ```

    ### 19. Competitive Game User Stats
* **GET api/v0/users/:id**
  - Controller: Api::V0::UsersController#competitive_stats
  - Example Request:
  ```
  curl -X GET https://weather-together-be.onrender.com/api/v0/users/240/competitive_stats 
  ```
  - Example Response:
  ```json
  {
    "competitive_stats": {
        "top_5_competitive_users": [
            {
                "user_id": 10,
                "username": "username10",
                "score": 6277.015
            },
            {
                "user_id": 2,
                "username": "username2",
                "score": 12376.275000000001
            },
            {
                "user_id": 4,
                "username": "username4",
                "score": 14370.864999999998
            },
            {
                "user_id": 1,
                "username": "username1",
                "score": 14681.955
            },
            {
                "user_id": 9,
                "username": "username9",
                "score": 15003.634999999998
            },
            {
                "user_id": 5,
                "username": "username5",
                "score": 16385.595
            }
        ],
        "user_competitive_rank": 4,
        "competitive_game_count": 6,
        "average_score_in_competitive_games": 16854.288,
        "top_three_competitive_rounds_by_score": [
            {
                "id": 2,
                "game_id": 1,
                "status": "processed",
                "created_at": "2024-02-05T21:29:29.245Z",
                "updated_at": "2024-02-05T21:29:37.643Z",
                "close_date": "2024-02-02",
                "process_date": "2024-02-05",
                "game_type": "competitive",
                "location_name": "Longyearbyen (Svalbard)",
                "region": "Sogn og Fjordane",
                "country": "Norway",
                "maxtemp_f": 20.3,
                "mintemp_f": 4.7,
                "avgtemp_f": null,
                "maxwind_mph": 13.0,
                "totalprecip_in": 0.0,
                "avgvis_miles": 6.0,
                "avghumidity": 89,
                "daily_chance_of_rain": 45,
                "daily_chance_of_snow": 0,
                "lat": "78.22",
                "lon": "15.63"
            },
            {
                "id": 2,
                "game_id": 1,
                "status": "processed",
                "created_at": "2024-02-05T21:29:29.245Z",
                "updated_at": "2024-02-05T21:29:37.643Z",
                "close_date": "2024-02-02",
                "process_date": "2024-02-05",
                "game_type": "competitive",
                "location_name": "Longyearbyen (Svalbard)",
                "region": "Sogn og Fjordane",
                "country": "Norway",
                "maxtemp_f": 20.3,
                "mintemp_f": 4.7,
                "avgtemp_f": null,
                "maxwind_mph": 13.0,
                "totalprecip_in": 0.0,
                "avgvis_miles": 6.0,
                "avghumidity": 89,
                "daily_chance_of_rain": 45,
                "daily_chance_of_snow": 0,
                "lat": "78.22",
                "lon": "15.63"
            },
            {
                "id": 2,
                "game_id": 1,
                "status": "processed",
                "created_at": "2024-02-05T21:29:29.245Z",
                "updated_at": "2024-02-05T21:29:37.643Z",
                "close_date": "2024-02-02",
                "process_date": "2024-02-05",
                "game_type": "competitive",
                "location_name": "Longyearbyen (Svalbard)",
                "region": "Sogn og Fjordane",
                "country": "Norway",
                "maxtemp_f": 20.3,
                "mintemp_f": 4.7,
                "avgtemp_f": null,
                "maxwind_mph": 13.0,
                "totalprecip_in": 0.0,
                "avgvis_miles": 6.0,
                "avghumidity": 89,
                "daily_chance_of_rain": 45,
                "daily_chance_of_snow": 0,
                "lat": "78.22",
                "lon": "15.63"
            }
        ],
        "last_three_competitive_games_rank": [
            {
                "round_id": 2,
                "user_rank": 3
            },
            {
                "round_id": 1,
                "user_rank": 6
            }
        ],
        "top_three_finishes_competitive": [
            [
                "2024-02-05",
                7146.179999999999
            ],
            [
                "2024-02-04",
                22217.73
            ]
        ]
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