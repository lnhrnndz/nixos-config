# default.nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-25.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
  st = pkgs.callPackage ./st.nix { };
  dwm = pkgs.callPackage ./dwm.nix { };
  dmenu = pkgs.callPackage ./dmenu.nix { };
}
