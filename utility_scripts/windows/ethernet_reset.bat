REM Sometimes Windows VM connection to internet breaks while host OS is connected. Resetting connection of VM helps. Resetting from UI is pain and this script makes life easier
netsh interface set interface name="Ethernet" admin=disabled
netsh interface set interface name="Ethernet" admin=enabled
