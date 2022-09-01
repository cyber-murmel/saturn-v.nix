# saturn-v.nix
A convenient environment for building and flashing [saturn-v](https://github.com/greatscottgadgets/saturn-v) on NixOS

## Building
To build saturn-v, simply run `nix-build -A $package` in the root of this repository.
The available packages are listed in the set in [default.nix](default.nix).

```shell
# build default variant
nix-build -A saturn-v

# build QT Py variant
nix-build -A saturn-v-qtpy
```

## Flashing
For flashing run `nix-shell` in the root of this repository.
This enters an environment providing scripts for flashing saturn-v using [Black Magic Probe](https://github.com/blackmagic-debug/blackmagic).

```shell
# enter environment
nix-shell
# flash saturn-v
bmp-flash-saturn-v
```
