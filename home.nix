{ config, pkgs, ...}:

{
  home.username = "steven";
  home.homeDirectory = "/home/steven";
  programs.git.enable = true;
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I run nixos, btw";
    };
  };

  home.stateVersion = "26.05";
}