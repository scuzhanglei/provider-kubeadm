#!/bin/bash

exec   > >(tee -ia /var/log/kube-apply.log)
exec  2> >(tee -ia /var/log/kube-apply.log >& 2)
exec 19>> /var/log/kube-apply.log

export BASH_XTRACEFD="19"
set -ex

until kubectl apply --kubeconfig /etc/kubernetes/admin.conf -f /var/lib/rancher/manifests  > /dev/null
do
  echo "failed to apply manifests, retring in 10s";
  sleep 10;
done;
