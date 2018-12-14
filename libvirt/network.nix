
{
  network.description = "netX";

  web1 = 
    { config, lib, pkgs, ...}:

    {
      imports = [
      ];

      environment.systemPackages = with pkgs; [
      ];

      nix.gc.automatic = true;
      nix.gc.dates = "03:15";

      networking.firewall.enable = false;

      system.activationScripts.vhosts =
        ''
          mkdir -p /var/www/vhosts
        '';

      services.httpd = {
        enable = true;
        adminAddr = "admin@zulgur.com";
      };
      
    }; 

}
