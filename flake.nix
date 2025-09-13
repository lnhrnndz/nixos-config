{
  description = "Leon's NixOs configurations";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-25.05";
    myPkgs = {
      url = "path:/home/leon/myPkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    in {
    nixosConfigurations = {
      kronos = nixpkgs.lib.nixosSystem {
        modules = [
          ./modules/common.nix
          ./modules/laptop.nix
          ./hosts/kronos/configuration.nix
        ];
      };
    };
  };
}
