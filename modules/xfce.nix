{ pkgs, lib, ... }:

let
  catppuccinAccent  = "mauve";   # blue flamingo green lavender maroon mauve
  catppuccinVariant = "mocha";   # latte frappe macchiato mocha
  themeName         = "Catppuccin-Mocha-Standard-Mauve-Dark";

  gtkTheme = pkgs.catppuccin-gtk.override {
    accents = [ catppuccinAccent ];
    variant  = catppuccinVariant;
  };

  xfconfChannel = name: body: ''
    <?xml version="1.0" encoding="UTF-8"?>
    <channel name="${name}" version="1.0">
    ${body}
    </channel>
  '';
in
{
  config = lib.mkif (config.desktop == "xfce") {

  nixpkgs.config.pulseaudio = true;

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };
  services.displayManager.defaultSession = "xfce";

  environment.systemPackages = [
    gtkTheme
    pkgs.papirus-icon-theme
    pkgs.bibata-cursors
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    jetbrains-mono
  ];

  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE  = "24";
  };

  environment.etc = {

    "gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name                    = ${themeName}
      gtk-icon-theme-name               = Papirus-Dark
      gtk-cursor-theme-name             = Bibata-Modern-Classic
      gtk-cursor-theme-size             = 24
      gtk-font-name                     = Noto Sans 11
      gtk-application-prefer-dark-theme = 1
      gtk-button-images                 = 0
      gtk-menu-images                   = 0
    '';

    "gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name                    = ${themeName}
      gtk-icon-theme-name               = Papirus-Dark
      gtk-cursor-theme-name             = Bibata-Modern-Classic
      gtk-cursor-theme-size             = 24
      gtk-font-name                     = Noto Sans 11
      gtk-application-prefer-dark-theme = 1
    '';

    "xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml".text =
      xfconfChannel "xsettings" ''
        <property name="Net" type="empty">
          <property name="ThemeName"     type="string" value="${themeName}"/>
          <property name="IconThemeName" type="string" value="Papirus-Dark"/>
        </property>
        <property name="Gtk" type="empty">
          <property name="FontName"         type="string" value="Noto Sans 11"/>
          <property name="CursorThemeName"  type="string" value="Bibata-Modern-Classic"/>
          <property name="CursorThemeSize"  type="int"    value="24"/>
          <property name="DecorationLayout" type="string" value="close,minimize,maximize:"/>
        </property>
      '';

    "xdg/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml".text =
      xfconfChannel "xfwm4" ''
        <property name="general" type="empty">
          <property name="theme"             type="string" value="${themeName}"/>
          <property name="title_font"        type="string" value="Noto Sans Bold 11"/>
          <property name="title_alignment"   type="string" value="center"/>
          <property name="button_layout"     type="string" value="CMH|"/>
          <property name="use_compositing"   type="bool"   value="true"/>
          <property name="frame_opacity"     type="int"    value="100"/>
          <property name="inactive_opacity"  type="int"    value="95"/>
          <property name="show_frame_shadow" type="bool"   value="true"/>
          <property name="shadow_opacity"    type="int"    value="70"/>
          <property name="shadow_x_offset"   type="int"    value="2"/>
          <property name="shadow_y_offset"   type="int"    value="3"/>
          <property name="snap_to_windows"   type="bool"   value="true"/>
          <property name="wrap_windows"      type="bool"   value="false"/>
          <property name="wrap_workspaces"   type="bool"   value="false"/>
        </property>
      '';

    "xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml".text =
      xfconfChannel "xfce4-desktop" ''
        <property name="desktop-icons" type="empty">
          <property name="file-icons" type="empty">
            <property name="show-home"       type="bool" value="false"/>
            <property name="show-filesystem" type="bool" value="false"/>
            <property name="show-removable"  type="bool" value="false"/>
            <property name="show-trash"      type="bool" value="false"/>
          </property>
          <property name="icon-size" type="uint" value="48"/>
        </property>
      '';

    "xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-terminal.xml".text =
      xfconfChannel "xfce4-terminal" ''
        <property name="font-name"           type="string" value="JetBrains Mono 12"/>
        <property name="misc-cursor-blinks"  type="bool"   value="false"/>
        <property name="misc-cursor-shape"   type="string" value="TERMINAL_CURSOR_SHAPE_IBEAM"/>
        <property name="scrolling-unlimited" type="bool"   value="true"/>
        <property name="color-use-theme"     type="bool"   value="false"/>
        <property name="color-foreground"    type="string" value="#cdd6f4"/>
        <property name="color-background"    type="string" value="#1e1e2e"/>
        <property name="color-selection"     type="string" value="#585b70"/>
        <property name="color-bold"          type="string" value="#cdd6f4"/>
        <property name="color-palette"       type="string"
          value="#45475a;#f38ba8;#a6e3a1;#f9e2af;#89b4fa;#cba6f7;#89dceb;#bac2de;#585b70;#f38ba8;#a6e3a1;#f9e2af;#89b4fa;#cba6f7;#89dceb;#a6adc8"/>
      '';

    "xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-notifyd.xml".text =
      xfconfChannel "xfce4-notifyd" ''
        <property name="theme"           type="string" value="Smoke"/>
        <property name="notify-location" type="uint"   value="2"/>
        <property name="do-fadeout"      type="bool"   value="true"/>
        <property name="round-corners"   type="uint"   value="10"/>
      '';
  };
  }
}
