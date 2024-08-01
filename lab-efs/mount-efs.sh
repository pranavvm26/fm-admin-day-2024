#!/bin/bash

# Check if EFS ID is provided
if [ -z "$1" ]; then
    echo "Usage: $0 fs-03958e88576aa1d98.efs.us-east-2.amazonaws.com"
    exit 1
fi

EFS_ID=$1
MOUNT_POINT="/mnt/"

# Create the mount directory
sudo mkdir -p $MOUNT_POINT

# Install NFS utils
sudo apt-get update
sudo apt-get install -y nfs-common git

# Mount the EFS
cd / && sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $EFS_ID:/ $MOUNT_POINT

# Verify if the EFS is mounted
if mountpoint -q $MOUNT_POINT; then
    echo "EFS $EFS_ID mounted successfully at $MOUNT_POINT"
else
    echo "Failed to mount EFS $EFS_ID"
    exit 1
fi

df -h


# create some dummy user directories
cd $MOUNT_POINT && sudo mkdir -p $MOUNT_POINT/home/user1 && cd $MOUNT_POINT/home/user1 && sudo git clone https://github.com/aws-samples/sagemaker-studio-admin-iac-templates.git ./user1-iac-templates
cd $MOUNT_POINT && sudo mkdir -p $MOUNT_POINT/home/user2 && cd $MOUNT_POINT/home/user2 && sudo git clone https://github.com/aws-samples/sagemaker-studio-admin-iac-templates.git ./user2-iac-templates

# Change ownership of root and above to UID: 200001 and GID: 1001
sudo chown -R 200001:1001 $MOUNT_POINT

echo "Done!"
