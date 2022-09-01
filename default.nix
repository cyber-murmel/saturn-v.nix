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
rec{
  saturn-v = callPackage ./saturn-v { inherit pkgs; };
  saturn-v-qtpy = saturn-v.overrideAttrs (oldAttrs: {
    BOARD = "qtpy";
    src = fetchFromGitHub rec {
      name = oldAttrs.name;
      owner = "greatscottgadgets";
      repo = name;
      rev = "b53c6e8b252e0a49877aa2f70fdedd5166496d2b";
      sha256 = "11ksnaqfcm4q085pv0hazw54k0diy62969qs8r1s6hws3kb18ffr";
    };
  });
}
