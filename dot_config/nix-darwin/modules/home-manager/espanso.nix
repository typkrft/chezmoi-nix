{ pkgs, ... }: {
  home.file."/Users/brandon/Library/Preferences/espanso/match/nix.yml" = {
    enable = true;
    text = pkgs.lib.generators.toYAML {} {
      matches = [
        {
          trigger = ":date";
          replace = "{{today}}";
          vars = [
            {
              name = "today";
              type = "date";
              params.format = "%m/%d/%y";
            }
          ];
        }

        {
          trigger = ":spark l";
          repalce = "[$|$]({{link}})";
          vars = [
            {
              name = "link";
              type = "script";
              params.args = [
                "python"
                "~/Code/personal/espanso/spark_link.py"
              ];
            }
          ];
        }
      ];
    };
  }; 
}
