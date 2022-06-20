#! /bin/bash

# Please change this parameter
VERSION=0.1

echo "installing dependencies and building front" 
composer install
yarn install
yarn build

if [ ! -f "../vault/prod.env.local" ]
then
  echo "prod.env.local file nor found"
  exit 1
fi

if [ -f ".env.local" ]
then
  mv .env.local my_computer.env.local
fi

mv prod.env.local .env.local

zip -r Prodv${VERSION}.zip assets/ bin/ config/ public/ src/ templates/ translations/ var/ vendor/ composer.json composer.lock deployer.sh package.json .env .env.local symfony.lock webpack.config.js yarn.lock README.md LICENSE | grep "zip warning" > out.txt 2> errors.txt

echo "Errors (if any) :"
cat out.txt
cat errors.txt

rm out.txt errors.txt
mv .env.local ../vault/prod.env.local

if [ -f "my_computer.env.local" ]
then
  mv my_computer.env.local .env.local
fi
