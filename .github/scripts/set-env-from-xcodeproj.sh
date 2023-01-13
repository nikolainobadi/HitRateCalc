#!/bin/bash

set -euo pipefail

#SCHEME="$(xcodebuild -list -json | jq -r '.project.schemes[0]')"
#PRODUCT_NAME="$(xcodebuild -scheme "$SCHEME" -showBuildSettings | grep " PRODUCT_NAME " | sed "s/[ ]*PRODUCT_NAME = //")"
#echo "PRODUCT_NAME=$PRODUCT_NAME" >> $GITHUB_ENV

PROJECT_NAME=$(xcodebuild -list -project MyProject.xcodeproj|grep -o 'MyProject')
SCHEME=$(xcodebuild -list -project MyProject.xcodeproj|grep -o 'MyScheme')
export PROJECT_NAME
export SCHEME
