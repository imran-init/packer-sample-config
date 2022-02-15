#!/bin/bash

set -e

set -o pipefail

echo "Echoing ENV Vars."
echo "FILES: ${FILES}"
echo "ACTION: ${ACTION}"

if [[ "${ACTION}" == "fmt" || "${ACTION}" == "" ]]; then
    echo "fmt was sent"
    FMT_ERROR=0
    for dir in $(echo "$FILES" | xargs -n1 dirname | sort -u | uniq); do
    echo "--> Running 'packer fmt -check -recursive' in directory 'repository/${dir}'"
    pushd "repository/${dir}" >/dev/null
    packer fmt -check -recursive . || FMT_ERROR=$?
    popd >/dev/null
    done
    exit ${FMT_ERROR}
fi

if [[ "${ACTION}" == "validate" || "${ACTION}" == "" ]]; then
    echo "validate was sent"
    VALIDATE_ERROR=0
    for dir in $(echo "$FILES" | xargs -n1 dirname | sort -u | uniq); do
    echo "--> Running 'packer validate -syntac-only' in directory 'repository/${dir}'"
    pushd "repository/${dir}" >/dev/null
    packer validate -syntax-only . || VALIDATE_ERROR=$?
    popd >/dev/null
    done
    exit ${VALIDATE_ERROR}

fi

exit 22


# EXIT_CODE=0

# 

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