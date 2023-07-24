{ pkgs, ... }: {

  # Additional Extensions
home.file."Library/Application Support/Firefox/Profiles/ff-nix/extensions/snoozetabs-1.1.1.xpi" = {
  enable = true;
  source = pkgs.fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/1209734/snoozetabs-1.1.1.xpi";
    sha256 = "sha256-sSc6uDCa8ISxd/cdPnlN4yrCtmPnDXbBImDRgFuc1io=";
  };
};

  # TODO: Fork karamanliev/cascade add Tab Center Reborn Setup here https://github.com/andreasgrafen/cascade#how-to-set-it-up-1
  home.file."Library/Application Support/Firefox/Profiles/ff-nix/chrome/userChrome.css" = {
    enable = true;
    recursive = true;
    source = pkgs.fetchgit {
      url = "https://github.com/karamanliev/cascade.git";
      sparseCheckout = [ 
        "chrome/userChrome.css"
      ];
      sha256 = "sha256-HcP9ubL6Omu8GbeFq3namDR6EMKpXm8uMD57/J5/9C0=";
    };
  };
  home.file."Library/Application Support/Firefox/Profiles/ff-nix" = {
    enable = true;
    recursive = true;
    source = pkgs.fetchgit {
      url = "https://github.com/karamanliev/cascade.git";
      sparseCheckout = [ 
        "chrome/includes"
      ];
      sha256 = "sha256-znnpv+6IoEl9eEFmY5ilUvmEd4nx+DxBL/mSoOyUaLk=";
    };
  };

  programs.firefox.enable = true;
  # NOTE: Use a dummy package, Firefox is managed by homebrew
  programs.firefox.package = pkgs.runCommand "firefox-0.0.0" { } "mkdir $out";
  programs.firefox.profiles."ff-nix-test" = {
    name = "ff-nix-test";
    isDefault = false;
    path = "ff-nix-test";
    id = 1;
  };

  programs.firefox.profiles."ff-nix" = {
    name = "ff-nix";
    isDefault = true;
    id = 0;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      dracula-dark-colorscheme
      multi-account-containers
      facebook-container
      tampermonkey
      sponsorblock
      ublock-origin
      bitwarden
      new-tab-override
      stylus
      enhancer-for-youtube
      decentraleyes

      # TODO Follow up on https://gitlab.com/rycee/nur-expressions/-/issues/139
      # theatermode
      # Wikiwand
      # Alfred Integration
      # omni
      # Snooze Tab
      # FoxyTab
      # Linkding
      # ng-inspect
    ];


    settings = {
      "app.update.auto" = false;
      #   "browser.startup.homepage" = "https://lobste.rs";
      #   "browser.search.region" = "GB";
      #   "browser.search.countryCode" = "GB";
      #   "browser.search.isUS" = false;
      #   "browser.ctrlTab.recentlyUsedOrder" = false;
      #   "browser.newtabpage.enabled" = false;
      #   "browser.bookmarks.showMobileBookmarks" = true;
      #   "browser.uidensity" = 1;
      #   "browser.urlbar.placeholderName" = "DuckDuckGo";
      #   "browser.urlbar.update1" = true;
      #   "distribution.searchplugins.defaultLocale" = "en-GB";
      #   "general.useragent.locale" = "en-GB";
      #   "identity.fxaccounts.account.device.name" = config.networking.hostName;
      #   "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
      "privacy.trackingprotection.socialtracking.annotate.enabled" = true;
      #   "reader.color_scheme" = "auto";
      #   "services.sync.declinedEngines" = "addons,passwords,prefs";
      #   "services.sync.engine.addons" = false;
      #   "services.sync.engineStatusChanged.addons" = true;
      #   "services.sync.engine.passwords" = false;
      #   "services.sync.engine.prefs" = false;
      #   "services.sync.engineStatusChanged.prefs" = true;
      #   "signon.rememberSignons" = false;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };

  };
}
