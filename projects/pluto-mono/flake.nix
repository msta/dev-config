{
  description = "Development environment for pluto-mono project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Go development
            go
            gopls
            go-tools

            # JSON processing
            jq

            # AWS SSO CLI
            aws-sso-cli

            # Additional useful tools
          ];

          shellHook = ''
            echo "🚀 pluto-mono development environment loaded!"
          '';

          # Environment variables
          CGO_ENABLED = "1";
          GOPATH = "$HOME/go";
          GOPROXY = "https://proxy.golang.org,direct";
        };
      });
}
