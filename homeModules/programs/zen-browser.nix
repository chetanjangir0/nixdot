{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;

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
        "privacy.donottrackheader.enabled" = mkLocked true;
      };

      # ExtensionSettings = with builtins;
      #   let
      #     extension = shortId: uuid: {
      #       name = uuid;
      #       value = {
      #         install_url =
      #           "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      #         installation_mode = "normal_installed";
      #       };
      #     };
      #   in listToAttrs [
      #     (extension "ublock-origin" "uBlock0@raymondhill.net")
      #     (extension "sponsorblock" "sponsorBlocker@ajay.app")
      #   ];
      # To add additional extensions, find it on addons.mozilla.org, find
      # the short ID in the url (like https=//addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
      # Then, download the XPI by filling it in to the install_url template, unzip it,
      # run `jq .browser_specific_settings.gecko.id manifest.json` or
      # `jq .applications.gecko.id manifest.json` to get the UUID
    };
  };

}
