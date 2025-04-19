#!/bin/bash

# Esperar a que el principal esté listo
until pg_isready -h principal -U shen; do
  sleep 2
done

# Eliminar los datos existentes y configurar como réplica
rm -rf "$PGDATA"/*
pg_basebackup -h principal -U shen -D "$PGDATA" -P -R --wal-method=fetch

# Configuraciones adicionales para el secundario
cat >> "$PGDATA/postgresql.conf" <<EOF
primary_conninfo = 'host=principal port=5432 user=shen password=1234'
promote_trigger_file = '/tmp/promote_trigger'
hot_standby = on
EOF
