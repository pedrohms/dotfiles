#!/usr/bin/env bash
COMPOSE_COMMAND=docker-compose
PODMAN_COMPOSE=$(type -p "podman-compose")

if [[ -n $PODMAN_COMPOSE ]]; then
  COMPOSE_COMMAND=podman-compose
fi

function composeSqlServer {

  if [[ -z $YML_SQLSERVER ]]; then
    YML_SQLSERVER="$HOME/Projects/docker/mssql/docker-compose.yml"
  fi

  if [ -n $YML_SQLSERVER ]; then
    if [ -f $YML_SQLSERVER ] ; then
      exec $COMPOSE_COMMAND -f $YML_SQLSERVER up -d &> /dev/null
    fi
  fi
}

function initializeContainers {
  composeSqlServer
}

# initializeContainers
