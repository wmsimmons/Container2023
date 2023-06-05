#!/bin/bash

AUTOMATION_DIR=$(dirname $(readlink -fm $0))

# OR
#
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Syntax: run_automation.sh [-h|-u]"
   echo "options:"
   echo "u     Set the desired location for running the test."
   echo
}

#
############################################################
############################################################
# Main program                                             #
############################################################
############################################################
# Set variables
coral_url="0"
browser="firefox"

# Get the options
while getopts ":hu:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      u) # set URL of test run
         coral_url=$OPTARG;;
      b) # set browser of test run
         browser=$OPTARG;;
      \?) # Invalid option
         echo "Error: Invalid option"
         Help
         exit;;

   esac
done

echo "Coral URL: $coral_url"
#echo "Browser for test session: $browser"

export PYTHONPATH=${PYTHONPATH}:${AUTOMATION_DIR}
#pytest -m "chrome and firefox" --html=results/coral-test-automation_report.html --url "$coral_url"
pytest tests/tests/* --html=results/coral-test-automation_report.html --disable-pytest-warnings --url "$coral_url"