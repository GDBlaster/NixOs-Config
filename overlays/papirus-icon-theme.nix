self: super: {
  papirus-icon-theme = super.papirus-icon-theme.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      echo "Running postInstall to symlink vesktop.svg to discord.svg..."

      for theme in Papirus Papirus-Dark; do
        for size in 16 24 32 48 64 128 256; do
          icon_dir="$out/share/icons/$theme/''${size}x''${size}/apps"
          discord_icon="$icon_dir/discord.svg"
          vesktop_icon="$icon_dir/vesktop.svg"

          if [ -f "$discord_icon" ]; then
            echo "Linking $vesktop_icon -> $discord_icon"
            ln -sf "discord.svg" "$vesktop_icon"
          else
            echo "Skipping size ''${size} for $theme, no discord.svg found."
          fi
        done
      done
    '';
  });
}