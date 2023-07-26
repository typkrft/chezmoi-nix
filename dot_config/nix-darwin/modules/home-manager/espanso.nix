{ pkgs, ... }: {
  home.file."/Users/brandon/Library/Preferences/espanso/match/nix.yml" = {
    enable = true;
    text = pkgs.lib.generators.toYAML { } {
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
          replace = "[$|$]({{link}})";
          vars = [
            {
              name = "link";
              type = "script";
              params.args = [
                # TODO Requires Abosolute path
                "/Users/brandon/.asdf/shims/python"
                "/Users/brandon/code/public/espanso/spark_link.py"
              ];
            }
          ];
        }

        {
          trigger = ":yt e";
          replace = "{{embed}}";
          vars = [
            {
              name = "embed";
              type = "script";
              params.args = [
                # TODO Requires Abosolute path
                "/Users/brandon/.asdf/shims/python"
                "/Users/brandon/code/public/espanso/create_yt_embed.py"
              ];
            }
          ];
        }

        {
          trigger = ":uuid";
          replace = "{{uuid}}";
          vars = [
            {
              name = "uuid";
              type = "script";
              params.args = [
                # TODO Requires Abosolute path
                "/Users/brandon/.asdf/shims/python"
                "/Users/brandon/code/public/espanso/get_uuid.py"
              ];
            }
          ];
        }
      ];
    };
  };
}
