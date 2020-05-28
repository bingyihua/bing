#!/usr/bin/env bash
        if [[ "$1" == "cmd" && "$2" == "" ]]; then
                cmd=`grep   "^\[" <(eval cat  $cuihome/sh/ops_note.sh)  |tr "\n"  ",";echo`
                echo ${cmd:0:-1}
        elif [[ "$1" == "cmd" && "$2" != "" ]]; then
			echo "hhaha"
			a=$1
            awk '/^\['"$a"'\]/{i=1;next}/^\[/{i=0}i' <(eval cat  $cuihome/sh/ops_note.sh)
        fi
