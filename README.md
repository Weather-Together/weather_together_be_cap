
<a name="readme-top"></a>
<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![Build Status](https://img.shields.io/github/workflow/status/Weather-Together/weather_together_be/main/main)](https://github.com/Weather-Together/weather_together_be/actions)


[![Code Coverage](https://img.shields.io/badge/coverage-95%25-brightgreen)](https://example.com/coverage-report)



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Weather-Together/weather_together_be">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Weather Together</h3>

  <p align="center">
    project_description
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
    <li><a href="#contributers">Contributers</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](FINAL URL LATER)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



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

### Prerequisites

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

Weather Together is a game app where a daily set of weather data is displayed to the user (player) from a randomly selected location in the world. Each day the player guesses a location where they think this weather data was collected through an interactive map selector. They are able to keep track of prior guesses as well as track their progress on a leaderboard.

The goal of this app is to provide public education and increase awareness of general global climate trends in a fun and interactive manner.

This portion of the app handles the backend functionality of the game:
* Creates new user from input recieved from frontend and creates mailer with token to be passed to frontend for account activation.
* Consumes external weather API and configured into proper format to be consumed by frontend portion of the application
* Chron job for rake task to consume API at regular intervals.
* Performs calculations for results and leaderboard then configures in format to be useable by the frontend.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [ ] Database Schema
- [ ] New User Creation, Mailbox
    - [ ] Generate Token
    - [ ] Generate Verification Email to be Used by Frontend
- [ ] Cron Job and Rake Task
- [ ] API Consumption
    - [ ] Weather Data
    - [ ] Endpoints to be Consumed by Frontend
- [ ] Statistics
    - [ ] Game Results (r^2)
    - [ ] Daily Leaderboard
- [ ] Action Cable 
- [ ] Addition of Private Games



See the [open issues](https://github.com/Weather-Together/weather_together_be/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Organization: Weather Together - UPDATE WITH FUTURE EMAIL

Organization Link: [https://github.com/Weather-Together](https://github.com/Weather-Together)

Project Link: [https://github.com/Weather-Together/weather_together_be](https://github.com/Weather-Together/weather_together_be)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Contributors

Michael Kuhlmeier [![LinkedIn][linkedin-shield]][linkedin-url-mk] 


Blaine Kennedy [![LinkedIn][linkedin-shield]][linkedin-url-bk] 


John O'leary [![LinkedIn][linkedin-shield]][linkedin-url-jo] 


Sam Tran [![LinkedIn][linkedin-shield]][linkedin-url-st] 


Kevin Zolman [![LinkedIn][linkedin-shield]][linkedin-url-kz] 





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