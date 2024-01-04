{ config, pkgs, ... }:
{

  services.samba = {
    enable = true;
    
    # You will still need to set up the user accounts to begin with:
    # $ sudo smbpasswd -a yourusername

    # This adds to the [global] section:
    extraConfig = ''
      browseable = yes
      smb encrypt = required
    '';

    shares = {
      photos  = {
	path = "/data/photos";
        browseable = "yes";  
	"valid users" = "z, rita";
        "read only" = "no";
        "guest ok" = "no";
      };
      docs  = {
	path = "/data/docs";
        browseable = "yes";  
	"valid users" = "z, rita";
        "read only" = "no";
        "guest ok" = "no";
      };
      tm  = {
	path = "/data/timemachine";
        browseable = "yes";  
	"valid users" = "z, rita";
        "read only" = "no";
        "guest ok" = "no";
	"fruit:aapl" = "yes";
        "fruit:time machine" = "yes";
        "vfs objects" = "catia fruit streams_xattr";
      };
      sync  = {
	path = "/data/sync";
        browseable = "yes";  
	"valid users" = "z";
        "read only" = "no";
        "guest ok" = "no";
      };
    };
  };
}
