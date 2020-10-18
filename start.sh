#!/bin/bash

kind create cluster --config kind.conf
# Wait for cluster
kubectl wait --for=condition=Ready pods -n kube-system --all --timeout=5m

# nginx ingress
kubectl apply -f ingress.yaml

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=2m

# Prow
kubectl apply -f prow-starter-s3.yaml

# https://prow.127.0.0.1.nip.io/