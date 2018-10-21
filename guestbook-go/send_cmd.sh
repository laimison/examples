#!/bin/bash

aws ec2 describe-instances --region us-west-2 | grep -e PublicDnsName | sed -e 's/^[ \t]*//' | tr -d ',' | awk -F ' ' '{print $NF}' | cut -c 2- | rev | cut -c 2- | rev | sort -u > /tmp/instances

if [ -n "$1" ]
then
  instance_number=${1}
else
  instance_number=1
fi

if [ -n "$2" ]
then
  container_number=${2}
else
  container_number=1
fi

instance=`sed "$instance_number,$instance_number!d" /tmp/instances`

echo "ssh -i /Users/r*/Downloads/R*.pem.txt ec2-user@$instance"

if [ -n "$3" ]
then
  cmd=${3}
  ssh -i /Users/r*/Downloads/R*.pem.txt ec2-user@${instance} "
  docker ps | grep -v CONTAINER | grep -e k8s_guestbook -e k8s_redis- | awk -F ' ' '{print \$1}' > /tmp/containers
  awk \"NR == ${container_number}\" /tmp/containers > /tmp/container
  docker exec \`cat /tmp/container\` sh -c \"hostname; pwd; echo; ${cmd}\""
else
  ssh -i /Users/r*/Downloads/R*.pem.txt ec2-user@${instance} "docker ps | grep -v CONTAINER | grep -e k8s_guestbook -e k8s_redis-"
fi
