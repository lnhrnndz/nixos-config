{
  description = "Leon's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    myPkgs = {
      url = "path:./myPkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, myPkgs, ... }: let
    mkHost = system: modules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = modules ++ [
          { nixpkgs.overlays = [ myPkgs.overlays.default ]; }
        ];
      };
  in {
    nixosConfigurations = {
      thethinker = mkHost "x86_64-linux" [
        ./hosts/thethinker/configuration.nix
        ./modules/common.nix
        ./modules/server.nix
      ];
      kronos = mkHost "x86_64-linux" [
        ./hosts/kronos/configuration.nix
        ./modules/common.nix
        ./modules/laptop.nix
      ];
      prometheus = mkHost "aarch64-linux" [
        ./hosts/prometheus/configuration.nix
        ./modules/common.nix
        ./modules/laptop.nix
      ];
    };
  };
}
