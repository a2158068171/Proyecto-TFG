#!/bin/bash

# Configurar la replicación en el servidor principal
echo "host replication shen 0.0.0.0/0 md5" >> "$PGDATA/pg_hba.conf"

# Configuraciones adicionales para el principal
cat >> "$PGDATA/postgresql.conf" <<EOF
wal_level = replica
max_wal_senders = 10
wal_keep_size = 1GB
hot_standby = on
EOF
