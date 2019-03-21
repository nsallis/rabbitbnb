# Rabbitbnb

a code challenge to show off rabbitmq, docker-compose, and rails.

## setup

* make sure you have docker and docker-compose installed.
* we need to set up the db for rails: `docker-compose run api rake db:create db:migrate`
* start the main application: `docker-compose up`
* inject a "vote" into rabbitmq's default exchange: `docker-compose run parser ruby send_rating.rb BNB_NAME FIRST_NAME LAST_NAME`
* take a look at localhost:3000/ratings to show all existing bnbs and their number of votes.
* take a look at localhost:3000/ratings/BNB_NAME to see the bnb and its votes

If you check the logs for the main application, you will notice that if you try to vote more than once, you will get an error response.
