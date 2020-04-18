#!/bin/bash
# Docker entrypoint script for Dockerfile.

# extract the protocol
proto="$(echo "$DATABASE_URL" | grep '://' | sed -e's,^\(.*://\).*,\1,g')"
# remove the protocol
url=$(echo "$DATABASE_URL" | sed -e s,"$proto",,g)
# extract the user and password (if any)
userpass="$(echo "$url" | grep @ | cut -d@ -f1)"
password=$(echo "$userpass" | grep : | cut -d: -f2)
if [ -n "$password" ]; then
    user=$(echo "$userpass" | grep : | cut -d: -f1)
else
    user=$userpass
fi
# extract the host and port (if any)
hostport=$(echo "$url" | sed -e s,"$userpass"@,,g | cut -d/ -f1)
port=$(echo "$hostport" | grep : | cut -d: -f2)
if [ -n "$port" ]; then
    host=$(echo "$hostport" | grep : | cut -d: -f1)
else
    host=$hostport
fi
# extract the path (if any)
dbname="$(echo "$url" | grep / | cut -d/ -f2-)"

# Wait until Postgres is ready
while ! pg_isready -q -h "$host" -p "$port" -U "$user"
do
  echo "[entrypoint script] $(date) - waiting for database to start"
  sleep 2
done

# Create, migrate, and seed database if it doesn't exist.
if [[ -z $(psql "host=$host port=$port dbname=$dbname user=$user password=$password" -Atqc "\\list $dbname") ]]; then
  echo "[entrypoint script] Database $dbname does not exist. Creating..."
  mix ecto.setup
  echo "[entrypoint script] Database $dbname created."
fi

echo "[entrypoint script] Starting Phoenix server"
mix phx.server
