{ config, lib, ... }:
{
  programs.qutebrowser = {
    enable = (config.desktop != "none");

    keyBindings = {
      normal = {
        "<Control-E>" = "config-cycle tabs.show always switching";
      };
    };

    settings = {
      tabs = {
        position = "left";
        show = "switching";
        show_switching_delay = 1000;
      };
      auto_save.session = true;

      window.transparent = true;
      let
        colors' = config.lib.stylix.colors.withHashtag;
        background = colors'.base00;
        secondary-background = colors'.base01;
        selection-background = colors'.base03;

        foreground = colors'.base05;
        inverted-foreground = colors'.base00;

        error = colors'.base08;

        info = colors'.base0B;
        secondary-info = colors'.base0C;

        warning = colors'.base0E;
      in {
      colors = lib.mkOverride {
            completion = {
              category = {
                bg = background;

                border = {
                  bottom = background;
                  top = background;
                };
              };

              even.bg = background;

              item.selected = {
                bg = selection-background;

                border = {
                  bottom = selection-background;
                  top = selection-background;
                };
              };
              
              odd.bg = secondary-background;

              scrollbar = {
                bg = background;
              };
            };

            contextmenu = {
              disabled = {
                bg = secondary-background;
              };

              menu = {
                bg = background;
              };

              selected = {
                bg = selection-background;
              };
            };

            downloads = {
              bar.bg = background;

            hints = {
              bg = secondary-background;
            };

            keyhint = {
              bg = background;
            };

            prompts = {
              bg = background;
              selected.bg = secondary-background;
            };

            statusbar = {
              caret = {
                bg = selection-background;

                selection = {
                  bg = selection-background;
                };
              };

              command = {
                bg = background;

                private = {
                  bg = secondary-background;
                };
              };

              insert = {
                bg = info;
              };

              normal = {
                bg = background;
              };

              passthrough = {
                bg = secondary-info;
              };

              private = {
                bg = secondary-background;
              };

              progress.bg = info;
            };

            tabs = {
              bar.bg = background;

              even = {
                bg = secondary-background;
              };

              odd = {
                bg = background;
              };

              selected = {
                even = {
                  bg = selection-background;
                };

                odd = {
                  bg = selection-background;
                };
              };
            };

            tooltip = {
              bg = background;
            };
          };
	  }
      };
    };
  };
}
