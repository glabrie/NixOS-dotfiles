{ config, pkgs, ... }:

{
  home.username = "ghil";
  home.homeDirectory = "/home/ghil";
  home.stateVersion = "23.11"; # do not change please.
 
  # GTK
    gtk = {
      enable = true;
      font.name = "TeX Gyre Adventor 10";
      theme = {
        name = "Juno";
        package = pkgs.juno-theme;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      cursorTheme = {
          name = "Bibata-Modern-Classic";
          package = pkgs.bibata-cursors;
        };

      gtk3.extraConfig = { 
      Settings = ''
        gtk-application-prefer-dark-theme=1
        gtk-cursor-theme-name=Bibata-Modern-Classic
      '';
      };

      gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
        gtk-cursor-theme-name=Bibata-Modern-Classic
      '';
      };

   };
  #gnome outside gnome
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
	theme = "Juno";
      };
    };
  };
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    bibata-cursors
    bottom
    catppuccin
    catppuccin-gtk
    catppuccin-cursors
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
    juno-theme
    nwg-look
    papirus-icon-theme
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
