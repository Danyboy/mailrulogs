#!/bin/sh

outdir="out"
mark=""
ipreg="([0-9]{1,3}[\.]){3}[0-9]{1,3}"
regexp="^${mark}${ipreg}"

separate_ip(){

    #echo "$@" >> "$outdir/$(echo "$@" | grep -Eo -m1 "${regexp}").log"
    #xargs echo >> log
    #xargs -I file sh -c 'echo "file" >> "$(echo "file"| cut -c1-15 )".log'
    xargs -n1 -P4 -I file sh -c 'echo "file" >> $(echo "file"| cut -c1-15 | grep -Eo -m1 "^([0-9]{1,3}[\.]){3}[0-9]{1,3}").log'
    #xargs -n1 -P4 -I file sh -c 'echo "file"; echo "file" | cut -c1-15 | grep -Eo -m1 "([0-9]{1,3}[\.]){3}[0-9]{1,3}"'
    #xargs -n1 -P4 -I myline echo myline >> "$outdir/$(echo myline | grep -Eo -m1 "${regexp}").log"
}

separate_ips(){
    while read line ; do
        separate_ip "${line}"
    done < "${1:-/dev/stdin}"
}


my_test(){
    outdir=${outdir}/"$(date +%H%M)"
    mkdir -p "$outdir"
    cd $(dirname "$0")/${outdir}/
    separate_ip
    cd -
}

my_test

#Run example:
#cat myexample.log | ./ip_separator.sh
#cat myexample.log | time ./ip_separator.sh
