#!/bin/bash

# Restart service, so it loads the new combined Cert/Key
runModule() {
  # If a matching module exists for the user given service name, run it,
  # otherwise output failure message
  if [ -z "${1}" ]; then
    echo -e "No service specified to reload. You'll need to do this manually.\n"
  elif [ -f modules/"${1}".sh ]; then
    . modules/"${1}".sh
  else
    echo "Couldn't find a matching module for that service."
    echo -e "You'll need to reload this service manually.\n"
  fi
}


# Get passed in args
# -c for cert file
# -k for key file
while getopts c:k:s: arg; do
    case "${arg}" in
        c)cert=${OPTARG};;
        k)key=${OPTARG};;
        s)service=${OPTARG};;
    esac
done

# What to search for in order to determine if private key exists or not
toSearch="\-----BEGIN PRIVATE KEY-----"

# Check both files exist
if [ -f "$cert" ] && [ -f "$key" ]; then

  # Check if privkey data has already been merged with cert
  # and branch on the exit status from the grep command
  case `grep "$toSearch" "$cert" >/dev/null; echo $?` in
    0)
      # Code if the private key data is found
      echo -e "Private key data already found in cert file, doing nothing\n"
      ;;
    1)
      # Code if the private key data isn't found
      echo -e "Private key data was not found, appending key to cert file\n"
      # Append key to cert file, destroy the tee output
      cat "$key" | tee -a "$cert" >/dev/null
      # Try and run a matching module for user provided service
      runModule $service
      ;;
    *)
      # Code if an error occurred
      echo -e "Error occured, doing nothing\n"
      ;;
  esac
else
  echo -e "At least 1 required file does not exist\n"
fi