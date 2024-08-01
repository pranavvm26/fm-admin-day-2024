#!/bin/bash

aws sagemaker --region <REGION> \
update-domain --domain-id <DOMAIN-ID> \
--domain-settings-for-update '{"DockerSettings": {"EnableDockerAccess": "ENABLED"}}'
