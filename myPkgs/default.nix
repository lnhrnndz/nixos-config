# default.nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-25.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
  dmenu = pkgs.callPackage ./dmenu.nix { };
  #st = pkgs.callPackage ./st.nix { };
}
