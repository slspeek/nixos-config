{
  config,
  pkgs,
  ...
}: {
  imports = [./gnome-shortcuts.nix];
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
  xdg.configFile."nvim".source = /home/steven/proj/nixos-config/config/nvim;

  programs.fzf = {
    enable = true;
  };
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
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
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide # or bbenoist.nix for the classic extension
      ];
      userSettings = {
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "options" = {
              "home-manager" = {
                "expr" = "(builtins.getFlake (builtins.toString ./. )).nixosConfigurations.\"nixos-steven\".options.home-manager.users.type.getSubOptions []";
              };
            };
          };
        };
        "git.autofetch" = true;
        "git.confirmSync" = false;
      };
    };
  };
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I run nixos, btw";
      vc = "cd ~/proj/nixos-config/ && nvim configuration.nix";
      vh = "cd ~/proj/nixos-config/ && nvim home.nix";
      ls = "lsd";
      tree = "lsd --tree";
      ll = "ls -l";
      la = "ls -a";
      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      nrs = "sudo nixos-rebuild switch --impure --flake ~/proj/nixos-config";
      nxs = "nix search nixpkgs";
    };
    initExtra = ''
      use() {
        mkdir "$1" && cd "$1"
      }

      if command -v tmux &> /dev/null &&
          [ -n "$PS1" ] && [ -z "$TMUX" ] &&
          [ "$TERM_PROGRAM" != "vscode" ]; then
          exec bash -c "
          tmux attach-session -t default ||
           tmux new-session -s default"
      fi
    '';
  };
  programs.alacritty = {
    enable = true;
    settings = {
      "font" = {
        "bold" = {
          "family" = "JetBrainsMono Nerd Font";
          "style" = "Bold";
        };
        "bold_italic" = {
          "family" = "JetBrainsMono Nerd Font";
          "style" = "Bold Italic";
        };
        "italic" = {
          "family" = "JetBrainsMono Nerd Font";
          "style" = "Italic";
        };
        "normal" = {
          "family" = "JetBrainsMono Nerd Font";
          "style" = "Regular";
        };
        "size" = 17.0;
      };
      "window" = {
        "decorations" = "Full";
        "decorations_theme_variant" = "Dark";
        "opacity" = 0.95;
        "padding" = {
          "x" = 10;
          "y" = 10;
        };
      };
    };
  };
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "Alacritty.desktop"
      ];
    };
  };
  home.stateVersion = "26.05";
}
