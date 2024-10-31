{
  description = "Generic development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
            "terraform"
          ];
        };
      in
      {
        devShell = pkgs.mkShell {
          packages = with pkgs; [
            direnv
            awscli2
            gum
            terraform
          ];
        };
      }
    );
}
