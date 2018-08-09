# Instructions for setting up Minikube

To setup your environment for running Kubeflow on 
[Minikube](https://github.com/kubernetes/minikube),
the following steps are required:

1. [Install tools locally](#1-install-tools-locally)
1. [Set environment variables](#2-set-environment-variables)
1. [Create a Minikube cluster](#3-create-a-minikube-cluster)
1. [Create cluster objects](#4-create-cluster-objects)

## 1. Install tools locally

Ensure that you have at least the below versions of these tools (latest as of
2018-05-26). If so, skip to the [next step](#2-set-environment-variables).

* [VirtualBox](#install-virtualbox) v5.2.12
* [kubectl](#install-kubectl) v1.10.3
* [minikube](#install-minikube) v0.27.0

### Install VirtualBox

[VirtualBox](https://www.virtualbox.org/wiki/Downloads) is required for
minikube. To install, follow the instructions for your OS distro in the link.

### Install kubectl

Install the Kubernetes CLI by using one of the following methods:

#### Google Cloud SDK

```
gcloud components install kubectl
```

#### Linux

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

#### MacOS

```
brew install kubernetes-cli
```

#### Other environments

Follow the official instructions published [here](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl).

### Install Minikube

Install Minikube by using one of the following methods:

#### Linux

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
```

#### MacOS

```
brew cask install minikube
```

#### Other environments

Follow the instructions in the [Kubeflow user
guide](https://www.kubeflow.org/docs/started/getting-started-minikube/).


## 2. Set environment variables

Create a file with all the environment variables for this setup. Customize the
values inside `kubeflow.env`, then source the file:

```
source kubeflow.env
```

If you have not set `${GITHUB_TOKEN}` in your environment, follow [these
instructions](https://www.kubeflow.org/docs/guides/troubleshooting/#403-api-rate-limit-exceeded-error)
to generate a personal access token and prevent errors when installing ksonnet
packages.

## 3. Create a Minikube cluster

To start a Minikube instance:
```
minikube start --cpus 4 --memory 8096 --disk-size=40g
```

## 4. Create cluster objects

Create a namespace:
```
kubectl create namespace ${NAMESPACE}
```

Add RBAC permissions that allow your user to install kubeflow components on the
cluster:

```
kubectl create clusterrolebinding cluster-admin-binding-${USER} \
  --clusterrole cluster-admin \
  --user $(gcloud config get-value account)
```

Set your local kubectl context to connect to the right namespace:

```
../create_context.sh minikube ${NAMESPACE}
```

