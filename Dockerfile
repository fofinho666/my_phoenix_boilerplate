FROM bitwalker/alpine-elixir-phoenix:1.9.4

#  Install postgresql-client that is used on the entrypoint script
RUN apk update && apk add postgresql-client && rm -rf /var/cache/apk/*

COPY . /my_app

# Get dependencies and compile project

WORKDIR /my_app
RUN mix deps.get
RUN ["/bin/bash", "-c", "cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode development"]

RUN chmod +x entrypoint.sh
CMD ["./entrypoint.sh"]