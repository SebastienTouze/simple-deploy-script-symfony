# simple deploy script for Symfony

Very simple deploy script to automate Symfony deployment in environments without automated deployment tools.

Usage
- Build a zip `Prod<version number>` with `prepare_zip.sh` (you can set the VERSION parameter to what you need). 
- Send the zip file 
- unzip and execute deploy.sh (yo may need to make it executable)

Deploy.sh is idempotent, in case of issue when executing it, solve the problem then execute it again, it will skip already executed steps (like database migrations).

I made this script to automate a bit Symfony deployment when working on [RapportNav](https://github.com/MTES-MCT/rapportNav) with nothing else to automate deployment. 
I open source it in case it can be useful to anyone, no guarantee that I make any evolution or improvement to it. 
