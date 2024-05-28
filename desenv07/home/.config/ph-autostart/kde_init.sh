#$!/usr/bin/env bash
exec podman-compose -f $HOME/Projects/docker/gitea/docker-compose.yml up -d &> /dev/null
