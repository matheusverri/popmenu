#!/bin/bash
set -e

rm -f /popmenu/tmp/pids/server.pid || true

# Só espera o Postgres quando for comando que realmente precisa de DB
NEEDS_DB=false
case "$1 $2" in
  rails\ s*|rails\ server*|puma*|bundle\ exec\ puma*|rails\ db*|rake\ db* )
    NEEDS_DB=true
    ;;
esac

if [ "$NEEDS_DB" = true ]; then
  until nc -z db 5432; do
    echo "Aguardando Postgres..."
    sleep 1
  done
  echo "Postgres está pronto!"
fi

exec "$@"