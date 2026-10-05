{ config, pkgs, ... }:

{
  home.username = "steven";
  home.homeDirectory = "/home/steven";
  programs.git = {
    enable = true;
    settings = {
      push.default = "simple";
      push.followTags = true;
      user = {
        name = "Steven Speek";
        email = "slspeek@gmail.com";
      };
    };
  };
  programs.fzf = {
    enable = true;
  };
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };
  programs.starship = {
    enable = true;
  };
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Reload the file with Prefix r.
      bind r source-file ~/.tmux.conf \; display "Reloaded!"
      setw -g monitor-activity on
      set -g visual-activity on
      set -g history-limit 100000
      set -g status-style "bg=blue"
      set -g mouse on
      set -s set-clipboard on
    '';
  };
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I run nixos, btw";
      ll = "ls -l";
      la = "ls -a";
      reb = "sudo nixos-rebuild switch --impure --flake ~/proj/nixos-config";
      nxs = "nix search nixpkgs";
    };
    initExtra = ''
      if command -v tmux &> /dev/null &&
          [ -n "$PS1" ] && [ -z "$TMUX" ] &&
          [ "$TERM_PROGRAM" != "vscode" ]; then
          exec bash -c "
          tmux attach-session -t default ||
           tmux new-session -s default"
      fi
    '';
  };

  home.stateVersion = "26.05";
}
