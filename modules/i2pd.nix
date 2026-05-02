{
  services.i2pd = {
    address = "127.0.0.1";
    proto = {
      http.enable = true;
      httpProxy.enable = true;
    };
  };
}
