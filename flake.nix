{
  description = "Neovim configurtion";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs
    , flake-utils
    , ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        nativeBuildInputs = with pkgs; [
          lua-language-server
          stylua

          statix
          nixd
          deadnix
        ];
        buildInputs = with pkgs; [ ];
      in
      {
        devShells = {
          default = pkgs.mkShell { inherit nativeBuildInputs buildInputs; };
          nix = pkgs.mkShell {
            inherit buildInputs;

            nativeBuildInputs = nativeBuildInputs ++ (with pkgs;[
              deadnix
              statix
              nixd
              nixpkgs-fmt
            ]);
          };
        };
      }
    );
}
