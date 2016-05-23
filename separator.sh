#!/bin/sh

outdir="out"

separate(){
    mark="event_key="
    regexp="${mark}[0-9]+"
    echo "$@" >> "$outdir/$(echo "$@" | grep -Eo -m1 "${regexp}" | sed "s|"${mark}"||g").log"

    #echo "$@" >> "$outdir/$(echo "$@" | grep -Eo -m1 "${regexp}").log"
}

separate_events(){
    while read line ; do
	separate "${line}"
    done < "${1:-/dev/stdin}"
}

my_test(){
    outdir=${outdir}/"$(date +%H%M)"
    mkdir -p "$outdir"
    separate_events
}

my_test

#Run example:
#cat example.log | ./separator.sh