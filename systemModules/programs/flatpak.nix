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

  # Add Flatpak paths to session variables( to show in launcher (rofi))

  # environment.sessionVariables = {
  #   XDG_DATA_DIRS = lib.mkAfter [
  #     "/var/lib/flatpak/exports/share"
  #     "$HOME/.local/share/flatpak/exports/share"
  #   ];
  # };
}
