{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      perSystem = { pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            k3d
            kubectl
          ];

          shellHook = ''
            export KUBECONFIG="$(pwd)/kubeconfig.yaml"
          '';
        };
      };
    };
}
