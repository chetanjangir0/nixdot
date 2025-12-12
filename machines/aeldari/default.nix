{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../../systemModules/services/docker.nix
    ./hardware-configuration.nix
  ];

  services.desktopManager.cosmic.enable = true;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-player
  ];

  environment.systemPackages = with pkgs; [
    # video
    obs-studio
    kdePackages.kdenlive
  ];
}
