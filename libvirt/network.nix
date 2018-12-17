
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
        extraModules = ["vhost_alias" "proxy_fcgi"];
        extraConfig = ''
           <Directory /var/www/>
              Options Indexes FollowSymLinks
              DirectoryIndex index.html index.php
              AllowOverride None
              Require all granted
           </Directory>
          '';
        virtualHosts = [
           {extraConfig = ''
             UseCanonicalName    Off
             VirtualDocumentRoot "/var/www/vhosts/%-2.0.%-1.0/%-3/public_html/"

             <FilesMatch \.php$>
                SetHandler "proxy:unix:/var/run/phpfpm/test-phpfpm.sock|fcgi://localhost/"
             </FilesMatch>
            '';
           }
        ];
      };

      services.phpfpm.poolConfigs.mypool = ''
        listen = /var/run/phpfpm/test-phpfpm.sock
         user = wwwrun
         group = wwwrun
         listen.owner = wwwrun
         listen.group = wwwrun
         pm = dynamic
         pm.max_children = 5
         pm.start_servers = 2
         pm.min_spare_servers = 1
         pm.max_spare_servers = 3
         pm.max_requests = 500
     '';
      
      services.mysql = {
        enable = true;
        package = pkgs.mariadb;
      };

    }; 

}
