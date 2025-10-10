{ config, pkgs, inputs, system, ... }:

{
  imports =
    [ ./hardware-configuration.nix ./systemModules/programs/flatpak.nix ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
    LANG = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.displayManager.ly.enable = true;
  services.desktopManager.cosmic.enable = true;

  programs.sway.enable = true;

  # oh my zsh
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # because the declarative omz was not respecting my dotfiles
  environment.shellInit = ''
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
       git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
    fi'';

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [ nerd-fonts.caskaydia-cove ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chetan = {
    isNormalUser = true;
    description = "chetan";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs;
      [
        #  thunderbird
      ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    stow
    cloudflare-warp
    bat
    curl
    fastfetch
    ffmpeg
    fzf
    btop
    openssl
    ripgrep

    #bluetooth
    bluez
    bluetui
    blueman
    bluez-tools

    # sway
    swaybg
    waybar
    wl-clipboard
    alacritty
    yazi
    rofi
    slurp
    ghostty

    tealdeer
    tmux
    tree
    vlc
    zathura
    posting

    xdg-desktop-portal-wlr
    xdg-desktop-portal

    # languages
    nodejs
    go
    gcc # required for treesitter
    gnumake
    rustup
    typst
  ];
  services.cloudflare-warp.enable = true;

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        capslock = "overload(control,esc)";
        esc = "capslock";
      };
    };
  };

  programs.ssh.startAgent = false; # cosmic de already provides its own

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?

  # nixos and Mason conflict fix
  ### 1. Enable nix-ld globally
  programs.nix-ld.enable = true;
  ### 2. Specify the essential libraries to expose to non-Nix binaries
  ### This provides the necessary C runtime environment for almost all dynamically linked programs.
  programs.nix-ld.libraries = with pkgs; [
    glibc
    zlib
    openssl
    # Add other common libraries if you find LSPs failing for different reasons
  ];

}
