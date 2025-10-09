{ config, pkgs, ... }:

{
  # Enable Cosmic Desktop
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
  services.geoclue2.enable = true; #location allower for applications

  environment.systemPackages = with pkgs; [
    chronos # calender and clock
    cosmic-applets
    cosmic-ext-calculator # use calc from launcher
    cosmic-screenshot
  ];

}
