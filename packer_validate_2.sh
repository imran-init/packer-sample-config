#!/bin/bash

set -e

EXIT_CODE=0

[ -d "$1" ] || (EXIT_CODE=$? && echo "Directory does not exist. Exiting with error." && exit $EXIT_CODE)

echo "Checking packer config formatting..."
packer fmt -check -recursive "$1"/
IFS=$'\n' 
echo "Running syntax validtion for the provided repo."
for dir in $(find "$1" -iname "*.pkr.hcl"  ); do
    echo "$dir"
    # pwd
    # pushd "$dir" > /dev/null
    # packer validate -syntax-only .
    # popd
done