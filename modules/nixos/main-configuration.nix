inputs: {
  flake.modules.nixos.main-configuration =
    { pkgs, ... }:
    {
      imports = [
        # Include the results of the hardware scan.
        inputs.self.modules.nixos.hardware-nucbox-k17
      ];

      console = {
        earlySetup = true;
        packages = with pkgs; [ terminus_font ];
        # "ter-v32n" is a large, highly readable font for HiDPI displays
        font = "ter-v32n";
      };

      # Use the systemd-boot EFI boot loader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      environment.sessionVariables = {
        NH_FLAKE = "/home/steven/proj/nixos-config";
      };

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      virtualisation.vmVariant = {
        virtualisation = {
          memorySize = 4096; # 4 GB RAM voor een soepele desktop
          cores = 4; # 4 CPU-cores

          # Optioneel: Schakel KVM hardware-versnelling in op de host (aanbevolen!)
          # QEMU gebruikt hierdoor de CPU-extensies van je host-systeem.
          qemu.options = [
            "-enable-kvm"
            "-cpu host"
          ];
        };
      };

      virtualisation.docker = {
        enable = true;
      };

      home-manager.backupFileExtension = "backup";
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      # Enable networking
      networking.networkmanager.enable = true;

      # Set your time zone.
      time.timeZone = "Europe/Amsterdam";

      # Select internationalisation properties.
      i18n.defaultLocale = "nl_NL.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "nl_NL.UTF-8";
        LC_IDENTIFICATION = "nl_NL.UTF-8";
        LC_MEASUREMENT = "nl_NL.UTF-8";
        LC_MONETARY = "nl_NL.UTF-8";
        LC_NAME = "nl_NL.UTF-8";
        LC_NUMERIC = "nl_NL.UTF-8";
        LC_PAPER = "nl_NL.UTF-8";
        LC_TELEPHONE = "nl_NL.UTF-8";
        LC_TIME = "nl_NL.UTF-8";
      };

      # Enable the GNOME Desktop Environment.
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;

      # TODO: Move into separate host-specific configuration file
      services.spice-vdagentd.enable = true;
      services.qemuGuest.enable = true;

      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      services.ollama.enable = true;

      # Configure console keymap
      console.keyMap = "us";

      # Enable CUPS to print documents.
      services.printing.enable = true;

      # Enable sound with pipewire.
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        # jack.enable = true;
      };

      # Enable touchpad support (enabled default in most desktopManager).
      # services.libinput.enable = true;

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users."steven" = {
        isNormalUser = true;
        description = "Steven Speek";
        extraGroups = [
          "docker"
          "networkmanager"
          "wheel"
        ];
        initialPassword = "s";
      };

      security.sudo.extraRules = [
        {
          groups = [ "wheel" ];
          commands = [
            {
              command = "ALL";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
      programs.kdeconnect = {
        enable = true;
        package = pkgs.gnomeExtensions.gsconnect;
      };
      # Install firefox.
      programs.firefox = {
        enable = true;

        # Installeer het Nederlandse taalpakket
        languagePacks = [
          "nl"
          "en-US"
        ];

        # Configureer policies om de interface en spelling naar het Nederlands te dwingen
        policies = {
          # Stelt de taal van de gebruikersomgeving in op Nederlands (met Engels als fallback)
          RequestedLocales = [
            "nl"
            "en-US"
          ];

          ExtensionSettings = {
            # ID van de officiële OpenTaal extensie "Woordenboek Nederlands" op AMO
            "nl-NL@dictionaries.addons.mozilla.org" = {
              installation_mode = "force_installed";
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/woordenboek-nederlands/latest.xpi";
            };
          };

          Preferences = {
            # Accepteer zowel Nederlands als Engels voor content en spelling
            "intl.accept_languages" = "nl,en-US,en";

            # Schakel automatische spellingcontrole in (waarde 2 betekent ingeschakeld met multi-language ondersteuning in moderne Firefox versies)
            "layout.spellcheckDefault" = 2;
          };
        };
      };

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile.
      # You can use https://search.nixos.org/ to find more packages (and options).
      environment.systemPackages = with pkgs; [
        inputs.self.packages.x86_64-linux.toggle-gnome-theme
        alacritty
        alejandra
        bat
        bc
        curl
        dconf2nix
        dysk
        fd
        file
        lshw
        inxi
        fastfetch
        lsof
        fzf
        gh
        git
        gnomeExtensions.appindicator
        gnomeExtensions.runcat
        gnome-tweaks
        html2text
        just
        lazygit
        lolcat
        lsd
        gnumake
        neovim
        nerd-fonts.jetbrains-mono
        nh
        nil
        nixd
        nixfmt
        nix-output-monitor
        nix-index
        nvd
        python3
        ripgrep
        shellcheck
        shfmt
        showmethekey
        starship
        stow
        tealdeer
        tmux
        toml2nix
        trash-cli
        vscode
        wget
        wl-clipboard
        zoxide
        zsh
      ];

      system.stateVersion = "26.05"; # Did you read the comment?
    };
}
