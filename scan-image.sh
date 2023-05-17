#!/bin/bash

figlet Container Security

echo "Enter path to the Docker image tar file:"
read -e -p "Image Path: " image_path

echo "Select a vulnerability scanning tool:"
echo "1. Trivy"
echo "2. Dive"
echo "3. Grype"
echo "4. Syft"
echo "5. Dagda"
echo "6. Anchore"
echo "7. Clair"
echo "8. Calico"
read -p "Enter option number: " option

case $option in
    1)
        trivy image -f $image_path
        ;;
    2)
        dive $image_path
        ;;
    3)
        grype $image_path
        ;;
    4)
        syft $image_path
        ;;
    5)
        dagda image -i $image_path
        ;;
    6)
        anchore-cli image add $image_path
        anchore-cli image wait $image_path
        anchore-cli image content $image_path
        ;;
    7)
        clair-scanner -c http://localhost:6060 --ip $(hostname -i) -r $image_path
        ;;
    8)
        calicoctl image load -f $image_path
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
esac
