{
  description = "Go example flake for Zero to Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    # Systems supported
    allSystems = [
      "x86_64-linux" # 64-bit Intel/AMD Linux
      "aarch64-linux" # 64-bit ARM Linux
      "x86_64-darwin" # 64-bit Intel macOS
      "aarch64-darwin" # 64-bit ARM macOS
    ];

    # Helper to provide system-specific attributes
    forAllSystems = f:
      nixpkgs.lib.genAttrs allSystems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
        });
  in {
    packages = forAllSystems ({pkgs}: {
      gitignore = pkgs.writeShellApplication {
        name = "gitignore";
        runtimeInputs = [ pkgs.bash pkgs.curl ];
        text = ''
          ${builtins.readFile ./gitignore}
        '';
      };
      pull = pkgs.writeShellApplication {
        name = "pull";
        runtimeInputs = [ pkgs.bash pkgs.git ];
        text = ''
          ${builtins.readFile ./pull}
        '';
      };
      push = pkgs.writeShellApplication {
        name = "push";
        runtimeInputs = [ pkgs.bash pkgs.git ];
        text = ''
          ${builtins.readFile ./push}
        '';
      };
    });
  };
}
