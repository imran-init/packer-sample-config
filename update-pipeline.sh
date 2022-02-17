#!/bin/bash
fly -t ps set-pipeline -c pipeline_packer.yml -p pipeline_packer.yml -n
fly -t ps unpause-pipeline -p pipeline_packer.yml
fly -t ps trigger-job -j pipeline_packer.yml/unit-test