{ config, lib, ... }:
{
  config = lib.mkIf (config.formFactor == "laptop") {

    services.upower.enable = true;

    services.auto-cpufreq = {
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
  };
}
