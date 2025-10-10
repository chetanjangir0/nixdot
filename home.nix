{ inputs, pkgs, config, ... }:
let username = "chetan";
in {
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;

  imports = [
    ./homeModules/programs/zen-browser.nix
  ];

}
