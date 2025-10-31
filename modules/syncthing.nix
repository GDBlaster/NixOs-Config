{
  services.syncthing = {
    settings.options = {
      localAnnounceEnabled = false;
    };
  };

  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [22000];


  services.syncthing.settings.folders = {
    keepass = {
      id = "2jdu2-tpqpm";
      label = "Keepass";
      path = "/home/paul/keepass";
      versioning = {
        type = "simple";
        params.keep = 5;
      };
    };
  };
}