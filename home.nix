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

      profiles.${username} = {
        id = 0;
        name = username;
        isDefault = true;


        containers = {
            Personal = {
              color = "purple";
              icon = "fingerprint";
              id = 1;
            };
            Work = {
              color = "blue";
              icon = "briefcase";
              id = 2;
            };
            Shopping = {
              color = "yellow";
              icon = "dollarsign";
              id = 3;
            };
        };

          # Spaces
        spacesForce = true;
        spaces = let
            containers = config.programs.zen-browser.profiles.${username}.containers;
        in {
            "Personal" = {
              id = "c6de089c-410d-4206-961d-ab11f988d40a";
              position = 1000;
              icon = "🏠";
              container = containers."Personal".id;
            };
            
            "Work" = {
              id = "cdd10fab-4fc5-494b-9041-325e5759195b";
              position = 2000;
              icon = "💼";
              container = containers."Work".id;
            };
            
            "Shopping" = {
              id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
              position = 3000;
              icon = "💸";
              container = containers."Shopping".id;
            };
        };

        # You can safely keep or trim the settings below
        settings = {
          # "signon.rememberSignons" = false;
          # "browser.cache.jsbc_compression_level" = 3;
          # "network.http.max-connections" = 1200;
          # "gfx.canvas.accelerated" = true;
          # "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      };

      # Optional example extensions
      policies = {
        PasswordManagerEnabled = false;
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

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

        ExtensionSettings = 
        with builtins;
          let
            extension = shortId: uuid: {
              name = uuid;
              value = {
                install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
                installation_mode = "normal_installed";
              };
            };
          in
          listToAttrs [
            (extension "ublock-origin" "uBlock0@raymondhill.net")
            (extension "sponsorblock" "sponsorBlocker@ajay.app")
          ];
        # To add additional extensions, find it on addons.mozilla.org, find
        # the short ID in the url (like https=//addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
        # Then, download the XPI by filling it in to the install_url template, unzip it,
        # run `jq .browser_specific_settings.gecko.id manifest.json` or
        # `jq .applications.gecko.id manifest.json` to get the UUID
      };
    };

  };
}
