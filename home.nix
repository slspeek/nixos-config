{ config, pkgs, ...}:

{
  home.username = "steven";
  home.homeDirectory = "/home/steven";
  programs.git.enable = true;
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I run nixos, btw";
      ll = "ls -l";
      la = "ls -a";
      nxs = "nix search nixpkgs";
    };
  };

  home.stateVersion = "26.05";
}