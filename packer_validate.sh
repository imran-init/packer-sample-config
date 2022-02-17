#!/bin/bash

set -e

OPERATION="${OPERATION:-""}"
PATHS="${PATHS:-""}"


if ! { [[ "${OPERATION}" == "fmt" || "${OPERATION}" == "validate" || "${OPERATION}" == "" ]]; }; then
    echo "Invalid value provided for OPERATION. Valid values are 'fmt', 'validate', and ''."
    exit 1;
fi

for dir in "${PATHS}"; do
    if [[ "${OPERATION}" == "fmt" || "${OPERATION}" == "" ]]; then
        echo "--> Running 'packer fmt -check -recursive repository/${dir}'"
        packer fmt -check -recursive "repository/${dir}" || exit $?
    fi

    if [[ "${OPERATION}" == "validate" || "${OPERATION}" == "" ]]; then
        echo "--> Running 'packer validate -syntax-only repository/${dir}'"
        packer validate -syntax-only "repository/${dir}" || exit $?
    fi
done
