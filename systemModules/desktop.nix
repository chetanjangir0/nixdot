{ config, lib, pkgs, ... }:

{
  imports = [
    ./programs/flatpak.nix
    ./services/keyd.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Display & Window Manager
  services.xserver.enable = true;
  services.displayManager.ly.enable = true;
  programs.sway.enable = true;

  # Keyboard layout
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = false;

  # Sound with Pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Fonts
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [ nerd-fonts.caskaydia-cove ];

  # Desktop & Wayland environment packages
  environment.systemPackages = with pkgs; [
    # Bluetooth tools & codecs
    bluez
    bluetui
    bluez-tools
    sbc

    # Sway / Wayland utilities
    swaybg
    waybar
    wl-clipboard
    alacritty
    rofi
    slurp
    grim
    tesseract
    nsxiv
    swaylock

    xdg-desktop-portal-wlr
    xdg-desktop-portal
  ];
}
