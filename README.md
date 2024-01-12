
<a name="readme-top"></a>
<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]


[![Weather Together](https://img.shields.io/badge/Weather%20Together-Visit%20Website-blue?style=for-the-badge)](https://weather-together.onrender.com/)






<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Weather-Together/weather_together_be">
    <img src="images/logo_480.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Weather Together</h3>

  <p align="center">
    Weather Together is a game app where a daily set of weather data is displayed to the user (player) from a randomly selected location in the world. Each day the player guesses a location where they think this weather data was collected through an interactive map selector. They are able to keep track of prior guesses as well as track their progress on a leaderboard.

The goal of this app is to provide public education and increase awareness of general global climate trends in a fun and interactive manner.
    <br />
    <a href="https://github.com/Weather-Together/weather_together_be"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Weather-Together/weather_together_be">View Demo</a>
    ·
    <a href="https://github.com/Weather-Together/weather_together_be/issues">Report Bug</a>
    ·
    <a href="https://github.com/Weather-Together/weather_together_be/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#gems">Gems</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#contributors">Contributors</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

<img src="images/Map_WT.png" alt="Map" width="400" height="200">

[![Weather Together](https://img.shields.io/badge/Weather%20Together-Visit%20Website-blue?style=for-the-badge)](https://weather-together.onrender.com/)

### Built With
* [![Ruby on Rails][Rails-shield]][Rails-url]
* [![HTML][HTML-shield]][HTML-url]
* [![JavaScript][JavaScript-shield]][JavaScript-url]
* [![PostgreSQL][PostgreSQL-shield]][PostgreSQL-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Gems
* [![debug][gem-debug]][gem-debug-url]
* [![rspec-rails][gem-rspec-rails]][gem-rspec-rails-url]
* [![simplecov][gem-simplecov]][gem-simplecov-url]
* [![factory_bot_rails][gem-factory_bot_rails]][gem-factory_bot_rails-url]
* [![faker][gem-faker]][gem-faker-url]
* [![pry][gem-pry]][gem-pry-url]
* [![shoulda-matchers][gem-shoulda-matchers]][gem-shoulda-matchers-url]
* [![faraday][gem-faraday]][gem-faraday-url]
* [![figaro][gem-figaro]][gem-figaro-url]
* [![jsonapi-serializer][gem-jsonapi-serializer]][gem-jsonapi-serializer-url]
* [![capybara][gem-capybara]][gem-capybara-url]
* [![webmock][gem-webmock]][gem-webmock-url]
* [![vcr][gem-vcr]][gem-vcr-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple example steps.

### Database 

UPDATE WITH ANY OR REMOVE

### Installation

1. Get a free Weather API Key at [https://www.weatherapi.com/](https://www.weatherapi.com/)

2. Clone the repo
   ```sh
   git clone https://github.com/Weather-Together/weather_together_be.git
   ```
3. Enter your API
  Terminal
   ```sh
   EDITOR="code --wait" rails credentials:edit
   ```
    In editor pop up
    ```ruby
    weather_api:
      key: <YOUR API KEY>
    ```
4. Gem Bundle
   ```sh
    bundle
   ```
5. Rake
   ```sh
    rails db:{drop,create,migrate,seed}
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage


This portion of the app handles the backend functionality of the game:
* Creates new user from input recieved from frontend and creates mailer with token to be passed to frontend for account activation.
* Consumes external weather API and configured into proper format to be consumed by frontend portion of the application
* Chron job for rake task to consume API at regular intervals.
* Performs calculations for results and leaderboard then configures in format to be useable by the frontend.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [X] Database Schema
- [X] New User Creation, Mailbox
    - [X] Generate Token
    - [X] Generate Verification Email to be Used by Frontend
- [X] Cron Job and Rake Task
- [X] API Consumption
    - [X] Weather Data
    - [X] Endpoints to be Consumed by Frontend
- [X] Statistics
    - [X] Game Results (r^2)
    - [X] Daily Leaderboard
- [ ] Action Cable 
- [ ] Addition of Private Games



See the [open issues](https://github.com/Weather-Together/weather_together_be/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## API Endpoints

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

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Organization: Weather Together - WeatherTogether2308@gmail.com

Organization Link: [https://github.com/Weather-Together](https://github.com/Weather-Together)

Project Link: [https://github.com/Weather-Together/weather_together_be](https://github.com/Weather-Together/weather_together_be)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Contributors

Michael Kuhlmeier 
 
[![LinkedIn][linkedin-shield]][linkedin-url-mk]
[![GitHub][github-shield-mk]][github-url-mk]

Blaine Kennedy 

[![LinkedIn][linkedin-shield]][linkedin-url-bk] 
[![GitHub][github-shield-bk]][github-url-bk]


John O'Leary 

[![LinkedIn][linkedin-shield]][linkedin-url-jo] 
[![GitHub][github-shield-jo]][github-url-jo]

 Sam Tran 
 
 [![LinkedIn][linkedin-shield]][linkedin-url-st]
 [![GitHub][github-shield-st]][github-url-st]


Kevin Zolman 

[![LinkedIn][linkedin-shield]][linkedin-url-kz][![GitHub][github-shield-kz]][github-url-kz]





<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Weather-Together/weather_together_fe.svg?style=for-the-badge
[contributors-url]: https://github.com/Weather-Together/weather_together_fe/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Weather-Together/weather_together_fe.svg?style=for-the-badge
[forks-url]: https://github.com/Weather-Together/weather_together_fe/network/members
[stars-shield]: https://img.shields.io/github/stars/Weather-Together/weather_together_fe.svg?style=for-the-badge
[stars-url]: https://github.com/Weather-Together/weather_together_fe/stargazers
[issues-shield]: https://img.shields.io/github/issues/Weather-Together/weather_together_fe.svg?style=for-the-badge
[issues-url]: https://github.com/Weather-Together/weather_together_fe/issues
[license-shield]: https://img.shields.io/github/license/Weather-Together/weather_together_fe.svg?style=for-the-badge
[license-url]: https://github.com/Weather-Together/weather_together_fe/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url-st]: https://www.linkedin.com/in/sam-t-tran
[linkedin-url-kz]: https://www.linkedin.com/in/kevin-zolman
[linkedin-url-mk]: https://www.linkedin.com/in/michaelkuhlmeier
[linkedin-url-bk]: https://www.linkedin.com/in/blaine-kennedy
[linkedin-url-jo]: https://www.linkedin.com/in/john-clay-oleary
[product-screenshot]: images/screenshot.png
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[Rails-shield]: https://img.shields.io/badge/Ruby%20on%20Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white
[Rails-url]: https://rubyonrails.org/
[HTML-shield]: https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white
[HTML-url]: https://developer.mozilla.org/en-US/docs/Web/HTML
[JavaScript-shield]: https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black
[JavaScript-url]: https://developer.mozilla.org/en-US/docs/Web/JavaScript
[PostgreSQL-shield]: https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white
[PostgreSQL-url]: https://www.postgresql.org/

[gem-debug]: https://img.shields.io/badge/debug-1.9.1-brightgreen?style=flat-square
[gem-debug-url]: https://rubygems.org/gems/debug

[gem-rspec-rails]: https://img.shields.io/badge/rspec--rails-6.1.0-green?style=flat-square
[gem-rspec-rails-url]: https://github.com/rspec/rspec-rails

[gem-simplecov]: https://img.shields.io/badge/simplecov-0.22.0-yellow?style=flat-square
[gem-simplecov-url]: https://github.com/simplecov-ruby/simplecov

[gem-factory_bot_rails]: https://img.shields.io/badge/factory_bot_rails-6.4.0-success?style=flat-square
[gem-factory_bot_rails-url]: https://github.com/thoughtbot/factory_bot_rails

[gem-faker]: https://img.shields.io/badge/faker-3.2.2-red?style=flat-square
[gem-faker-url]: https://github.com/faker-ruby/faker

[gem-pry]: https://img.shields.io/badge/pry-0.14.2-yellow?style=flat-square
[gem-pry-url]: https://github.com/pry/pry

[gem-shoulda-matchers]: https://img.shields.io/badge/shoulda--matchers-6.0.0-orange?style=flat-square
[gem-shoulda-matchers-url]: https://github.com/thoughtbot/shoulda-matchers

[gem-faraday]: https://img.shields.io/badge/faraday-2.8.1-yellowgreen?style=flat-square
[gem-faraday-url]: https://github.com/lostisland/faraday

[gem-figaro]: https://img.shields.io/badge/figaro-1.2.0-critical?style=flat-square
[gem-figaro-url]: https://github.com/laserlemon/figaro

[gem-jsonapi-serializer]: https://img.shields.io/badge/jsonapi--serializer-2.2.0-blue?style=flat-square
[gem-jsonapi-serializer-url]: https://github.com/jsonapi-serializer/jsonapi-serializer

[gem-capybara]: https://img.shields.io/badge/capybara-3.39.2-brightgreen?style=flat-square
[gem-capybara-url]: https://github.com/teamcapybara/capybara

[gem-webmock]: https://img.shields.io/badge/webmock-3.19.1-yellowgreen?style=flat-square
[gem-webmock-url]: https://github.com/bblimke/webmock

[gem-vcr]: https://img.shields.io/badge/vcr-6.2.0-orange?style=flat-square
[gem-vcr-url]: https://github.com/vcr/vcr


[github-shield-mk]: https://img.shields.io/badge/GitHub-mbkuhl-success?style=for-the-badge&logo=github
[github-url-mk]: https://github.com/mbkuhl

[github-shield-jo]: https://img.shields.io/badge/GitHub-Captainlearyo-success?style=for-the-badge&logo=github
[github-url-jo]: https://github.com/Captainlearyo

[github-shield-st]: https://img.shields.io/badge/GitHub-Sykogst-success?style=for-the-badge&logo=github
[github-url-st]: https://github.com/Sykogst

[github-shield-kz]: https://img.shields.io/badge/GitHub-zkevkev-success?style=for-the-badge&logo=github
[github-url-kz]: https://github.com/zkevkev

[github-shield-bk]: https://img.shields.io/badge/GitHub-bkchilidawg-success?style=for-the-badge&logo=github
[github-url-bk]: https://github.com/bkchilidawg
