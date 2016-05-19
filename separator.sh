#!/bin/sh

outdir="out"
#mark="event_key="
#regexp="${mark}[0-9]+"

mark=""
ipreg="([0-9]{1,3}[\.]){3}[0-9]{1,3}"
regexp="^${mark}${ipreg}"

separate(){
    #echo "$@" >> "$outdir/$(echo "$@" | grep -Eo -m1 "${regexp}" | sed "s|"${mark}"||g").log"
    echo "$@" >> "$outdir/$(echo "$@" | grep -Eo -m1 "${regexp}").log"
}

read_all(){
    #export -f separate
    #xargs -n1 -P4 -I myline echo myline >> "$outdir/$(echo myline | grep -Eo -m1 "${regexp}").log"
    #% sh -c 'command1; command2;'
    cd $(dirname "$0")/${outdir}/
    xargs -n1 -P4 -I file sh -c 'echo "file" >> $(echo "file" | grep -Eo -m1 "^([0-9]{1,3}[\.]){3}[0-9]{1,3}").log'
    cd -
}

read_all_1(){
    while read line
    do
	separate "${line}"
    done < "${1:-/dev/stdin}"
}

my_test(){
    outdir=${outdir}/"$(date +%H%M)"
    mkdir -p "$outdir"
    read_all
}

my_test