{
  pkgs,
  username,
  stateVersion,
  ...
}: {
  imports = [
    ./programs
  ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/input-sources".sources = "[('xkb', 'de')]";
  };

  home = {
    inherit username stateVersion;
    homeDirectory = "/home/${username}";

    keyboard = {
      layout = "de";
    };

    packages = with pkgs; [
      firefox
      google-chrome
      keepassxc
      slack

      # Development
      lldb
      clang-tools
      cmake-language-server
      dockerfile-language-server-nodejs
      gopls
      haskell-language-server
      marksman
      nil
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      ocamlPackages.dune_3
      ocamlPackages.ocaml-lsp
      ocamlPackages.reason
      opam
      ocaml
      python311Packages.python-lsp-server
      rust-analyzer
      swiProlog
      taplo
      typst-lsp
      yaml-language-server
      zls
    ];
  };

  systemd.user.startServices = "sd-switch";
}
