{
  description = "my modular nixos config";

  inputs = {
    stable.url = "github:NixOS/nixpkgs/nixos-25.05";
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

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      self,
      stable,
      nixpkgs,
      home-manager,
      zen-browser,
      nix-flatpak,
      blueboy,
      neovim-nightly,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      mkMyConfig =
        machine_name:
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs system;
          };

          modules = [
            ./configuration.nix # minimal base
            ./machines/${machine_name}

            # home-manager
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

            nix-flatpak.nixosModules.nix-flatpak

            # overlays
            {
              nixpkgs.overlays = [
                neovim-nightly.overlays.default
                (final: prev: {
                  blueboy = blueboy.packages.${system}.default;
                })
              ];
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        aeldari = mkMyConfig "aeldari";
      };
    };
}
