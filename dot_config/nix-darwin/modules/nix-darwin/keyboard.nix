{ ... }: {
  system = {
    defaults.NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 20;
      KeyRepeat = 3;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
    keyboard = {
      enableKeyMapping = true;
      userKeyMapping = [
        {
          HIDKeyboardModifierMappingSrc = 30064771129;
          HIDKeyboardModifierMappingDst = 30064771300;
        }
      ];
    };
  };
}
