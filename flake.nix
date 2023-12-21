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
      backup_ssd = buildPackage {
        pkgs = pkgs;
        name = "backup_ssd";
        runtimeInputs = [pkgs.restic];
      };
      backup_nuc_restic = buildPackage {
        pkgs = pkgs;
        name = "backup_nuc_restic";
        runtimeInputs = [pkgs.restic pkgs.coreutils];
      };
      backup_private = buildPackage {
        pkgs = pkgs;
        name = "backup_private";
        runtimeInputs = [pkgs.restic];
      };
      gitignore = buildPackage {
        pkgs = pkgs;
        name = "gitignore";
        runtimeInputs = [pkgs.curl];
      };
      kcontext = buildPackage {
        pkgs = pkgs;
        name = "kcontext";
        runtimeInputs = [pkgs.kubectl];
      };
      makescript = buildPackage {
        pkgs = pkgs;
        name = "makescript";
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
      publiclocation = buildPackage {
        pkgs = pkgs;
        name = "publiclocation";
        runtimeInputs = [pkgs.curl];
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
      tchat = buildPackage {
        pkgs = pkgs;
        name = "tchat";
        runtimeInputs = [pkgs.libnotify pkgs.coreutils];
      };
      todo = buildPackage {
        pkgs = pkgs;
        name = "todo";
        runtimeInputs = [pkgs.taskwarrior];
      };
      vic = buildPackage {
        pkgs = pkgs;
        name = "vic";
      };
    });
  };
}
