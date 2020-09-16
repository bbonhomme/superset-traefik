#!/usr/bin/env bash

set -eo pipefail


if [ $(superset fab list-users | grep "username:" | wc -l) == "0" ]; then
echo "Creating new admin user and initializinf superset"
superset fab create-admin \
                --username ${ADMIN_USERNAME:-admin} \
                --firstname ${ADMIN_FIRST_NAME:-Admin} \
                --lastname ${ADMIN_LAST_NAME:-Superset} \
                --email ${ADMIN_EMAIL:-admin@superset.com} \
                --password ${ADMIN_PASSWORD:-admin}

superset db upgrade 

if [ "$SUPERSET_LOAD_EXAMPLES" = "yes" ]; then
    superset load_examples 
fi

superset load_examples
superset init
echo "New user created: ${ADMIN_USERNAME:-admin}"
fi
