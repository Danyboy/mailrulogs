#!/bin/sh

outdir="out"

separate_ip(){
    mark=""
    ipreg="([0-9]{1,3}[\.]){3}[0-9]{1,3}"
    regexp="^${mark}${ipreg}"

    #xargs -n1 -P4 -I myline echo myline >> "$outdir/$(echo myline | grep -Eo -m1 "${regexp}").log"
    #% sh -c 'command1; command2;'

    cd $(dirname "$0")/${outdir}/
    xargs -n1 -P4 -I file sh -c 'echo "file" >> $(echo "file"| cut -c1-15 | grep -Eo -m1 "^([0-9]{1,3}[\.]){3}[0-9]{1,3}").log'
    #xargs -n1 -P4 -I file sh -c 'echo "file"; echo "file" | cut -c1-15 | grep -Eo -m1 "^([0-9]{1,3}[\.]){3}[0-9]{1,3}"'
    cd -
}

my_test(){
    outdir=${outdir}/"$(date +%H%M)"
    mkdir -p "$outdir"
    separate_ip
}

my_test

#Run example:
#cat myexample.log | ./ip_separator.sh
#cat myexample.log | time ./ip_separator.sh
