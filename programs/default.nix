{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      # fx file manager
      bat
      chafa
      feh
      felix-fm
      zoxide
    ];

    file = {
      ".config/felix/config.yaml" = {
        enable = true;
        source = ./settings/fx-settings.yaml;
      };
    };

    # shellAliases = {
    #   code = "codium";
    # };
  };

  programs = {
    alacritty = {
      enable = true;
      settings = {
        window.padding = {
          x = 5;
          y = 5;
        };
        scrolling.history = 10000;
      };
    };

    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ll = "ls -l";
        l = "ls -lA";
        la = "ls -la";
      };
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      userName = "Nick Grunert";
      userEmail = "nick.marlon.grunert@gmail.com";
      signing.key = "";
      signing.signByDefault = false;
    };

    gh.enable = true;

    git-cliff = {
      enable = true;
      settings.git = {
        conventional_commits = true;
        filter_unconventional = true;
        split_commits = false;
      };
    };

    gitui = {
      enable = true;
      keyConfig = ./settings/gitui.ron;
    };

    helix = {
      enable = true;
      defaultEditor = true;
      settings = builtins.fromTOML (builtins.readFile ./settings/hx-settings.toml);
    };

    starship = {
      enable = true;
      enableBashIntegration = true;
      settings = builtins.fromTOML (builtins.readFile ./settings/starship.toml);
    };

    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
      # package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions;
        [
          christian-kohler.path-intellisense
          mkhl.direnv
          ms-vscode-remote.remote-containers
          ms-vscode-remote.remote-ssh
          ms-vscode.live-server
          ms-vsliveshare.vsliveshare
          zhuangtongfa.material-theme

          github.copilot
          redhat.java

          ecmel.vscode-html-css
          golang.go
          haskell.haskell
          jnoortheen.nix-ide
          mads-hartmann.bash-ide-vscode
          ms-azuretools.vscode-docker
          ms-python.python
          ms-python.vscode-pylance
          ms-toolsai.jupyter
          ms-toolsai.jupyter-renderers
          ms-toolsai.vscode-jupyter-cell-tags
          ms-toolsai.vscode-jupyter-slideshow
          ms-vscode.cmake-tools
          ms-vscode.cpptools
          njpwerner.autodocstring
          nvarner.typst-lsp
          ocamllabs.ocaml-platform
          rust-lang.rust-analyzer
          serayuzgur.crates
          tamasfe.even-better-toml
          yzhang.markdown-all-in-one
          ziglang.vscode-zig
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "volar";
            publisher = "Vue";
            version = "1.8.27";
            sha256 = "KfWgdz61NURmS1cwFsE9AmIrEykyN5MXIKfG8gDfmac=";
          }
        ];
      mutableExtensionsDir = true;
      userSettings =
        (builtins.fromJSON (builtins.readFile ./settings/vscode.json))
        // {
          "terminal.integrated.defaultProfile.linux" = "bash";
          "terminal.integrated.profiles.linux" = {
            "bash" = {
              "path" = "${pkgs.bashInteractive}/bin/bash";
              "icon" = "terminal-bash";
            };
          };
        };
    };

    #zellij = {
    #  enable = true;
    #  enableBashIntegration = true;
    #  settings = {
    #    simplified_ui = true;
    #    disable-mouse-mode = true;
    #  };
    #};

    home-manager.enable = true;
  };
}
