FROM bitwalker/alpine-elixir-phoenix:1.9.4

#  Install postgresql-client that is used on the entrypoint script
RUN apk update && apk add postgresql-client && rm -rf /var/cache/apk/*

COPY . /my_app
WORKDIR /my_app
# Get dependencies and compile the project
RUN ["/bin/bash", "-c", "chmod +x entrypoint.sh \
 && mix deps.get \
 && cd assets \
 && npm install \
 && node node_modules/webpack/bin/webpack.js --mode development"]

CMD ["./entrypoint.sh"]