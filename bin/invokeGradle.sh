#!/usr/bin/env sh

#
# This script is intended to be used when the whole repo is used as a sub module,
# as in this case running the gradle wrapper (gradlew) from the root of the repo,
# will cause all the git related operations (mainly tagging) to be performed on the sub module itself instead on the main (containing repo).
#

# Keep current location
ORIGINAL_PATH=$PWD

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPT_PATH=$(dirname "$SCRIPT")

# Move to this script location
cd "$SCRIPT_PATH"

# Find this repo folder name
cd ..
REPO_FOLDER_NAME=${PWD##*/}
cd -

# Generate a UUID and target folder name to copy this repo to
#REPO_COPY_DESIGNATED_FOLDER_NAME=`uuidgen`
REPO_COPY_DESIGNATED_FOLDER_NAME=f5070e59-ae9e-418e-bc53-f4080205c0ae

# Copt the repo and invoke the gradle wrapper from there
cd ../..
mkdir -p $REPO_COPY_DESIGNATED_FOLDER_NAME && cp -ra $REPO_FOLDER_NAME/. $REPO_COPY_DESIGNATED_FOLDER_NAME
rm -rf  $REPO_COPY_DESIGNATED_FOLDER_NAME/.git*  $REPO_COPY_DESIGNATED_FOLDER_NAME/.gradle $REPO_COPY_DESIGNATED_FOLDER_NAME/bin
#mkdir -p $REPO_COPY_DESIGNATED_FOLDER_NAME && rsync $REPO_FOLDER_NAME $REPO_COPY_DESIGNATED_FOLDER_NAME --exclude .git/ --exclude .gradle/ --exclude bin/ --exclude .gitattributes --exclude .gitignore

# Make the working tree clean (for the Reckon plugin to work and produce significant versions)
git add $REPO_COPY_DESIGNATED_FOLDER_NAME
git commit -m "Temporary Update" $REPO_COPY_DESIGNATED_FOLDER_NAME
#git stash push $REPO_COPY_DESIGNATED_FOLDER_NAME

# Invoke Gradle (under the main repo context)
cd $REPO_COPY_DESIGNATED_FOLDER_NAME
./gradlew $*
cd -

# Restore working tree and clean the temporary folder we have just created
#git stash pop
git reset --soft HEAD~
git restore --staged $REPO_COPY_DESIGNATED_FOLDER_NAME
rm -rf $REPO_COPY_DESIGNATED_FOLDER_NAME

# Return to the original location
cd "$ORIGINAL_PATH"
