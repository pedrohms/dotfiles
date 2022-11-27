#!/usr/bin/env bash

function battery_meter() {

    if [ "$(which acpi)" ]; then

        # Set the default color to the local variable fgdefault.
        local fgdefault='#[default]'

        if [ "$(cat /sys/class/power_supply/ADP0/online)" == 1 ] ; then

            local icon='🗲'
            local charging='+' 

        else

            local icon=''
            local charging='-'

        fi

        # Check for existence of a battery.
        if [ -x /sys/class/power_supply/BAT0 ] ; then

            batt0="|"$charging$(acpi -b 2> /dev/null | awk '/Battery 0/{print $4}' | cut -d, -f1)"%"$icon
            printf $batt0
        fi
    fi
}

function date_time() {

    printf "%s" "$(date +'%H:%M:%S')"

}

function ip_address() {

    # Loop through the interfaces and check for the interface that is up.
    file="/sys/class/net/enp3s0"

        iface=$(basename $file);

        read status < $file/operstate;

        [ "$status" == "up" ] && ip addr show $iface | awk '/inet /{printf $2""}'

}

function main(){
  # ip_address
  date_time
  # battery_meter
}

main
