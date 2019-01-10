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
 
if [[ ! -z "${CI_JOB_ID}" ]]; then
    git-crypt "$@"
else
    # We are in a CI pipeline
    # Just spawn a shell for compatibility
    /bin/ash
fi
