{ pkgs, ... }: {
  fonts.fontDir.enable = true;

  fonts.fonts = with pkgs; [
    input-fonts
    ( nerdfonts.override {
        fonts = [
          "VictorMono"
          "IBMPlexMono"
          "Iosevka"
          "NerdFontsSymbolsOnly"
          "Mononoki"
          "FantasqueSansMono"
        ];
      })
  ];
}