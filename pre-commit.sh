#!/bin/bash

if [ "$#" -gt 1 ]; then
    echo -e "Too many arguments provided. Use --help for more information."
    exit 84
fi

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo -e "Usage: \n  ./pre-commit.sh\n"
    echo -e "Description:\n  This script runs pre-commit hooks for a project in a Docker container."
    echo -e "  It requires the .pre-commit-config.yaml file to be in the project's root."
    echo -e "  Hooks are executed in a container, eliminating the need for local pre-commit installation."
    echo -e "  After execution, output is formatted for better readability and displayed."
    exit 0
fi

if [ ! -f .pre-commit-config.yaml ]; then
    echo "Error: The file .pre-commit-config.yaml was not found in the current directory."
    exit 84
fi

if [ "$#" -eq 1 ]; then
    if [ "$1" == "docker" ]; then
        # Run pre-commit hooks inside container and save the output to a log file
        pre-commit run --all-files > .pre-commit-keeper.log
        RUN_STATUS=$?
        if [ $RUN_STATUS -ne 0 ]; then
            echo -e "\033[0;31mPre-commit run failed, you should try again or correct the errors manually.\033[0m" >> .pre-commit-keeper.log
        else
            echo -e "\n\033[0;32mPre-commit run was successful, you can push the changes.\033[0m" >> .pre-commit-keeper.log
        fi

        # Formatting output
        cat .pre-commit-keeper.log | grep -v INFO > .pre-commit-output.log
        sed -i -e 's/Skipped/'$'\033[0;34m''&'$'\033[0m''/g' .pre-commit-output.log
        sed -i -e 's/Passed/'$'\033[0;32m''&'$'\033[0m''/g' .pre-commit-output.log
        sed -i -e 's/Failed/'$'\033[0;31m''&'$'\033[0m''/g' .pre-commit-output.log

        # Clean up temporary files / things from pre-commit
        rm -f .pre-commit-keeper.log
        pre-commit clean > /dev/null
        pre-commit gc > /dev/null
    else
        echo -e "Invalid argument provided. Use --help for more information."
        exit 84
    fi
else
    # Run pre-commit hooks using Docker container and display the output
    echo -e "[INFO] - Running Docker container..."
    docker run --rm --name pre-commit --volume "$(pwd)":/code itszcx/pre-commit:1.2.1
    echo -e "[INFO] - Docker container removed...\n"
    cat .pre-commit-output.log
    rm -f .pre-commit-output.log
fi
