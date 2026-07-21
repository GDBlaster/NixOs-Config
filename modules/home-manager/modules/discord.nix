{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.discord = {
    enable = lib.mkEnableOption "Enable discord";
  };

  config = lib.mkIf ((config.desktop != "none") && (config.discord.enable == true)) {
    home.packages = with pkgs; [
      jellyfin-rpc
    ];
    programs.vesktop = {
      enable = true;
      settings = {
        enabledThemes = [
          "stylix.css"
        ];
        autoUpdate = true;
        autoUpdateNotification = true;
        useQuickCss = true;
        themeLinks = [

        ];
        eagerPatches = false;
        enableReactDevtools = false;
        frameless = true;
        transparent = false;
        winCtrlQ = false;
        windowsMaterial = "none";
        disableMinSize = false;
        winNativeTitleBar = false;
        plugins = {
          CommandsAPI = {
            enabled = true;
          };
          MemberListDecoratorsAPI = {
            enabled = true;
          };
          MessageAccessoriesAPI = {
            enabled = true;
          };
          MessageDecorationsAPI = {
            enabled = true;
          };
          MessageEventsAPI = {
            enabled = true;
          };
          AnonymiseFileNames = {
            enabled = true;
            anonymiseByDefault = true;
            method = 2;
            randomisedLength = 7;
            consistent = "image";
          };
          ClearURLs = {
            enabled = true;
          };
          CopyUserURLs = {
            enabled = true;
          };
          CrashHandler = {
            enabled = true;
          };
          FakeNitro = {
            enabled = true;
          };
          FavoriteEmojiFirst = {
            enabled = true;
          };
          FixSpotifyEmbeds = {
            enabled = true;
          };
          FixYoutubeEmbeds = {
            enabled = true;
          };
          ForceOwnerCrown = {
            enabled = true;
          };
          GreetStickerPicker = {
            enabled = true;
          };
          ImplicitRelationships = {
            enabled = true;
          };
          MessageLogger = {
            enabled = true;
          };
          NoF1 = {
            enabled = true;
          };
          NoMiddleClickPaste = {
            enabled = true;
          };
          NoUnblockToJump = {
            enabled = true;
          };
          NotificationVolume = {
            enabled = true;
          };
          OnePingPerDM = {
            enabled = true;
            channelToAffect = "both_dms";
            allowMentions = true;
            allowEveryone = false;
          };

          PermissionFreeWill = {
            enabled = true;
          };
          petpet = {
            enabled = true;
          };
          PinDMs = {
            enabled = true;
          };
          PlatformIndicators = {
            enabled = true;
          };
          RevealAllSpoilers = {
            enabled = true;
          };
          ShikiCodeblocks = {
            enabled = true;
          };
          SpotifyCrack = {
            enabled = true;
          };
          TypingIndicator = {
            enabled = true;
            includeCurrentChannel = true;
            includeMutedChannels = false;
            includeBlockedUsers = false;
            indicatorMode = 3;
          };
          UserMessagesPronouns = {
            enabled = true;
          };
          VoiceChatDoubleClick = {
            enabled = true;
          };
          VoiceMessages = {
            enabled = true;
          };
          WebKeybinds = {
            enabled = true;
          };
          WebScreenShareFixes = {
            enabled = true;
          };
          YoutubeAdblock = {
            enabled = true;
          };
          BadgeAPI = {
            enabled = true;
          };
          NoTrack = {
            enabled = true;
            disableAnalytics = true;
          };
          Settings = {
            enabled = true;
            settingsLocation = "aboveNitro";
            includeVencordInfoWhenCopying = true;
          };
          ConcatenatedComponentExtractor = {
            enabled = true;
          };
          DisableDeepLinks = {
            enabled = true;
          };
          SupportHelper = {
            enabled = true;
          };
          WebContextMenus = {
            enabled = true;
          };
        };
        uiElements = {
          chatBarButtons = {
          };
          messagePopoverButtons = {
          };
        };
        notifications = {
          timeout = 5000;
          position = "bottom-right";
          useNative = "not-focused";
          logLimit = 50;
        };
      };

    };
    services.arrpc.enable = true;

    xdg.desktopEntries.vesktop = {
      name = "Discord";
      genericName = "Internet Messenger";
      comment = "Chat on Discord";
      icon = "discord";
      exec = "vesktop %U";
      categories = [
        "Network"
        "InstantMessaging"
        "Chat"
      ];
      type = "Application";
      mimeType = [ "x-scheme-handler/discord" ];
      terminal = false;
    };
  };
}
