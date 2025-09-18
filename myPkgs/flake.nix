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
      dwm = pkgs.callPackage ./dwm.nix { };
      dmenu = pkgs.callPackage ./dmenu.nix { };
      st = pkgs.callPackage ./st.nix { };
      # Add other custom packages here
    };

    # Make packages available as overlays
    overlays.default = final: prev: {
      dwm-custom = self.packages.${system}.dwm;
      dmenu-custom = self.packages.${system}.dmenu;
      st-custom = self.packages.${system}.st;
    };
  };
}
