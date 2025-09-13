{
  description = "Leon's custom packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system} = {
      dmenu = pkgs.callPackage ./dmenu.nix { };
      # Add other custom packages here
    };

    # Make packages available as overlays
    overlays.default = final: prev: {
      dmenu-custom = self.packages.${system}.dmenu;
      st-custom = self.packages.${system}.st;
    };
  };
}
