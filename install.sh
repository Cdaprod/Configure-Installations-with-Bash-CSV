#!/bin/bash

# Read the CSV file
INPUT=tools.csv
OLDIFS=$IFS
IFS=','

# Prompt function for No Config File
prompt_no_config() {
    echo "No configuration file detected for $1."
    echo "Would you like to proceed without a configuration file? [y/N]"
    read ans
    if [[ $ans =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Check if file exists
if [ ! -f $INPUT ]; then
    echo "$INPUT : File not found!"
else
    while read Asset Src Dest Config Repo Prerequisite DockerPull Command Reference Wordlist
    do
        echo "Processing $Asset..."

        # Handle prerequisites
        if [ -n "$Prerequisite" ]; then
            echo "Handling prerequisites for $Asset..."
            eval "$Prerequisite"
        fi

        # Clone from repo
        echo "Cloning $Asset from $Repo..."
        git clone $Repo $Src

        # Check config file
        if [ -z "$Config" ]; then
            prompt_no_config $Asset
            if [ $? -eq 1 ]; then
                echo "Skipping $Asset due to missing configuration file."
                continue
            fi
        else
            echo "Moving configuration file to $Config..."
            mv $Src/$Config $Dest
        fi

        # Pull docker image if specified
        if [ -n "$DockerPull" ]; then
            echo "Pulling Docker image for $Asset..."
            docker pull $DockerPull
        fi

        # Run docker command if specified
        if [ -n "$Command" ]; then
            echo "Running Docker command for $Asset..."
            eval "$Command"
        fi

        echo "$Asset installation completed."

    done < $INPUT
fi

IFS=$OLDIFS
echo "Script execution completed."
