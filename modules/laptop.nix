{ config, lib, ... }:
{
  config = lib.mkIf (config.formFactor == "laptop") {

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
