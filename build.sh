#!/bin/bash -e

# --------------------------------------------------------------------------
# Test everything is available
# --------------------------------------------------------------------------
if ! [ -x "$(command -v composer)" ]; then
    echo 'ERROR: composer is not installed.' >&2
    exit 1
elif ! [ -x "$(command -v npm)" ]; then
    echo 'ERROR: npm is not installed.' >&2
    exit 1
fi


# --------------------------------------------------------------------------
# Make sure all dependencies are pulled down
# --------------------------------------------------------------------------
composer --no-interaction --optimize-autoloader --no-dev install
npm install


# --------------------------------------------------------------------------
# Ensure that the following directories have permissions set properly
# --------------------------------------------------------------------------
chmod -R 0755 vendor
chmod g+w cache/public cache/private application/logs
chmod +x ./vendor/nailsapp/module-console/console.php


# --------------------------------------------------------------------------
# If config files exist then simply migrate the database, if not, go
# through the installer
# --------------------------------------------------------------------------
if [ -f "config/app.php" ] && [ -f "config/deploy.php" ]; then
    php ./vendor/nailsapp/module-console/console.php migrate --no-interaction
else
    php ./vendor/nailsapp/module-console/console.php install
fi


# --------------------------------------------------------------------------
# Execute the Gulp build command so that all JS and CSS is compiled
# --------------------------------------------------------------------------
rm -rf assets/build/css assets/build/js
npm run production
