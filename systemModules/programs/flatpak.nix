{ config, pkgs, inputs, ... }: {

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
  # systemd.user.sessionVariables = {
  #   XDG_DATA_DIRS =
  #     "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
  # };
}
