#! /usr/bin/env bash
helm upgrade --install testkube kubeshop/testkube --values value-overrides.yaml --namespace testkube --create-namespace