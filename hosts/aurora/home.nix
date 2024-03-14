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
    floorp
    gh
    google-chrome
    grimblast
    hyprpaper
    ncspot
    polkit_gnome
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
    ranger
    rofi-wayland
    slack
    telegram-desktop
    xfce.thunar
    vscode-with-extensions
    waybar
    w3m
    wpsoffice
    yakuake

    # Ricing
    bibata-cursors
    catppuccin
    catppuccin-gtk
    catppuccin-kde
    catppuccin-kvantum
    catppuccin-cursors
    catppuccin-sddm-corners
    juno-theme
    kde-rounded-corners
    papirus-icon-theme

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
