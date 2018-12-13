{
  network.description = "netX";

  web1 = 
    { config, lib, pkgs, ...}:

    {
      imports = [
      ];

      environment.systemPackages = with pkgs; [
      vim wget
      ];
      
      nix.gc.automatic = true;
      nix.gc.dates = "03:15";


      networking.firewall.enable = false;
  }; 

}
