# README

This README would normally document whatever steps are necessary to get the
application up and running.

## This app consumes the [live-score-api](https://live-score-api.com/leagues/league/57/Mexico?competition_id=45) 


This project consumes the live football api, which has 4 endpoints:
- Standings: Shows the score table indicating the relative positions of the competitors.
- Livescores: Provides real-time information on Liga Mx matches
- Fixtures: List of all the matches and details of the Liga Mx
- Welcome: Show a welcome message.


* Ruby version

### 2.5.5

* Deployment instructions

- Clone the project
- Run ```bundle install```
- Create a file with the following route ```config/application.yml``` with the following data:
```
base_url: https://livescore-api.com
competition_id: 45
key: foo
secret: foo
fixtures_endpoint: '/api-client/fixtures/matches'
livescores_endpoint: '/api-client/scores/live'
standings_endpoint: '/api-client/leagues/table'
```
*** Send me email to request the key and secret. Also you should create your own credentials in [live-score-api](https://live-score-api.com/leagues/league/57/Mexico?competition_id=45) 

- To get the server up, run: ```rails s```
- Run the test, run: ```bundle exec rspec```


## Extra resources
- API Live soccer: https://live-score-api.com/leagues/league/57/Mexico?competition_id=45
