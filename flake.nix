{
  description = "NixOS home configuration";

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {self, ...}:
    inputs.flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      username = "nickgrunert";
      stateVersion = "24.11";
    in {
      formatter = pkgs.alejandra;
      packages.homeConfigurations = {
        ${username} = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit username stateVersion;
          };
          modules = ["${self}/configuration.nix"];
        };
      };
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          (writeShellScriptBin "check" ''
            nix fmt --no-write-lock-file
            home-manager build --flake . --dry-run --print-build-logs
          '')
          (writeShellScriptBin "update" ''
            nix fmt --no-write-lock-file
            nix flake update --commit-lock-file
          '')
          (writeShellScriptBin "upgrade" ''
            if [ -z "$1" ]; then
              username=$(whoami)
            else
              username=$1
            fi

            nix fmt --no-write-lock-file
            home-manager switch --flake .#''${username}
          '')
          home-manager
          alejandra
          deadnix
          nil
          statix
        ];
      };
    });
}
