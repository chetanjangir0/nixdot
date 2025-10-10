{ config, pkgs, ... }:

{
  # Enable Flatpak service
  services.flatpak = {
    enable = true;

    # Declaratively install Flatpak packages
    packages = [ "eu.betterbird.Betterbird" ];

    # Configure remotes
    remotes = [{
      name = "flathub";
      location = "https://flathub.org/repo/flathub.flatpakrepo";
    }];

    # Optional: Update on activation
    update.onActivation = true;

  };

  # Add Flatpak paths to session variables( to show in launcher (rofi))
  systemd.user.sessionVariables = {
    XDG_DATA_DIRS =
      "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
  };
}
