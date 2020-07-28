#!/bin/sh
# wait-for-mssql.sh

set -e
  
host="$1"
shift
cmd="$@"

until /opt/mssql-tools/bin/sqlcmd -t 1 -U sa -P $SA_PASSWORD -Q "DB_ID('dcyf_curated_replica') IS NOT NULL"; do
  >&2 echo "dcyf_curated_replica is unavailable - sleeping"
  sleep 1
done
  
>&2 echo "dcyf_curated_replica is up - building tables"
exec $cmd