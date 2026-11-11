{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../systemModules/desktop.nix
  ];

  services.desktopManager.cosmic.enable = true;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-player
  ];
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    # video
    obs-studio
    # kdePackages.kdenlive
    # presenterm
    ncdu
    python3
    pyright
    black

    sioyek
    # codex
    antigravity-hub

    # hyprpaper
    # nemo
    # kitty
    # quickshell
    # hyprshot
    # mako
    # jq
    # socat
  ];

  # programs.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  # };
  #
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
}
