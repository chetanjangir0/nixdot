{
  inputs,
  pkgs,
  config,
  ...
}:
let
  username = "chetan"; # 
in
{
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05"; 
  };

  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs = {
    home-manager.enable = true;

    # 🦊 Zen Browser setup
    zen-browser = {
      enable = true;
      # profiles.${username} = {
      #   id = 0;
      #   name = username;
      #   isDefault = true;
      #
      #   # You can safely keep or trim the settings below
      #   settings = {
      #     "signon.rememberSignons" = false;
      #     "browser.cache.jsbc_compression_level" = 3;
      #     "network.http.max-connections" = 1200;
      #     "gfx.canvas.accelerated" = true;
      #     "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      #   };
      # };
      #
      # # Optional example extensions
      # policies = {
      #   PasswordManagerEnabled = false;
      #   ExtensionSettings = {
      #     "uBlock0@raymondhill.net".value = {
      #       install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/ublock-origin/latest.xpi";
      #       installation_mode = "normal_installed";
      #     };
      #   };
      # };
    };

  };
}
