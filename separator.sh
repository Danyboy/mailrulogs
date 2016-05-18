#!/bin/sh

outdir="./out"

separate(){
    current_id="$(grep -Eo -m1 'event_key=[0-9]+ ' | sed "s|event_key=||g")"
    grep "$current_id" >> "$outdir/${current_id}.log"
}

read_all(){
while read line
do
    separate <&$line
    #echo "$line"
done < "${1:-/dev/stdin}"
}

read_all

#separate <&0
