{ config, pkgs, ... }:
{
  imports = [
          <nixpkgs/nixos/modules/profiles/minimal.nix>
          <nixpkgs/nixos/modules/virtualisation/container-config.nix>
          <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
          ./build.nix
          ./networking.nix
          ./users.nix
          ./virt.nix
  ];

  environment.systemPackages = with pkgs; [
    vim screen git wget nixops
  ];

  nix.useSandbox = true;

  services.resolved.enable = false;
  networking.nameservers = [ "172.18.2.10" "172.18.2.11" "208.67.222.222" "208.67.220.220" ];

  nix.gc.automatic = true;
  nix.gc.dates = "03:15";

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  #users.extraUsers.root.openssh.authorizedKeys.keys =
  #  [ "..." ];

  networking.firewall.enable = true;

  services.fail2ban.enable = true;
  services.fail2ban.jails.ssh-iptables = "enabled = true";

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  time.timeZone = "Europe/Bratislava";

  documentation.enable = true;
  services.nixosManual.enable = true;

  system.stateVersion = "18.09";
}
