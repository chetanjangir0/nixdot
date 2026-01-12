{
  config,
  pkgs,
  inputs,
  system,
  ...
}:
let
  stable = import inputs.stable {
    inherit system;
    config.allowUnfree = true;
  };
in

{
  imports = [
    ./systemModules/programs/flatpak.nix
    ./systemModules/services/keyd.nix
    ./systemModules/services/omz.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
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
  # services.blueman.enable = true;

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

  programs.sway.enable = true;

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
    wireplumber.enable = true; # the session manager that handles Bluetooth profile switching
  };

  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [ nerd-fonts.caskaydia-cove ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chetan = {
    isNormalUser = true;
    description = "chetan";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
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
    croc
    obsidian
    blueboy
    openssh
    lazygit

    #bluetooth
    bluez
    bluetui
    # blueman
    bluez-tools
    sbc # standard bluetooth audio codec
    # libfdk_aac codec for apple earphones

    # sway
    swaybg
    waybar
    wl-clipboard
    alacritty
    yazi
    rofi
    slurp
    grim
    tesseract
    nsxiv
    swaylock

    tealdeer
    nix-search
    tmux
    tree
    mpv
    zathura
    posting

    xdg-desktop-portal-wlr
    xdg-desktop-portal

    # languages
    nodejs
    go
    gcc # required for treesitter
    gnumake
    typst

    # neovim lsps, formatters
    lua-language-server
    typescript-language-server
    gopls
    tinymist
    tailwindcss-language-server
    marksman
    nil # for nix
    svelte-language-server

    # formatters
    stylua
    prettier
    nixfmt
    eslint

    # rust
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy # linter
  ];
  services.cloudflare-warp.enable = true;

  # programs.ssh.startAgent = false;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged
    # programs here, NOT in environment.systemPackages
  ];
}
