# default.nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
  st = pkgs.callPackage ./st.nix { };
  dwm = pkgs.callPackage ./dwm.nix { };
  dmenu = pkgs.callPackage ./dmenu.nix { };
}
