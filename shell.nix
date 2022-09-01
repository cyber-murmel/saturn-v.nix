{ pkgs ? import
    (builtins.fetchGit {
      name = "nixos-22.05-2022_08_27";
      url = "https://github.com/nixos/nixpkgs/";
      ref = "refs/heads/nixos-22.05";
      rev = "f11e12ac6af528c1ba12426ce83cee26f21ceafd";
    })
    { }
}:

with pkgs;
let
  default = import ./. { inherit pkgs; };

  saturn-v = default.saturn-v;
  saturn-v-qtpy = default.saturn-v-qtpy;

  bmp-flash = name: elf: writeScriptBin name ''
    #! ${bash}/bin/bash

    set -euo pipefail

    BMP_SERIAL=''${1:-/dev/ttyACM0}

    ${gcc-arm-embedded}/bin/arm-none-eabi-gdb -nx --batch \
      -ex "target extended-remote $BMP_SERIAL" \
      -ex 'monitor swdp_scan' \
      -ex 'attach 1' \
      -ex 'monitor unlock_flash' \
      -ex 'monitor unlock_bootprot' \
      -ex 'monitor erase_mass' \
      -ex 'load' \
      -ex 'compare-sections' \
      -ex 'kill' \
      ${elf}
  '';

  bmp-flash-saturn-v = bmp-flash "bmp-flash-saturn-v" "${saturn-v}/bootloader.elf";
  bmp-flash-saturn-v-qtpy = bmp-flash "bmp-flash-saturn-v-qtpy" "${saturn-v-qtpy}/bootloader.elf";
in
mkShell {
  buildInputs = [
    bmp-flash-saturn-v
    bmp-flash-saturn-v-qtpy
  ];
  SATURN_V = saturn-v;
  SATURN_V_QTPY = saturn-v-qtpy;
}
