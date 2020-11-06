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