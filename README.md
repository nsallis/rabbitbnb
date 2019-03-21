# Rabbitbnb

a code challenge to show off rabbitmq, docker-compose, and rails.

## setup

* make sure you have docker and docker-compose installed.
* we need to set up the db for rails: `./setup` (from the root application directory)
* start the main application: `./start`
* inject a "vote" into rabbitmq's default exchange: `./rate BNB_NAME FIRST_NAME LAST_NAME`
* take a look at localhost:3000/ratings to show all existing bnbs, their number of votes and who voted for them.
* take a look at localhost:3000/ratings/BNB_NAME to see the bnb and its votes

If you check the logs for the main application, you will notice that if you try to vote more than once, you will get an error response.

As an easter-egg, you can run `./rig_the_polls BNB_NAME` to rig the polls and give the bnb of your choice 10 votes at once using random names.

To reset the application database, use `./reset`
