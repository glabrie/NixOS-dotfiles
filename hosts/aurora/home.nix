# nixOS home-manager config
{ config, pkgs, ... }:

{
  home.username = "ghil";
  home.homeDirectory = "/home/ghil";
  home.stateVersion = "23.11"; # do not change please.
 
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Apps
    atuin
    bottom
    cava
    cliphist
    discord
    dmenu
    dunst
    element-desktop
    fractal
    floorp
    gh
    google-chrome
    gnome.gnome-tweaks
    grimblast
    hyprpaper
    ncspot
    ranger
    rofi-wayland
    slack
    tana
    telegram-desktop
    vscode-with-extensions
    waybar
    w3m
    wpsoffice

    # Ricing
    catppuccin
    catppuccin-gtk
    
    # Gnome Extensions
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock


 ];

  home.file = {

  };

  home.sessionVariables = {
     EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
    };
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      boot-garbage = "sudo /run/current-system/bin/switch-to-configuration boot";
      collect-garbage = "nix-collect-garbage -d";
      dots ="cd ~/.dotfiles/";
      flup = "nix flake update";
      ga = "git add *";
      gc = "git commit --verbose";
      gp = "git push";
      ll = "ls -l";
      v = "nvim";
      update = "sudo nixos-rebuild switch --flake ~/.dotfiles/#default";
    };
};

}
