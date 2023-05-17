#!/bin/bash

# Ensure the script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Make sure csv file exists
csv_file="install.csv"
if [ ! -f "$csv_file" ]; then
    echo "$csv_file not found!"
    exit 1
fi

# Read the CSV line by line
tail -n +2 "$csv_file" | while IFS="," read -r asset src dest config_file repo prerequisite docker_pull command reference wordlist
do
    # Print current asset
    echo "Processing $asset..."

    # Check if Docker is installed, if not install it
    if ! command -v docker &> /dev/null
    then
        echo "Docker could not be found. Installing Docker..."
        apt-get update
        apt-get install -y docker.io
        systemctl start docker
        systemctl enable docker
    fi

    # Check if Git is installed, if not install it
    if ! command -v git &> /dev/null
    then
        echo "Git could not be found. Installing Git..."
        apt-get update
        apt-get install -y git
    fi

    # If Docker pull is provided, use Docker. Else, clone the repo directly into the system.
    if [ ! -z "$docker_pull" ]; then
        echo "Pulling Docker image for $asset..."
        docker pull "$docker_pull"
    else
        echo "Cloning repo for $asset..."
        git clone "$repo" "$src"
        mv "$src" "$dest"
    fi

    # If prerequisites are provided, execute them
    if [ ! -z "$prerequisite" ]; then
        echo "Processing prerequisites for $asset..."
        eval "$prerequisite"
    fi

    echo "$asset installed successfully."

done

echo "All tools installed successfully!"
