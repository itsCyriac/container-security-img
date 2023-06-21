#!/bin/bash

curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin
curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin

echo ""
echo ""
figlet Container Security
echo ""
echo ""
echo "OPTIONS"
echo "1.Scan a docker image for Vulnerability (from Docker Hub)"
echo "2.Scan a docker image for Inventory (SBOM)"
echo "3.List out packages for a docker image"
echo "4.Scan a remote repository for vulnerabilty "
echo "5.Exit"

echo "Eneter an option (Number)"
read option

if [ $option -ne 5 ]
then
    if [ $option -eq 1 ]
    then
        echo ""
        echo ""
        echo "Enter a container name"
        echo ""
        read con_name
        echo ""
        grype $con_name
        echo ""
    elif [ $option -eq 2 ]
    then
        echo ""
        echo ""
        echo "Enter a container name"
        echo ""
        read con_name
        echo ""
        syft $con_name
        echo ""
    elif [ $option -eq 3 ]
    then
        echo ""
        echo ""
        echo "Enter a container name for listing packages"
        echo ""
        read con_name
        echo ""
        syft packages $con_name
        echo ""
    elif [ $option - eq 4 ]
    then
        echo ""
        echo ""
        echo "Enter link to repository"
        echo ""
        read link
        trivy repo $link
    else
        echo "Wrong Input"
    fi
else
    echo "Exiting"
fi

