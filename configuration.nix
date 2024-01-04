{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix ./zfs.nix ./smb.nix
    ];

  networking.hostName = "nusakan"; 
  networking.firewall.allowedTCPPorts = [ 445 139 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];
  #networking.firewall.enable = false;

  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

   users.users.z = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       vim
       
     ];
   };

   environment.systemPackages = with pkgs; [
     vim
     smartmontools
     git

  ];


  services.openssh.enable = true;


  boot.zfs.extraPools = [ "data" ];
  services.zfs.autoScrub.enable = true;

  system.stateVersion = "23.05"; 

}

