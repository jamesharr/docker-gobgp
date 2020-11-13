# Project
These are some of my notes while playing around with GoBGP so I don't completely forget.

TOML still makes my head spin a bit, so the config is converted to YAML.
This is probably a mistake, but `/shrug`.

# Quick Start
```sh
# Term1
vim conf/gobgp.conf
make run

# Term 2
make shell
gobgp
```

# References
GoBGP:
* [Getting Started](https://github.com/osrg/gobgp/blob/master/docs/sources/getting-started.md)
* [FlowSpec Examples](https://github.com/osrg/gobgp/blob/master/docs/sources/flowspec.md)

Misc:
* [TOML-to-YAML converter](https://www.convertsimple.com/convert-toml-to-yaml/)
* [GoBGP Cheat Sheet](https://arthurchiao.art/blog/gobgp-cheat-sheet/)

# Random snippets
```sh
docker exec gobgp gobgp neigh -j | jq '.[]["afi-safis"][].config["afi-safi-name"]'
docker exec gobgp gobgp neigh -j | jq '.[].config'
```

```sh
gobgp -c
. gobgp-completion.bash
```

# Massive BGP instance
```sh
(set -x; for x in 10.0.{0..255}.{1,5,9,13,17,21,25,29,33,37,41,45,49,53,57,61,65,69,73,77,81,85,89,93,97,101,105,109,113,117,121,125,129,133,137,141,145,149,153,157,161,165,169,173,177,181,185,189,193,197,201,205,209,213,217,221,225,229,233,237,241,245,249,253}/30; do ip addr add $x dev eth0; done)

gobgp vrf add foo rd 1:100 rt both 1:100
gobgp vrf foo rib -a ipv4 add 1.2.3.0/24 origin igp aspath "1 2 3 4" nexthop "1.2.3.4"
gobgp vrf foo rib -a ipv6 add 2001:db8::/64 origin igp aspath "1 2 3 4" nexthop "2001:db8::1"
gobgp neigh add 10.0.0.2 as 1234 family ipv4-unicast,ipv6-unicast vrf foo

gobgp global rib -a ipv4 add 1.2.3.0/24 origin igp aspath "1 2 3 4" nexthop 1.2.3.4
gobgp global rib -a ipv4 add 1.2.3.0/24 origin igp aspath 1,2,3,4 nexthop 1.2.3.4

(set -x; for n in 10.{0..255}.{0..255}.0/24; do gobgp global rib -a ipv4 add $n origin igp aspath 1,2,3,4 nexthop 1.2.3.4& done)

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
while [ $running -ne 0 ]; then
  wait
  running=$(($running - 1))
fi
echo "done"

```
# Python GoBGP interface
* https://github.com/osrg/gobgp/blob/master/docs/sources/grpc-client.md#python
* https://github.com/osrg/gobgp/blob/master/docs/sources/grpc-client.md#python
