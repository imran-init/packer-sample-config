#!/bin/bash

set -e

OPERATION="${OPERATION:-""}"
PATHS="${PATHS:-""}"


if ! { [[ "${OPERATION}" == "fmt" || "${OPERATION}" == "validate" || "${OPERATION}" == "" ]]; }; then
    echo "Invalid value provided for OPERATION. Valid values are 'fmt', 'validate', and ''."
    exit 1;
fi

for path in "${PATHS}"; do
    if [[ "${OPERATION}" == "fmt" || "${OPERATION}" == "" ]]; then
        echo "--> Running 'packer fmt -check -recursive repository/${path}'"
        packer fmt -check -recursive "repository/${path}" || exit $?
    fi

    if [[ "${OPERATION}" == "validate" || "${OPERATION}" == "" ]]; then
        echo "--> Running 'packer validate -syntax-only repository/${path}'"
        packer validate -syntax-only "repository/${path}" || exit $?
    fi
done
