inputs@{
  nixpkgs,
  plasma-manager,
  nixgl,
  nur,
  utils,
  neovim,
  slippi,
  ...
}:
this:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  hm-path = this.homeDirectory + "/.config/home-manager";
  ssbm-config-path = this.homeDirectory + "/.config/ssbm";
  ow-path = hm-path + "/overwriteables";
  get-ow-path = rest: ow-path + "/" + rest;
  dz-nix-path = hm-path + "/dz.nix";
  dz-neovim-path = dz-nix-path + "/neovim";
  dz-hm-path = dz-nix-path + "/home-manager";
  get-zkm-path = rest: dz-hm-path + "/zkm/" + rest + ".clj";
  get-domain-path = rest: dz-hm-path + "/domain/" + rest;
  mkOverwriteableSymlink = rel: (config.lib.file.mkOutOfStoreSymlink (get-ow-path rel));
  mkDomainSymlink = rel: (config.lib.file.mkOutOfStoreSymlink (get-domain-path rel));
  getEnvExtra = (
    {
      env ? { },
      ...
    }:
    env
  );
  envExtra = getEnvExtra this;
  system = pkgs.stdenv.hostPlatform.system;
  unfreePkgs = (
    import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    }
  );
  nurRepos =
    (import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [ nur.overlays.default ];
    }).nur.repos;
  zn = inputs.zn-nix.mk-zn system;
  fontPkgs = [
    pkgs.font-awesome
    pkgs.monaspace
    pkgs.liberation_ttf
    pkgs.nerd-fonts.monaspace
    pkgs.nerd-fonts.ubuntu-mono
    pkgs.nerd-fonts.comic-shanns-mono
    pkgs.nerd-fonts.shure-tech-mono
    pkgs.nerd-fonts.recursive-mono
    pkgs.nerd-fonts.proggy-clean-tt
    pkgs.nerd-fonts.profont
    pkgs.nerd-fonts.open-dyslexic
    pkgs.nerd-fonts.monofur
    pkgs.nerd-fonts.lilex
    pkgs.nerd-fonts.hurmit
    pkgs.nerd-fonts.gohufont
    pkgs.nerd-fonts.fantasque-sans-mono
    pkgs.nerd-fonts.daddy-time-mono
    pkgs.nerd-fonts.bigblue-terminal
    pkgs.nerd-fonts.agave
    pkgs.nerd-fonts._3270
    pkgs.ubuntu-classic
  ];
  zkmPkg = (config.lib.nixGL.wrap inputs.zkm.packages.${system}.zkm);
  mkZkm =
    n: f:
    zn.writeBashScriptBin' n [ zkmPkg f ] ''
      ${zkmPkg}/bin/zkm ${f}
    '';
  luajit = (
    pkgs.luajit.withPackages (
      luaPackages: with luaPackages; [
        busted
        fennel
      ]
    )
  );
