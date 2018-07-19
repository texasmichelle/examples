#!/bin/bash

# Create a Kubernetes Engine cluster using Deployment Manager
gcloud deployment-manager deployments create gke-${CLUSTER} \
  --project=${DEMO_PROJECT} \
  --config=../conf/cluster.yaml

# Setup kubectl access
gcloud container clusters get-credentials ${CLUSTER} \
  --project=${DEMO_PROJECT} \
  --zone=${ZONE}

# Install GPU device drivers
kubectl create -f https://raw.githubusercontent.com/GoogleCloudPlatform/container-engine-accelerators/k8s-1.9/nvidia-driver-installer/cos/daemonset-preloaded.yaml

