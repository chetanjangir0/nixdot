{
  description = "Chetan's NixOS configuration with Zen Browser + Home Manager";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    blueboy = {
      url = "github:chetanjangir0/blueboy";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs-stable, nixpkgs, home-manager, zen-browser
    , nix-flatpak,blueboy,  ... }@inputs:
    let system = "x86_64-linux";
    in {

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs system; };

        modules = [

          #main config file
          { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }
          ./configuration.nix

          # homehome-manager
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";

              extraSpecialArgs = { inherit inputs; };

              users.chetan = import ./home.nix;
            };
          }

          # flatpak 
          nix-flatpak.nixosModules.nix-flatpak

          # blueboy
          ({ pkgs, ... }: {
            environment.systemPackages =
              [ blueboy.packages.${pkgs.system}.default ];
          })

        ];
      };
    };
}
