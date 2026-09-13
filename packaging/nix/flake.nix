{
  description = "Interactive SSH Fuzzy Manager with Live Metadata Preview";

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
        packages.default = pkgs.stdenv.mkDerivation rec {
          pname = "sshm";
          version = "1.1.0";
          src = ./../..;

          buildInputs = [ pkgs.bash pkgs.openssh pkgs.fzf ];

          installPhase = ''
            mkdir -p $out/bin
            install -m 755 bin/sshm $out/bin/sshm
          '';

          meta = with pkgs.lib; {
            description = "Interactive SSH Fuzzy Manager with Live Metadata Preview";
            homepage = "https://github.com/zyekhabdul/sshm";
            license = licenses.mit;
            maintainers = [ "zyekhabdul" ];
          };
        };

        apps.default = flake-utils.lib.mkApp {
          drv = self.packages.${system}.default;
        };
      }
    );
}
