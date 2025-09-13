{ config, lib, pkgs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
      ./hostSpecific
      # ../../bugs/vix #TODO: create default.nix to import all users and pass it in hosts/default.nix? and when needed 
    ];
    

   networking.hostName = "Daffodil"; # Define your hostname.


   steam.enable = false;
   vix.enable = true;



   environment.variables = {
       EDITOR = "nvim";
       VISUAL = "nvim";
   };


  system.stateVersion = "24.11"; 

}

