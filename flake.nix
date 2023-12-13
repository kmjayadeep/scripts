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

    buildPackage = {
      pkgs,
      name,
      runtimeInputs ? [],
    }:
      pkgs.writeShellApplication {
        name = "${name}";
        runtimeInputs = runtimeInputs;
        text = ''
          ${builtins.readFile ./${name}}
        '';
      };
  in {
    packages = forAllSystems ({pkgs}: {
      gitignore = buildPackage {
        pkgs = pkgs;
        name = "gitignore";
        runtimeInputs = [pkgs.curl];
      };
      mm = buildPackage {
        pkgs = pkgs;
        name = "mm";
        runtimeInputs = [pkgs.bat pkgs.fzf];
      };
      notes = buildPackage {
        pkgs = pkgs;
        name = "notes";
        runtimeInputs = [pkgs.bat pkgs.wl-clipboard pkgs.fzf];
      };
      pomo = buildPackage {
        pkgs = pkgs;
        name = "pomo";
        runtimeInputs = [pkgs.libnotify pkgs.coreutils];
      };
      pull = buildPackage {
        pkgs = pkgs;
        name = "pull";
        runtimeInputs = [pkgs.git];
      };
      push = buildPackage {
        pkgs = pkgs;
        name = "push";
        runtimeInputs = [pkgs.git];
      };
      resticman = buildPackage {
        pkgs = pkgs;
        name = "resticman";
        runtimeInputs = [pkgs.restic];
      };
      vic = buildPackage {
        pkgs = pkgs;
        name = "vic";
      };
    });
  };
}