in
{
  imports = [
    plasma-manager.homeModules.plasma-manager
    # slippi.homeManagerModules.default
    # { slippi-launcher.isoPath = "/home/dz/ssbm/iso/ssbm.1_02.iso"; }
  ];
  /*
  targets.genericLinux.gpu.enable = true;
  targets.genericLinux.gpu.nvidia = {
    enable = true;
    version = "595.71.05";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAa=";
  };
  */
  targets.genericLinux.nixGL = { packages = nixgl.packages; defaultWrapper = this.defaultNixGLWrapper; };
  home.username = this.username;
  home.homeDirectory = this.homeDirectory;
  home.stateVersion = this.stateVersion;
  home.packages =
    with pkgs;
    fontPkgs
    ++ [
      audacity
      babashka
      bat
      blueman
      brightnessctl
      bundler
      cava
      cloc
      dbeaver-bin
      deno
      direnv
      unfreePkgs.dropbox
      emacs
      eslint
      fastfetch
      fd
      fennel-ls
      gh
      github-desktop
      git
      google-cloud-sdk
      grc
      htop
      imagemagick
      jekyll
      jq
      just
      kdePackages.qttools
      # kurve
      libnotify
      lua-language-server
      lxqt.pavucontrol-qt
      mpc
      # ncmpcpp
      networkmanagerapplet
      nix-prefetch-github
      nixd
      nixfmt
      nodejs_26
      pandoc
      pnpm
      prettier
      python3
      ripgrep
      rlwrap
      rofi
      rust-analyzer
      silver-searcher-ng
      sxhkd
      tree
      typescript-language-server
      ueberzugpp
      unzip
      vlc
      vscodium
      vtsls
      watchexec
      # wrangler
      xdelta
      (yarn.override { nodejs = pkgs.nodejs_26; })
      # yarn2nix
      yj
      (pkgs.callPackage ./dz-hm/default.nix { })
      (pkgs.callPackage ./dz-dev/default.nix { })
      (pkgs.callPackage ./dz-theme/default.nix { })
      (pkgs.callPackage ./dz-ytmdl/default.nix { })
      (pkgs.callPackage ./slp-id/default.nix { })
      (pkgs.callPackage ./dz-status/default.nix { })
      (config.lib.nixGL.wrap inputs.zkg.packages.${system}.zkg)
      (config.lib.nixGL.wrap inputs.ztr.packages.${system}.ztr)
      (config.lib.nixGL.wrap inputs.slippi.packages.${system}.slippi-netplay)
      (config.lib.nixGL.wrap inputs.slippi.packages.${system}.slippi-playback)
      inputs.slp-rec.packages.${system}.slp-rec
      inputs.yt-upload-playwright.packages.${system}.yt-upload-playwright
      zkmPkg
      (mkZkm "home.zkm" (get-zkm-path "home"))
      luajit
      (config.lib.nixGL.wrap pkgs.kitty)
      # (config.lib.nixGL.wrap pkgs.vesktop)
      # (config.lib.nixGL.wrap pkgs.pear-desktop)
      (config.lib.nixGL.wrap pkgs.neovide)
      (utils.mkFnlFmt luajit)
      (utils.mkNixWork pkgs)
      (zn.writeBashScriptBin "lvim" ''
        export DZ_NVIM_CONFIG_USE_LOCAL=no
        nvim "$@"
      '')
      (zn.writeBashScriptBin "gvim" ''
        nohup neovide "$@" >/dev/null 2>&1 &
      '')
      (zn.writeBashScriptBin "lgvim" ''
        export DZ_NVIM_CONFIG_USE_LOCAL=no
        gvim "$@"
      '')
      (zn.writeBashScriptBin "slippi-launcher" ''
        bash -c $(find ${ssbm-config-path} -type f -regex '${ssbm-config-path}/Slippi-Launcher.*\.AppImage')
      '')
      (zn.writeBashScriptBin "kwinSh" ''
        qdbus org.kde.kglobalaccel \
          /component/kwin \
          org.kde.kglobalaccel.Component.invokeShortcut \
          "$@"
      '')
      (zn.writeBashScriptBin "jj" ''
        just "$@"
      '')
      (zn.writeBashScriptBin "rofi-dmenu" ''
        rofi -matching fuzzy -sorting-method fzf -sort -dmenu "$@"
      '')
      (zn.writeBashScriptBin "ssh-adhdz" ''
        gcloud compute ssh \
          --zone "us-central1-c" \
          --project "adhdz-414420" \
          --command "bash -c fish" \
          mitch@instance-20250718-181706 \
          -- -t
      '')
      (zn.writeBashScriptBin "kittyRootWindow" ''
        TEMP_DIR=$(mktemp -d --)
        trap 'rm -rf "$TEMP_DIR"' EXIT
        up="$TEMP_DIR/k"
        export DZ_KITTY_UNIX_PATH="$up"
        /usr/bin/kitty -o allow_remote_control=yes --listen-on "unix:$up" "$@"
      '')
      (zn.writeBashScriptBin "kittenSelf" ''
        function doTheThing() {
          sleep 1.01
          kitten @ --to "unix:$DZ_KITTY_UNIX_PATH" "$@"
        }
        doTheThing "$@" & disown
      '')
      (let
          polybar_cava = pkgs.writeShellApplication {
            name = "polybar_cava";
            runtimeInputs = [ pkgs.coreutils pkgs.cava pkgs.gnused ];
            text = builtins.readFile ./domain/polybar/cava.sh;
          };
          extraPkgs = [
            pkgs.coreutils
            pkgs.systemd
            pkgs.which
            /* pkgs.bspwm */
            pkgs.nodejs
            /* pkgs.pamixer */
            pkgs.pulseaudio
            polybar_cava
          (pkgs.polybar.override {
            alsaSupport = true;
            iwSupport = true;
            githubSupport = true;
            pulseSupport = true;
            mpdSupport = true;
          })
          ];
          extraBinPath = lib.makeBinPath extraPkgs;
        in
        zn.writeBashScriptBin' "_polybar-launch" extraPkgs ''
          export PATH=${extraBinPath}:$PATH
            for m in $(polybar --list-monitors | cut -d":" -f1); do
              MONITOR=$m polybar -c ${./domain/polybar/config.ini} --reload example &
            done
        '')
      (zn.writeBashScriptBin "polybar-launch" ''
        nohup _polybar-launch "$@" >/dev/null 2>&1 &
      '')
    ];
  home.file = {
    ".local/share/color-schemes" = {
      source = mkDomainSymlink "./plasma/color-schemes";
      recursive = true;
    };
    ".local/share/plasma/desktoptheme" = {
      source = mkDomainSymlink "./plasma/plasma-style";
      recursive = true;
    };
    ".local/share/plasma/plasmoids" = {
      source = mkDomainSymlink "./plasma/plasmoids";
      recursive = true;
    };
    ".face.icon" = {
      source = mkDomainSymlink "./static/face.icon";
      recursive = false;
    };
  };
  home.sessionVariables = envExtra // {
    DZ_NIX_CHECKOUT_PATH = dz-nix-path;
    DZ_NVIM_CONFIG_CHECKOUT_PATH = dz-neovim-path;
    DZ_HOME_MANAGER_CHECKOUT_PATH = dz-hm-path;
    WINIT_X11_SCALE_FACTOR = "1";
    BROWSER = "firefox";
  };
  home.pointerCursor = {
    enable = true;
    # gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    hyprcursor = {
      enable = true;
      size = 24;
    };
  };

  # gtk.enable = true;
  # gtk.theme.package = pkgs.rose-pine-gtk-theme;
  # gtk.theme.name = "rose-pine";
  # gtk.iconTheme.package = pkgs.dracula-icon-theme;
  # gtk.iconTheme.name = "Dracula";

  xdg.configFile = {
    "kglobalshortcutsrc" = {
      source = mkOverwriteableSymlink "kglobalshortcutsrc";
      recursive = true;
    };
    /*
    "autostart/org.kde.polybar.start.desktop" = {
      source = mkDomainSymlink "./autostart/org.kde.polybar.start.desktop";
      recursive = true;
    };
    */
    "autostart/org.kde.sxhkd.start.desktop" = {
      source = mkDomainSymlink "./autostart/org.kde.sxhkd.start.desktop";
      recursive = true;
    };
    "plasmashellrc" = {
      source = mkDomainSymlink "./plasma/plasmashellrc";
      recursive = true;
    };
    "plasma-org.kde.plasma.desktop-appletsrc" = {
      source = mkDomainSymlink "./plasma/plasma-org.kde.plasma.desktop-appletsrc";
      recursive = true;
    };
    "kitty/kitty.conf" = {
      source = mkDomainSymlink "./kitty/kitty.conf";
      recursive = true;
    };
    "dz-theme/kitty" = {
      source = mkDomainSymlink "./dz-theme/kitty";
      recursive = true;
    };
    "dz-theme/themes.toml" = {
      source = mkDomainSymlink "./dz-theme/themes.toml";
      recursive = true;
    };
    "slp-rec" = {
      source = mkDomainSymlink "./slp-rec";
      recursive = true;
    };
    "sxhkd" = {
      source = mkDomainSymlink "./sxhkd";
      recursive = true;
    };
    "klassy" = {
      source = mkDomainSymlink "./klassy";
      recursive = true;
    };
    "fastfetch" = {
      source = mkDomainSymlink "./fastfetch";
      recursive = true;
    };
    "SlippiPlayback/GameSettings/GALE01.ini" = {
      source = mkOverwriteableSymlink "SlippiPlaybackGecko.ini";
      recursive = true;
    };
    "neovide/config.toml".text = ''
      [font]
      normal = ["monospace"]
      size = 11.0
    '';
  };
  systemd.user.services.pusdb = {
    Unit = {
      Description = "pusdb backend";
      WantedBy = [ ];
    };
    Service = {
      ExecStart = "${
        zn.writeBashScriptBin' "pusdb.launch" [ pkgs.fish ] ''
          export PATH=${pkgs.fish}/bin:$PATH
          cd /home/dz/Projects/pusdb
          nix develop --command fish -c "just backend"
        ''
      }/bin/pusdb.launch";
      Restart = "always";
    };
  };
  systemd.user.services.h2h-gen = {
    Unit = {
      Description = "h2h-gen runner";
      WantedBy = [ ];
    };
    Service = {
      ExecStart = "${
        zn.writeBashScriptBin' "h2h-gen.launch" [ pkgs.fish ] ''
          export PATH=${pkgs.fish}/bin:$PATH
          export AUTH_URL=https://h2h.public-universal-domain.org
          export AUTH_TRUST_HOST=true

          cd /home/dz/Projects/workspace.dz-ts

          nix develop --command fish -c "just run-h2h-app"
        ''
      }/bin/h2h-gen.launch";
      Restart = "always";
    };
  };
  systemd.user.services.slippi-clm = {
    Unit = {
      Description = "slippi-clm updater";
      WantedBy = [ ];
    };
    Service = {
      ExecStart = "${
        zn.writeBashScriptBin' "slippi-clm.launch" [ pkgs.fish ] ''
          export PATH=${pkgs.fish}/bin:$PATH
          cd /home/dz/Projects/slippi-clm.github.io
          ${pkgs.fish}/bin/fish -c "./UPDATE_LOOPER.sh"
        ''
      }/bin/slippi-clm.launch";
      Restart = "always";
    };
  };
  systemd.user.services.sxhkd = {
    Unit = {
      Description = "sxhkd runner";
      WantedBy = [ ];
    };
    Service = {
      KillMode = "process";
      ExecStart = "${
        zn.writeBashScriptBin' "sxhkd.launch" [ pkgs.sxhkd ] ''
          export PATH=${pkgs.sxhkd}/bin:$PATH
          sxhkd
        ''
      }/bin/sxhkd.launch";
      Restart = "always";
    };
  };
  systemd.user.services.waybar-supervisor = {
    Unit = {
      Description = "waybar supervisor";
      WantedBy = [ ];
    };
    Service = {
      ExecStart = "${
        zn.writeBashScriptBin' "waybar-supervisor.launch" [ pkgs.fish ] ''
          ${pkgs.fish}/bin/fish -c waybar
        ''
      }/bin/waybar-supervisor.launch";
      Restart = "always";
    };
  };

  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts.serif = [ "Liberation Serif" ];
  fonts.fontconfig.defaultFonts.sansSerif = [ "Ubuntu" ];
  fonts.fontconfig.defaultFonts.monospace = [
    "RecMonoCasual Nerd Font Mono"
    # "Lilex Nerd Font Mono"
    ### "Hurmit Nerd Font Mono"
    # "FantasqueSansM Nerd Font Mono"
    # "ComicShannsMono Nerd Font Mono"
    # "Monaspace Krypton Frozen SemiBold"
    # "Monaspace Argon Frozen SemiBold"
    # "Monaspace Argon Frozen ExtraBold"
    # "Monaspace Krypton Frozen ExtraBold"
    # "Monaspace Xenon Frozen ExtraBold"
    # "Monaspace Radon Frozen ExtraBold"
    # "MonaspiceKr Nerd Font Mono"
    # "MonaspiceXe Nerd Font Mono"
    # "MonaspiceNe Nerd Font Mono"
    # "MonaspiceRn Nerd Font Mono"
    # "MonaspiceAr Nerd Font Mono"
  ];

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    package = config.lib.nixGL.wrap pkgs.firefox;
    policies = {
      Preferences = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = {
          Value = true;
          Status = "locked";
        };
        "layout.css.devPixelsPerPx" = {
          Value = "1.0";
          Status = "locked";
        };
      };
    };
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "browser.tabs.inTitlebar" = 0;
          "full-screen-api.ignore-widgets" = true;
          "full-screen-api.exit-on.windowRaise" = false;
          "extensions.activeThemeId" = with nurRepos.rycee; firefox-addons.dracula-dark-colorscheme.addonId;
        };
        userChrome = builtins.readFile ./domain/firefox/userChrome.css;
        extensions.packages = with nurRepos.rycee.firefox-addons; [
          dracula-dark-colorscheme
          ublock-origin
          # video-downloadhelper
        ];
      };
    };
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    escapeTime = 0;
    terminal = "tmux-256color";
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      /*
        {
          plugin = rose-pine;
          extraConfig = "set -g @rose_pine_variant 'main'";
        }
        {
          plugin = tmux-colors-solarized;
          extraConfig = "set -g @colors-solarized 'light'";
        }
      */
      {
        plugin = ukiyo;
        extraConfig = ''
          run-shell 'tmux set -g @ukiyo-theme "$(echo dz-theme -:t | fish)"'
          set -g @ukiyo-show-battery "false"
          set -g @ukiyo-show-powerline true
          set -g @ukiyo-network-bandwidth-show-interface "false"
          set -g @ukiyo-show-location "false"
          set -g @ukiyo-show-fahrenheit true
          set -g @ukiyo-ignore-window-colors true
          set -g default-command "${pkgs.fish}/bin/fish -C 'source ./.session.fish &> /dev/null; or :'"
        '';
      }
    ];

    extraConfig = ''
      set -g allow-passthrough on
      set -g default-shell ${pkgs.fish}/bin/fish
      setenv -g DZ_FISH_SKIP_FASTFETCH "yes"
    '';
  };
  programs.fish = import ./domain/fish/hm.nix {
    lib = lib;
    pkgs = pkgs;
  };
  programs.neovim = (
    let
      nvimConfigPkg = (neovim.mkPkg pkgs);
      shCore = pkgs.writeText "shCore" (neovim.mkShellHook pkgs);
      shPost = pkgs.writeText "shPost" ''
        # if [[ "$DZ_NVIM_CONFIG_USE_LOCAL" != "no" ]]; then
        export DZ_NVIM_CONFIG_USE_LOCAL=yes
        # fi
        export DZ_NVIM_CONFIG_MACRO_PATH="$FENNEL_MACRO_PATH"
        export DZ_NVIM_CONFIG_FENNEL_PATH="$DZ_NVIM_CONFIG_CHECKOUT_PATH/src/?.fnl"
        export DZ_NVIM_CONFIG_LUA_PATH_EXTRA="$LUA_PATH_EXTRA;$DZ_NVIM_CONFIG_CHECKOUT_PATH/src/?.fnl"
        cd "$vimRunDir"
      '';
    in
    {
      package = pkgs.neovim-unwrapped.overrideAttrs (oldAttrs: {
        postInstall = ''
          mv $out/bin/nvim $out/bin/nvim-true-bin
          echo 'vimRunDir="$(pwd)"'                                  > $out/bin/nvim
          cat ${pkgs.writeText "hk" (neovim.mkShellHook pkgs)}      >> $out/bin/nvim
          cat ${shPost}                                             >> $out/bin/nvim
          echo $out/bin/nvim-true-bin '"$@"'                        >> $out/bin/nvim
          chmod +x $out/bin/nvim
        '';
      });
      initLua = "require(\"nvim-config\").doTheThings()";
      plugins =
        (
          let
            fromGitHub =
              repo: ref: rev:
              pkgs.vimUtils.buildVimPlugin {
                pname = "${lib.strings.sanitizeDerivationName repo}";
                version = ref;
                buildInputs = [
                  pkgs.vimPlugins.plenary-nvim
                  pkgs.git
                ];
                src = builtins.fetchGit {
                  url = "https://github.com/${repo}.git";
                  ref = ref;
                  rev = rev;
                };
              };
          in
          with pkgs.vimPlugins;
          [
            aurora
            aylin-vim
            catppuccin-nvim
            dracula-nvim
            kanagawa-nvim
            melange-nvim
            rose-pine
            neomodern-nvim
            bluloco-nvim
            modus-themes-nvim
            onedarkpro-nvim
            oxocarbon-nvim
            edge
            (fromGitHub "tiagovla/tokyodark.nvim" "HEAD" "14bc1b3e596878a10647af7c82de7736300f3322")
            (fromGitHub "bluz71/vim-moonfly-colors" "HEAD" "63f20d657c9fd46ecdd75bd45c321f74ef9b11fe")
            (fromGitHub "dgox16/oldworld.nvim" "HEAD" "1b8e1b2052b5591386187206a9afbe9e7fdbb35f")
            (fromGitHub "fynnfluegge/monet.nvim" "HEAD" "af6c8fb9faaae2fa7aa16dd83b1b425c2b372891")
            (fromGitHub "maxmx03/fluoromachine.nvim" "HEAD" "d638ea221b4c6636978f49c1987d10ff2733c23d")

            cmp-nvim-lsp
            cmp-buffer
            cmp-conjure
            cmp-path
            cmp-cmdline
            cmp-vsnip
            nvim-cmp
            vim-vsnip
            vim-vsnip-integ
            purescript-vim

            nvim-treesitter.withAllGrammars
            snacks-nvim
            nvim-paredit
            conform-nvim
            indent-blankline-nvim
            nvim-ts-autotag
            unfreePkgs.vimPlugins.nvim-vtsls

            gitsigns-nvim
            nvim-navic
            rainbow-delimiters-nvim
            venn-nvim
            lualine-lsp-progress
            lualine-nvim
            nvim-autopairs
            orgmode
            vim-hy

            (fromGitHub "mcauley-penney/tidy.nvim" "HEAD" "f6c9cfc9ac5a92bb5ba3c354bc2c09a7ffa966f2")
            (fromGitHub "shellRaining/hlchunk.nvim" "HEAD" "5465dd33ade8676d63f6e8493252283060cd72ca")
          ]
        )
        ++ [ (pkgs.neovimUtils.buildNeovimPlugin { luaAttr = nvimConfigPkg; }) ];
    }
    // (builtins.listToAttrs (
      map
        (n: {
          name = n;
          value = true;
        })
        [
          "enable"
          "defaultEditor"
          "viAlias"
          "vimAlias"
          "vimdiffAlias"
          "withNodeJs"
          "withPython3"
          "withRuby"
        ]
    ))
  );
  # programs.plasma = (import ./domain/kdeplasma/config.nix).programs.plasma;
  programs.rofi = {
    enable = true;
    theme = ./domain/rofi/theme.rasi;
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    tmux.enableShellIntegration = true;
  };
  programs.waybar = {
        enable = true;
        style = builtins.readFile ./domain/hypr/waybar.style.css;
        settings = {
          mainBar = {
            layer = "top";
            position = "bottom";
            height = 32;
            width = null;
            margin = "0 0 0 0";
            spacing = 2;
            fixed-center = true;
            modules-left = ["hyprland/workspaces"];
            modules-center = ["cava" "mpd"];
            modules-right = ["backlight" "battery" "network" "pulseaudio" "tray" "clock"];
            "hyprland/workspaces" = {
              format = " {icon} {windows} ";
              window-rewrite-default = "󰘔";
              window-rewrite = {
                "firefox" = "";
                ".slippi-netplay-wrapped" = "";
                "com.obsproject.Studio" = "";
                "code-url-handler" = "󰨞";
                "Gimp-2.10" = "";
                "kitty" = "";
                "wezterm" = "";
                "discord" = "󰙯";
                "thunar" = "";
                "neovide" = "";
                "glrnvim" = "";
                "vlc" = "󰕼";
              };
              all-outputs = true;
              sort-by-number = true;
              format-icons = {
                "1" = "1";
                "2" = "2";
                "3" = "3";
                "4" = "4";
                "5" = "5";
                "6" = "6";
                "7" = "7";
                "8" = "8";
                "9" = "9";
                "10" = "10";
                "focused" = "";
                "default" = "";
              };
              persistent-workspaces = {
                "*" = [1];
                "HDMI-A-1" = [2];
              };
              on-scroll-up = "hyprctl dispatch workspace e+1";
              on-scroll-down = "hyprctl dispatch workspace e-1";
            };
            "tray" = {
              icon-spacing = 20;
              spacing = 5;
            };
            "clock" = {
              tooltip-format = ''
                <big>{:%A, %d.%B %Y }</big>
                <tt><small>{calendar}</small></tt>
              '';
              format = "{:%a %m/%d %I:%M:%S %p}";
              interval = 1;
            };
            "backlight" = {
              format = "{icon} {percent: >3}%";
              format-icons = [""];
              on-scroll-down = "brightnessctl -c backlight set 1%-";
              on-scroll-up = "brightnessctl -c backlight set +1%";
            };
            "battery" = {
              format = "{icon} {capacity: >3}%";
              format-icons = [ "" "" "" "" "" ];
              states = { warning = 30; critical = 15; };
            };
            "pulseaudio" = {
              format = "{icon} {volume}% {format_source}";
              format-bluetooth = "{volume}% {icon} {format_source}";
              format-bluetooth-muted = " {icon} {format_source}";
              format-muted = " {format_source}";
              format-source = "";
              format-source-muted = "";
              format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = [ "" "" "" ];
              };
              on-click = "pavucontrol-qt";
              on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
              scroll-step = 3;
            };
            "network" = {
              "interface" = "wlan0";
              "format-wifi" = "{essid} ({signalStrength}%) ";
              "format-ethernet" = "{ipaddr}/{cidr} ";
              "format-disconnected" = "Disconnected ⚠";
              "interval" = 5;
            };
            "mpd" = {
              format =
                "{title} - {artist}  {stateIcon}  {elapsedTime:%M:%S}/{totalTime:%M:%S}";
              format-disconnected = "";
              format-stopped = "";
              unknown-tag = "N/A";
              interval = 2;
              consume-icons = {
                on = " ";
              };
              random-icons = {
                on = " ";
              };
              repeat-icons = {
                "on" = " ";
              };
              single-icons = {
                "on" = "1 ";
              };
              state-icons = {
                "paused" = "";
                "playing" = "";
              };
              tooltip-format = "mpd (connected)";
              tooltip-format-disconnected = "mpd (disconnected)";
              on-click = "mpc toggle";
              on-click-right = "kitty --class float_kitty sh -c ncmpcpp";
              artist-len = 20;
              title-len = 20;
            };
            "cava" = {
              cava_config = "/home/dz/.config/cava/config";
              hide_on_silence = true;
              bars = 16;
              format-icons = [
                "<span foreground=\"#735cb8\">▁</span>"
                "<span foreground=\"#8a5cb8\">▂</span>"
                "<span foreground=\"#a15cb8\">▃</span>"
                "<span foreground=\"#b85cb8\">▄</span>"
                "<span foreground=\"#b85ca1\">▅</span>"
                "<span foreground=\"#b85c8a\">▆</span>"
                "<span foreground=\"#b85c73\">▇</span>"
                "<span foreground=\"#b85c5c\">█</span>"
              ];
              sleep_timer = 5;
              bar_delimiter = 0;
              framerate = 30;
              monstercat = false;
              waves = false;
              autosens = 0;
              sensitivity = 4;
            };
          };
        };
      };
  services.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = "/home/dz/Pictures/bird.1.png";
      };
    };
  };
  programs.home-manager.enable = true;
}
