{
  lib,
  osConfig,
  config,
  ...
}:
{
  config = lib.mkMerge [
    (lib.mkIf (config.hmIsModule) {
      desktop = osConfig.desktop;
      ui = osConfig.ui;
    })
  ];
}

