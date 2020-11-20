#!/bin/bash

echo ""
echo "Starting up kind cluster"

kind create cluster --config kind.conf

echo ""
echo "Wait for cluster to startup"
kubectl wait --for=condition=Ready pods -n kube-system --all --timeout=5m

echo ""
echo "Setting up nginx ingress"
kubectl apply -f ingress.yaml

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=5m

echo ""
echo "Starting up Prow"
kubectl apply -f prow-starter-s3.yaml

echo ""
echo Script complete!  Your Prow setup should be online in a few minutes.
echo ""
echo To view prow, goto this address once Deck has started: https://prow.127.0.0.1.nip.io/