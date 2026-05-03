{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../systemModules/programs/bottles.nix
  ];

  services.desktopManager.cosmic.enable = true;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-player
  ];

  environment.systemPackages = with pkgs; [
    # video
    obs-studio
    # kdePackages.kdenlive
    presenterm
    ncdu
    python3
    pyright
    black

    sioyek
  ];
}
