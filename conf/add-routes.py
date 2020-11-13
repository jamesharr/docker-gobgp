#!/usr/bin/env python3
# apt update; apt install -y python3 less htop
import subprocess
import multiprocessing

def nets():
    for a in range(0,256):
        for b in range(0,256):
            yield "10.{}.{}.0/24".format(a,b)

  #gobgp global rib -a ipv4 add $n origin igp aspath 1,2,3,4 nexthop 1.2.3.4 &
def add_route(n):
    cmd="gobgp global rib -a ipv4 add {} origin igp aspath 1,2,3,4 nexthop 1.2.3.4"
    rc, output = subprocess.getstatusoutput(cmd.format(n))
    print(".", end="", flush=True)
    #print(" ".join(before + [n] + after))
    #print(output)
    #print(rc)
    return output

p = multiprocessing.Pool(4)
p.map(add_route, nets())
