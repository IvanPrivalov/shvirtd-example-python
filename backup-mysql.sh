#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="/opt/backup"
CNF="/opt/backup/.mysql.env"

NETWORK="shvirtd-example-python_backend"
DB_HOST="db"

DB_NAME="virtd"

mkdir -p "$BACKUP_DIR"

. "$CNF"

TS="$(date +'%Y-%m-%d_%H-%M-%S')"
OUT="${BACKUP_DIR}/${DB_NAME}_${TS}.sql"

docker run --rm \
  --network "${NETWORK}" \
  -e MYSQL_HOST="${DB_HOST}" \
  -e MYSQL_USER="${MYSQL_USER}" \
  -e MYSQL_PASS="${MYSQL_PASSWORD}" \
  -e MYSQL_DB="${DB_NAME}" \
  schnitzler/mysqldump > "${OUT}"