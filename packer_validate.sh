#!/bin/bash

set -e

set -o pipefail

echo "Echoing ENV Vars."
echo "FILES: ${FILES}"
echo "ACTION: ${ACTION}"
echo "ARR: ${ARR[@]}"

for a in "${ARR[@]}"; do
    echo "${a}";
done

case $ACTION in 
    fmt)
        echo "fmt was sent"

        ;;
    validate)
        echo "validate was sent"
        ;;
    *)
        echo "Invalid value for ACTION. Exiting ...";
        exit 22;
        ;;
esac

# EXIT_CODE=0

# [ -d "$1" ] || (EXIT_CODE=$? && echo "Directory does not exist. Exiting with error." && exit "${EXIT_CODE}")

# echo "Checking packer config formatting..."
# packer fmt -check -recursive "$1"



# echo "Running syntax validtion for the provided repo."
# IFS=$'\n' 
# # for dir in $(find "$1" -iname "*.pkr.hcl"  | xargs -d '\n' dirname | sort | uniq); do
# for dir in $(find "$1" -iname "*.pkr.hcl"  -exec dirname {} \; | sort | uniq); do
#     echo "Running packer validate -syntax-only in ${dir}"
#     pwd
#     pushd "${dir}" > /dev/null
#     packer validate -syntax-only .
#     popd
# done