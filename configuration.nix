{ config, pkgs, ... }:
{
  imports = [
          <nixpkgs/nixos/modules/profiles/minimal.nix>
          <nixpkgs/nixos/modules/virtualisation/container-config.nix>
          <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
          ./build.nix
          ./networking.nix
          ./users.nix
  ];

  environment.systemPackages = with pkgs; [
    vim screen git wget
  ];

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

  time.timeZone = "Europe/Amsterdam";

  documentation.enable = true;
  services.nixosManual.enable = true;

  system.stateVersion = "18.09";
}
