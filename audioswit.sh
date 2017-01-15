#!/bin/bash

# various ids
card_id=0
id_front=1
id_headphone=9
id_automute=18

# Most used values
min_volume=0
max_volume=87
enum_disabled='Disabled'
enum_enabled='Enabled'

function run_control {
    # Accepts card_id, num_id, value
    amixer -c $1 cset numid=$2 $3 >> /dev/null 2>&1
    return $?
}

function change_volume {
    # accepts card_id, num_id, volume_left, volume_right
    volume=$3,$4
    run_control $1 $2 $volume
    return $?
}

function mute_headphone {
    change_volume $card_id $id_headphone $min_volume $min_volume
    return $?
}

function restore_headphone {
    change_volume $card_id $id_headphone $max_volume $max_volume
    return $?
}

function mute_front {
    change_volume $card_id $id_front $min_volume $min_volume
    return $?
}

function restore_front {
    change_volume $card_id $id_front $max_volume $max_volume
    return $?
}

function enable_automute {
    str=$enum_enabled,$enum_enabled
    run_control $card_id $id_automute $str
    return $?
}

function disable_automute {
    str=$enum_disabled,$enum_enabled
    run_control $card_id $id_automute $str
    return $?
}

function go_to_headphone {
    restore_headphone
    # mute_front
    enable_automute
}

function go_to_front {
    # restore_front
    mute_headphone
    disable_automute
}

# master reset to 0 after a while?
possible_args="toggle front headphone"

# --- main
action="toggle"
if [ $# == 1 ] && [[ $possible_args =~ (^|[[:space:]])$1($|[[:space:]]) ]]; then
    action=$1
fi

if [ $action == "toggle" ]; then
    echo 'This action is not (yet) supported. Please use "front" or "headphone" as argument.'
elif [ $action == "front" ]; then
    go_to_front && echo "Successfully switched to front." || echo "Switch failed."
elif [ $action == "headphone" ]; then
    go_to_headphone && echo "Successfully switched to headphone." || echo "Switch failed."
fi
