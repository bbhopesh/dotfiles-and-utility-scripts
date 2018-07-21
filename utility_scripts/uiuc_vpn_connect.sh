#!/bin/bash

# Read Password
echo -n Password: 
read -s password
echo

# Disconnect. No-op if not already connected.
/opt/cisco/anyconnect/bin/vpn disconnect 
# Connect.
/opt/cisco/anyconnect/bin/vpn -s connect vpn.cites.illinois.edu<<EOF
2
bbassi2
${password}
exit
EOF

