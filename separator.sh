#!/bin/sh

outdir="./out"

separate(){
    echo "$@" >> "$outdir/$(echo "$@" | grep -Eo -m1 'event_key=[0-9]+' | sed "s|event_key=||g").log"
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