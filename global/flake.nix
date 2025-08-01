
{
  description = "msta's global nix packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
    in
    {
      packages.aarch64-darwin.default = pkgs.buildEnv {
        name = "nix-global";
        paths = [
          pkgs.nix
          pkgs.git
          pkgs.delta
          pkgs.bat
          pkgs.direnv
          pkgs.starship
          pkgs.apple-sdk
          pkgs.pre-commit
          pkgs.fish
          pkgs.colima
          pkgs.docker
          pkgs.raycast
          pkgs.eza
          (pkgs.fetchFromGitHub {
            owner = "lilyball";
            repo = "nix-env.fish";
            rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
            sha256 = "RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
          })
        ];
      };
      devShells.aarch64-darwin.default = pkgs.mkShell {
        name = "nix-global-dev";
        packages = [
          pkgs.nixd
          pkgs.nil
          pkgs.just
        ];
      };
    };
}
