#!/bin/bash

cd
git clone https://github.com/niloysh/testbed-automator.git
git clone https://github.com/mrouili/open5gs-k8s.git

cd testbed-automator
./install.sh
cd ..

cd open5gs-k8s
./deploy-all.sh
./add-cots-subscribers.sh
cd ..

# Get the default network interface
default_interface=$(ip route | awk '/default/ {print $5; exit}')

# Check if an interface was found
if [[ -n "$default_interface" ]]; then
    echo "Default network interface: $default_interface"
    
    # Run iptables command with the default interface
    sudo iptables -t nat -A POSTROUTING -o "$default_interface" -j MASQUERADE
    
    # Check if the command was successful
    if [[ $? -eq 0 ]]; then
        echo "MASQUERADE rule added successfully."
    else
        echo "Failed to add MASQUERADE rule."
    fi
else
    echo "No default network interface found. Interface not added"
fi

echo "All done"
