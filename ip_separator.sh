#!/bin/sh

outdir="out"

separate_ip(){
    mark=""
    ipreg="([0-9]{1,3}[\.]){3}[0-9]{1,3}"
    regexp="^${mark}${ipreg}"

    #echo "$@" >> "$outdir/$(echo "$@" | grep -Eo -m1 "${regexp}").log"
    
    cd $(dirname "$0")/${outdir}/
    xargs -n1 -P4 -I file sh -c 'echo "file" >> $(echo "file"| cut -c1-15 | grep -Eo -m1 "([0-9]{1,3}[\.]){3}[0-9]{1,3}").log'
    #xargs -n1 -P4 -I file sh -c 'echo "file"; echo "file" | cut -c1-15 | grep -Eo -m1 "([0-9]{1,3}[\.]){3}[0-9]{1,3}"'
    #xargs -n1 -P4 -I myline echo myline >> "$outdir/$(echo myline | grep -Eo -m1 "${regexp}").log"
    cd -
}

separate_ips(){
    while read line ; do
        separate_ip "${line}"
    done < "${1:-/dev/stdin}"
}


my_test(){
    outdir=${outdir}/"$(date +%H%M)"
    mkdir -p "$outdir"
    separate_ips
}

my_test

#Run example:
#cat myexample.log | ./ip_separator.sh
#cat myexample.log | time ./ip_separator.sh
