{
  description = "Leon's NixOs configurations";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-25.05";
    myPkgs = {
      url = "path:./myPkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, myPkgs, ... }: let
    x86_64 = "x86_64-linux";
    aarch64 = "aarch64-linux";
    in {
    nixosConfigurations = {
      kronos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/common.nix
          ./modules/laptop.nix
          ./hosts/kronos/configuration.nix
          ({ pkgs, ... }: { nixpkgs.overlays = [ myPkgs.overlays.default ]; })
        ];
      };
      prometheus = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./modules/common.nix
          ./modules/laptop.nix
          ./hosts/prometheus/configuration.nix
          ({ pkgs, ... }: { nixpkgs.overlays = [ myPkgs.overlays.default ]; })
        ];
      };
    };
  };
}
