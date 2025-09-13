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
    system = "x86_64-linux";
    pkgs = import nixpkgs { 
      inherit system; 
      overlays = [ myPkgs.overlays.default ];
    };
    in {
    nixosConfigurations = {
      kronos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./modules/common.nix
          ./modules/laptop.nix
          ./hosts/kronos/configuration.nix
          # Make custom packages available
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ myPkgs.overlays.default ];
          })
        ];
      };
    };
  };
}
