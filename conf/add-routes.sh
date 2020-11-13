#!/bin/bash
running=0
max=20
for n in 10.{0..255}.{0..255}.0/24; do
  if [ $running -ge $max ]; then
    wait
    running=$(($running - 1))
  fi
  gobgp global rib -a ipv4 add $n origin igp aspath 1,2,3,4 nexthop 1.2.3.4 &
  running=$(($running + 1))
done

echo "wrapping up"
while [ $running -ne 0 ]; do
  wait
  running=$(($running - 1))
done

echo "done"
