{ config, pkgs, ... }:

{
  home.username = "ghil";
  home.homeDirectory = "/home/ghil";
  home.stateVersion = "23.11"; # do not change please.
  
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    cliphist
    dmenu
    dunst
    element-desktop
    floorp
    gh
    google-chrome
    grimblast
    hyprpaper
    polkit_gnome
    slack
    telegram-desktop
    xfce.thunar
    waybar
    wofi
    wpsoffice
 ];

  home.file = {

  };

  home.sessionVariables = {
     EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

}
