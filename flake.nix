{
  description = "Chetan's NixOS configuration with Zen Browser + Home Manager";

  inputs = {
    # Nixpkgs source

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager (follows nixpkgs for compatibility)
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # Zen Browser flake
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs-stable, nixpkgs-unstable, home-manager, zen-browser
    , ... }@inputs:
    let system = "x86_64-linux";
    in {
      # 🖥️ Define your NixOS host here
      nixosConfigurations = {
        chetan = nixpkgs-stable.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs system; };

          modules = [

            { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }
            ./configuration.nix

            # 🏠 Home Manager module integration
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
          ];
        };
      };
    };
}
