#!/bin/sh

outdir="./out"
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