{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "";
        padding = {
          top = 5;
          left = 2;
          right = 2;
        };
      };
      display = {
        bar = {
          char = {
            total = "─";
          };
          width = 10;
        };
        percent = {
          type = 3;
          ndigits = 2;
        };
        key = {
          width = 16;
        };
        separator = "";
      };
      modules = [
        "break"
        {
          type = "title";
          key = "  ";
          keyWidth = 4;
        }
        {
          type = "custom";
          key = "╭─System─────┬───────────────────────────────────────────────────╮";
        }
        {
          type = "host";
          key = "├╴󰌢 PC       │";
        }
        {
          type = "os";
          key = "├╴ OS       │";
        }
        {
          type = "wm";
          key = "├╴ WM       │";
        }
        {
          type = "lm";
          key = "├╴󰧨 LM       │";
        }
        {
          type = "kernel";
          key = "├╴ Kernel   │";
        }
        {
          type = "bios";
          key = "├╴ BIOS     │";
        }
        {
          type = "font";
          key = "├╴ Font     │";
        }
        {
          type = "cursor";
          key = "├╴󰆿 Cursor   │";
        }
        {
          type = "uptime";
          key = "├╴ Uptime   │";
        }
        {
          type = "command";
          key = "├╴󱦟 OS Age   │";
          text = "birth_install=$(stat -c %W /); current=$(date +%s);    days_difference=$(( (current - birth_install) / 86400 )); echo $days_difference days";
        }
        {
          type = "custom";
          key = "╰────────────┴───────────────────────────────────────────────────╯";
        }
        {
          type = "custom";
          key = "╭─Terminal───┬───────────────────────────────────────────────────╮";
        }
        {
          type = "shell";
          key = "├╴ Shell    │";
        }
        {
          type = "terminal";
          key = "├╴ Terminal │";
        }
        {
          type = "terminalfont";
          key = "├╴ Font     │";
        }
        {
          type = "terminalsize";
          key = "├╴󰘖 Size     │";
          format = "{1} colums × {2} rows ({3}px × {4}px)";
        }
        {
          type = "custom";
          key = "╰────────────┴───────────────────────────────────────────────────╯";
        }
        {
          type = "custom";
          key = "╭─Hardware───┬───────────────────────────────────────────────────╮";
        }
        {
          type = "display";
          key = "├╴󰍹 Display  │";
          format = "{1}×{2}, {3}Hz [{7}]";
        }
        {
          type = "cpu";
          key = "├╴ CPU      │";
          format = "{1} [{3} cores]";
        }
        {
          type = "gpu";
          key = "├╴󰾲 GPU      │";
        }
        {
          type = "memory";
          key = "├╴ RAM      │";
        }
        {
          type = "disk";
          key = "├╴ Disk     │";
          format = "{13} {1} / {2} ({3})";
        }
        {
          type = "battery";
          key = "├╴ Battery  │";
          format = "{10} {4} ({5})";
        }
        {
          type = "custom";
          key = "╰────────────┴───────────────────────────────────────────────────╯";
        }
        {
          type = "custom";
          key = "╭─Media──────┬───────────────────────────────────────────────────╮";
        }
        {
          type = "colors";
          key = "├╴󰏘 Palette  │";
          symbol = "diamond";
        }
        {
          type = "media";
          key = "├╴ Playing  │";
          format = "\"{1}\" - {#1}{3}{#}";
        }
        {
          type = "player";
          key = "├╴󰥠 Player   │";
        }
        {
          type = "custom";
          key = "╰────────────┴───────────────────────────────────────────────────╯";
        }
      ];
    };
  };
}
