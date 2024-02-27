{ config, pkgs, ... }:

{
  home.username = "ghil";
  home.homeDirectory = "/home/ghil";
  home.stateVersion = "23.11"; # do not change please.
  
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    bottom
    catppuccin
    catppuccin-gtk
    catppuiccin-cursors
    catppuccin-papyrus-folders
    catppuccin-sddm-corners
    cliphist
    dmenu
    dunst
    element-desktop
    floorp
    gh
    google-chrome
    grimblast
    hyprpaper
    nwg-look
    polkit_gnome
    ranger
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

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      flup = "nix flake update";
      update = "sudo nixos-rebuild switch --flake ~/.dotfiles/#default";
    };
};

}
