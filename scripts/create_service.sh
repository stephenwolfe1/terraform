#!/bin/bash

export SERVICE=$1

if [ -d "services/${SERVICE}" ]; then
  echo -e "\033[0;31mservices/${SERVICE} already exists!\033[0m"
else
  mkdir -p services/${SERVICE}
  cp service_template/*.tf services/${SERVICE}/
  for FILE in `find service_template -name "*.tpl" -type f -execdir echo '{}' ';'`;
  do
    envsubst < "service_template/$FILE" > "services/${SERVICE}/${FILE%%.tpl}"
  done
fi
