{ config, pkgs, lib, inputs, ... }: {

  services.flatpak.enable = true;

  services.flatpak.packages = [ "eu.betterbird.Betterbird" ];

  # Optional: specify remotes
  services.flatpak.remotes = [{
    name = "flathub";
    location = "https://flathub.org/repo/flathub.flatpakrepo";
  }];

  # Optional: Update on activation
  services.flatpak.update.onActivation = true;
}
