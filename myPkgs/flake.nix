{
  description = "Leon's custom packages";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs }: let
    systems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
  in {
    packages = forAllSystems (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        st = pkgs.callPackage ./st.nix { };
        dwm = pkgs.callPackage ./dwm.nix { };
        dmenu = pkgs.callPackage ./dmenu.nix { };
      }
    );
    overlays.default = final: prev: {
      custom-st = final.callPackage ./st.nix { };
      custom-dwm = final.callPackage ./dwm.nix { };
      custom-dmenu = final.callPackage ./dmenu.nix { };
    };
  };
}
