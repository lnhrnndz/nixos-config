{
  description = "Leon's custom packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: let
    system = "aarch64-linux"; # TODO: variable architecture
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system} = {
      dmenu = pkgs.callPackage ./dmenu.nix { };
      st = pkgs.callPackage ./st.nix { };
      # Add other custom packages here
    };

    # Make packages available as overlays
    overlays.default = final: prev: {
      dmenu-custom = self.packages.${system}.dmenu;
      st-custom = self.packages.${system}.st;
    };
  };
}
