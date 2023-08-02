{ pkgs, ... }: {

  home.file."Library/Application Support/Firefox/Profiles/ff-nix" = {
    enable = true;
    recursive = true;
    source = pkgs.fetchgit {
      url = "https://github.com/typkrft/cascade.git";
      sha256 = "sha256-tSs165Q+VKD8t8uy/78ZQWEG14TYIpYmQ/50iGb1gbU=";
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
      decentraleyes
      alfred-launcher-integration
      foxytab
      linkding-extension
      ng-inspect
      omnisearch
      snoozetabs
      theater-mode-for-youtube
      wikiwand-wikipedia-modernized
      tabcenter-reborn
      container-tabs-sidebar
      side-view
      simple-tab-groups
      # enhancer-for-youtube
    ];

    # Look at other extensions in vivaldi
    # Setup Syncing
    # Setup Stylus
    # document important extensions settings
    # digital certificates

    # TODO: Get a list of options
    settings = {
      "app.update.auto" = false;
      "dom.events.testing.asyncClipboard" = true;
      "browser.aboutConfig.showWarning" = false;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
      "privacy.trackingprotection.socialtracking.annotate.enabled" = true;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "reader.color_scheme" = "dark";
      "browser.ctrlTab.recentlyUsedOrder" = false;

      # Pocket
      "extensions.pocket.enabled" = false;
      "browser.newtabpage.activity-stream.discoverystream.saveToPocketCard.enabled" = false;
      "browser.newtabpage.activity-stream.discoverystream.sendToPocket.enabled" = false;
      "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
      "browser.urlbar.suggest.pocket" = false;
      "extensions.pocket.showHome" = false;
      "services.sync.prefs.sync.browser.newtabpage.activity-stream.section.highlights.includePocket" = false;

      # PDF
      "browser.download.open_pdf_attachments_inline" = true; # Don't download PDFs automatically
      "pdfjs.sidebarViewOnLoad" = 2;
      "pdfjs.defaultZoomValue" = "page-width";

      # Dev
      "view_source.wrap_long_lines" = true;
      "devtools.debugger.ui.editor-wrapping" = true;
      "layout.css.has-selector.enabled" = true;
      "devtools.webconsole.input.editor" = true;

      # Networking
      "network.ssl_tokens_cache_capacity" = 32768;
      "network.http.max-connections" = 1800;
      "network.http.max-persistent-connections-per-server" = 10;
      "network.buffer.cache.count" = 128;
      "network.buffer.cache.size" = 262144;

      # Telemetry
      "browser.newtabpage.activity-stream.feeds.telemetry" = false;
      "browser.newtabpage.activity-stream.telemetry" = false;
      "browser.ping-centre.telemetry" = false;
      "datareporting.healthreport.service.enabled" = false;
      "datareporting.healthreport.uploadEnabled" = false;
      "datareporting.policy.dataSubmissionEnabled" = false;
      "datareporting.sessions.current.clean" = true;
      "devtools.onboarding.telemetry.logged" = false;
      "toolkit.telemetry.archive.enabled" = false;
      "toolkit.telemetry.bhrPing.enable" = false;
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.firstShutdownPing.enabled" = false;
      "toolkit.telemetry.hybridContent.enabled" = false;
      "toolkit.telemetry.newProfilePing.enabled" = false;
      "toolkit.telemetry.prompted" = 2;
      "toolkit.telemetry.rejected" = true;
      "toolkit.telemetry.reportingpolicy.firstRun" = false;
      "toolkit.telemetry.server" = "";
      "toolkit.telemetry.shutdownPingSender.enabled" = false;
      "toolkit.telemetry.unified" = false;
      "toolkit.telemetry.unifiedIsOptIn" = false;
      "toolkit.telemetry.updatePing.enabled" = false;

      # Smooth Scrolling
      "general.smoothScroll" = true;
      "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
      "general.smoothScroll.msdPhysics.enabled" = true;
      "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
      "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
      "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
      "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = 2.0;
      "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
      "general.smoothScroll.currentVelocityWeighting" = 1.0;
      "general.smoothScroll.stopDecelerationWeighting" = 1.0;
      "mousewheel.default.delta_multiplier_y" = 300; # 250-400


      #   "browser.startup.homepage" = "https://lobste.rs";
      #   "browser.search.region" = "GB";
      #   "browser.search.countryCode" = "GB";
      #   "browser.search.isUS" = false;
      #   "browser.newtabpage.enabled" = false;
      #   "browser.bookmarks.showMobileBookmarks" = true;
      #   "browser.uidensity" = 1;
      #   "browser.urlbar.placeholderName" = "DuckDuckGo";
      #   "browser.urlbar.update1" = true;
      #   "distribution.searchplugins.defaultLocale" = "en-GB";
      #   "general.useragent.locale" = "en-GB";
      #   "identity.fxaccounts.account.device.name" = config.networking.hostName;
      #   "services.sync.declinedEngines" = "addons,passwords,prefs";
      #   "services.sync.engine.addons" = false;
      #   "services.sync.engineStatusChanged.addons" = true;
      #   "services.sync.engine.passwords" = false;
      #   "services.sync.engine.prefs" = false;
      #   "services.sync.engineStatusChanged.prefs" = true;
      #   "signon.rememberSignons" = false;
    };

  };
}
