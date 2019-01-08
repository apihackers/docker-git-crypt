#!/bin/ash -e

##
## Create the GPG directory and give it the right permissions
##
mkdir -p ~/.gpg
chmod 700 ~/.gpg

if [[ ! -z "${GPG_PRIVATE_KEY}" ]]; then
    ##
    ## Import the gpg-key
    ##
    echo "$GPG_PRIVATE_KEY" > gpg --import
fi
 
git-crypt "$@"
