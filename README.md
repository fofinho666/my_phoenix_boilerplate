# My Phoenix boilerplate

This is a base project that I use to start a web application in Elixir.

## Requirements

In order to get up and running you only need [Docker](https://hub.docker.com/search?q=&type=edition&offering=community) running on your machine.

This project has a docker-compose file with all services needed to run the application without any hassle.

## Running
To run it you have the following commands:
  * To build the docker image you can run the following command: `docker-compose build`
  * To start the application, enter `docker-compose up`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Development
If you want to develop you can this project you can enter the Phoenix container with the following command:

`docker-compose run --rm --service-ports phoenix bash`

Inside the container you can develop like you were on your local machine.
Here some useful commands :

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`
  * Run all unit tests `mix test`
  * Run specific a unit test `mix test <PATH_TO_TEST_FILE:LINE>`
