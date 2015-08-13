#!/bin/sh -

set -o errexit
set -o nounset
set -o pipefail

# This script provides an easy way to run commands on all nodes in your cluster. The list
# of nodes is pulled from the /hosts/allhosts.txt file in this project. You must enter your 
# FQDN of your hosts in this file or the operation will fail.
#
# source at https://github.com/jdye64/BigDataToolkit
#
# defaults can be overriden by setting variables in the environment:
#   For example:
#       export hosts_file=hosts/masternodes.txt
#       export user=jdye64
#       sh ambari-bootstrap.sh

COMMAND=$1

hosts_file="${hosts_file:-hosts/allhosts.txt}"
user="${user:-root}"

# Make sure that the nodes in the cluster have been entered
hosts_entries_present() {
    line=$(head -n 1 $hosts_file)
    if [[ $line == *"!!!"* ]]
	then
  		echo "You must enter the FQDN of your hosts in file $hosts_file";
  		exit 1
	fi
}

echo "Hosts File: $hosts_file"
echo "User $user"
hosts_entries_present

while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "Running command '$COMMAND' on server: $line"
  	ssh -n $user@$line $COMMAND
done < $hosts_file