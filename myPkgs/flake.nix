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
      st = pkgs.callPackage ./st.nix { };
      dwm = pkgs.callPackage ./dwm.nix { };
      dmenu = pkgs.callPackage ./dmenu.nix { };
      # Add other custom packages here
    };

    # Make packages available as overlays
    overlays.default = final: prev: {
      custom-st = self.packages.${system}.st;
      custom-dwm = self.packages.${system}.dwm;
      custom-dmenu = self.packages.${system}.dmenu;
    };
  };
}
