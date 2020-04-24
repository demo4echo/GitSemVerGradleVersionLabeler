#!/usr/bin/env sh

#
# This script is intended to be used when the whole repo is used as a sub module,
# as in this case running the gradle wrapper (gradlew) from the root of the repo,
# will cause all the git related operations (mainly tagging) to be performed on the sub module itself instead on the main (containing repo).
#

# Absolute path to this script, e.g. /home/user/bin/foo.sh
#SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
#SCRIPT_PATH=$(dirname "$SCRIPT")

# Find the repo folder name
cd ..
REPO_FOLDER_NAME=${PWD##*/}
cd -

# Generate a UUID and target folder name to copy this repo to
REPO_COPY_DESIGNATED_FOLDER_NAME=`uuidgen`

#cd "$SCRIPT_PATH"
cd ../..
mkdir -p $REPO_COPY_DESIGNATED_FOLDER_NAME && rsync $REPO_FOLDER_NAME $REPO_COPY_DESIGNATED_FOLDER_NAME --exclude .git/ --exclude .gradle/ --exclude bin/ --exclude .gitattributes --exclude .gitignore
cd $REPO_COPY_DESIGNATED_FOLDER_NAME
./gradlew $*
cd -
rm -rf ../../$REPO_COPY_DESIGNATED_FOLDER_NAME
# cd -
