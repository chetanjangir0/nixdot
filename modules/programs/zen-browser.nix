{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.zen-browser.homeModules.default ];
  
  programs.zen-browser = {
    enable = true;
    
    # Browser policies
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      DisablePocket = true;
      DisableFirefoxStudies = true;
      NoDefaultBookmarks = true;
      DontCheckDefaultBrowser = true;
      
      # Privacy settings
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      
      # Preferences
      Preferences = let
        mkLocked = value: {
          Value = value;
          Status = "locked";
        };
      in {
        "browser.tabs.warnOnClose" = mkLocked false;
        # "browser.startup.homepage" = mkLocked "https://duckduckgo.com";
        "privacy.donottrackheader.enabled" = mkLocked true;
      };
      
      # Extensions
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
    
    # Profiles configuration
    # profiles."default" = {
    #   # Containers
    #   containersForce = true;
    #   containers = {
    #     Personal = {
    #       color = "purple";
    #       icon = "fingerprint";
    #       id = 1;
    #     };
    #     Work = {
    #       color = "blue";
    #       icon = "briefcase";
    #       id = 2;
    #     };
    #     Shopping = {
    #       color = "yellow";
    #       icon = "dollarsign";
    #       id = 3;
    #     };
    #   };
      
      # Spaces
      # spacesForce = true;
      # spaces = let
      #   containers = config.programs.zen-browser.profiles."default".containers;
      # in {
      #   "Personal" = {
      #     id = "c6de089c-410d-4206-961d-ab11f988d40a";
      #     position = 1000;
      #     icon = "🏠";
      #     container = containers."Personal".id;
      #   };
      #   
      #   "Work" = {
      #     id = "cdd10fab-4fc5-494b-9041-325e5759195b";
      #     position = 2000;
      #     icon = "💼";
      #     container = containers."Work".id;
      #   };
      #   
      #   "Shopping" = {
      #     id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
      #     position = 3000;
      #     icon = "💸";
      #     container = containers."Shopping".id;
      #   };
      # };
    };
  };
  
  # Set Zen as default browser
  xdg.mimeApps = let
    zen-desktop = "zen.desktop";
    associations = builtins.listToAttrs (map (name: {
      inherit name;
      value = zen-desktop;
    }) [
      "text/html"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/about"
      "x-scheme-handler/unknown"
    ]);
  in {
    enable = true;
    associations.added = associations;
    defaultApplications = associations;
  };
}
