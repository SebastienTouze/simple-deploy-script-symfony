#!/bin/bash

echo "Requirements check (composer may warn about not having cache, this is a non-blocking)."
sudo -u www-data composer check --no-dev
if [ ! $? -eq 0 ]
then
  echo "Requirements are not validated."
  exit 1
fi
chown -R www-data:www-data var/log
chown -R www-data:www-data var/cache
echo "Database migration"
sudo -u www-data bin/console doctrine:migration:migrate --env=dev
if [ ! $? -eq 0 ]
then
  echo "Error on database migration."
  exit 1
fi
echo "Database migration: Done"
sudo -u www-data bin/console doctrine:schema:validate --env=dev
if [ ! $? -eq 0 ]
then
  echo "Error on database structure, missing migration file?"
  exit 1
fi

echo "\nCleaning\n"
chown -R www-data:www-data public/
sudo -u www-data bin/console cache:clear
printf "The End ! \n(Previous message should be green telling cache have been cleared with degug=false, if not: check the .env.local and clean the cache again: \nsudo -u www-data bin/console cache:clear) !\n"
