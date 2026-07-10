{ lib, config, ... }:
{
  config = lib.mkIf (config.programs.starship.enable) {

    stylix.targets.starship.enable = false;
    programs.starship = {
      settings = {
        add_newline = true;

        palette = "purpleblue";

        character = {
          success_symbol = "[󰁔](bold purple)";
          error_symbol = "[󰁔](bold red)";
        };

        format = lib.concatStrings [
          "[╭─](bold purple)"
          "[](fg:purple)"
          "$os"
          "[](fg:purple bg:indigo)"
          "$username"
          "[@](green bg:indigo)"
          "$hostname"
          "[](fg:indigo bg:midnight)"
          "$directory"
          "[](fg:midnight bg:purple_again)"
          "$git_branch"
          "[](fg:purple_again bg:plum)"
          "$git_metrics"
          "$git_status"
          "[](fg:plum bg:magenta)"
          "$container"
          "$nix_shell"
          "[ ](fg:magenta)"
          "$fill"
          "$sudo"
          "$memory_usage"
          "$line_break"
          "[╰](bold purple)"
          "$character"
        ];

        right_format = "$cmd_duration";

        os = {
          disabled = false;
          style = "bg:purple";
        };

        username = {
          show_always = true;
          style_user = "bold white bg:indigo";
          format = "[$user]($style)";
        };

        hostname = {
          ssh_only = false;
          style = "bold white bg:indigo";
          format = "[$ssh_symbol$hostname]($style)";
        };

        directory = {
          truncation_symbol = ".../";
          style = "bold white bg:midnight";
          read_only_style = "bold red bg:midnight";
          format = "[$path]($style)[$read_only]($read_only_style)";
        };

        git_branch = {
          style = "bold white bg:purple_again";
          format = "[$symbol$branch(:$remote_branch)]($style)";
        };

        git_metrics = {
          disabled = false;
          added_style = "bold green bg:plum";
          deleted_style = "bold red bg:plum";
          format = "([+$added]($added_style)[█](plum bg:plum))([-$deleted]($deleted_style)[█](plum bg:plum))";
        };

        git_status = {
          style = "bg:plum";
          format = "([\\[$all_status$ahead_behind\\]]($style))";
        };

        container = {
          format = "[$symbol $name ]($style)";
          style = "bold white bg:magenta";
        };

        nix_shell = {
          format = "[$symbol$state( \($name\))]($style)";
          style = "bold white bg:magenta";
        };

        fill = {
          symbol = " ";
        };

        sudo = {
          format = "[$symbol]($style)";
          style = "purple_again";
          disabled = false;
        };

        memory_usage = {
          threshold = -1;
          format = "[$symbol $ram | $swap]($style)";
          style = "purple_again";
          disabled = false;
        };

        cmd_duration = {
          format = "[ $duration]($style)";
          style = "bold purple_again";
          show_notifications = true;
        };

        palettes.purpleblue = {
          dark_gray = "#333333";
          purple = "#600080";
          indigo = "#400080";
          midnight = "#200080";
          purple_again = "#800080";
          plum = "#600070";
          magenta = "#a00080";
        };

        # symbols :
        aws.symbol = "  ";
        buf.symbol = " ";
        c.symbol = " ";
        cmake.symbol = " ";
        conda.symbol = " ";
        container.symbol = " ";
        crystal.symbol = " ";
        dart.symbol = " ";
        directory.read_only = " 󰌾";
        docker_context.symbol = " ";
        elixir.symbol = " ";
        elm.symbol = " ";
        fennel.symbol = " ";
        fossil_branch.symbol = " ";
        git_branch.symbol = " ";
        git_commit.tag_symbol = "  ";
        golang.symbol = " ";
        guix_shell.symbol = " ";
        haskell.symbol = " ";
        haxe.symbol = " ";
        hg_branch.symbol = " ";
        hostname.ssh_symbol = "";
        java.symbol = " ";
        julia.symbol = " ";
        kotlin.symbol = " ";
        lua.symbol = " ";
        memory_usage.symbol = " ";
        meson.symbol = "󰔷 ";
        nim.symbol = "󰆥 ";
        nix_shell.symbol = " ";
        nodejs.symbol = " ";
        ocaml.symbol = " ";

        os.symbols = {
          Alpaquita = " ";
          Alpine = " ";
          AlmaLinux = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Kali = " ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          RockyLinux = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Void = " ";
          Windows = "󰍲 ";
        };

        package.symbol = "󰏗 ";
        perl.symbol = " ";
        php.symbol = " ";
        pijul_channel.symbol = " ";
        python.symbol = " ";
        rlang.symbol = "󰟔 ";
        ruby.symbol = " ";
        rust.symbol = "󱘗 ";
        scala.symbol = " ";
        sudo.symbol = "󰌾 ";
        swift.symbol = " ";
        zig.symbol = " ";
        gradle.symbol = " ";

      };
    };
  };
}
