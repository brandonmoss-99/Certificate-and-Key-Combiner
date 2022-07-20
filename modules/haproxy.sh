#!/bin/bash

if ! command -v haproxy &> /dev/null
then
    echo "HAProxy could not be found." 
    echo -e "You will need to restart HAProxy manually\n"
else
    echo -e "Restarting HAProxy...\n"
    systemctl restart haproxy
    echo -e "done!\n"
fi
