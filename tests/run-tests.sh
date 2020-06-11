#!/bin/sh

helm install --name skydive .

export UI_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services skydive-skydive-service)
export UI_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")

max_retry=20
counter=0
until curl $UI_IP:$UI_PORT
do
   sleep 3
   [[ counter -eq $max_retry ]] && echo "Failed to reach Skydive UI" && exit 1
   echo "Trying again. Try #$counter"
   ((counter++))
done

helm delete --purge skydive