#!/bin/bash
SQLCMD="/opt/mssql-tools18/bin/sqlcmd -C -S db -U sa -P $SA_PASSWORD"

EXISTE=$($SQLCMD -h -1 -W -Q "SET NOCOUNT ON; SELECT COUNT(*) FROM sys.databases WHERE name='el_dorado'" | tr -d '[:space:]')

if [ "$EXISTE" = "0" ]; then
  echo "Creando base el_dorado..."
  $SQLCMD -i /init/el_dorado.sql
  $SQLCMD -v APP_PASSWORD="$APP_PASSWORD" -i /init/post-init.sql
  echo "Listo."
else
  echo "La base el_dorado ya existe, no se toca."
fi
