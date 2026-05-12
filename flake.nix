{
  description = "Standalone build of tree";

  nixConfig = {
    extra-substituters = [ "https://unpins.cachix.org" ];
    extra-trusted-public-keys = [ "unpins.cachix.org-1:DDaShjbZ8VvcqxeTcAU3kV9vxZQBlyb7V/uLBHfTynI=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    unpins-lib.url = "github:unpins/nix-lib/v1";
  };

  outputs = { self, nixpkgs, unpins-lib }:
    let
      ulib = unpins-lib.lib;
      lib = nixpkgs.lib;
      nixpkgsFor = ulib.forAllNative (system: import nixpkgs { inherit system; });

      # tree as a portable single binary for any pkgs view.
      # - On Linux: pkgsStatic.tree yields fully-static musl.
      # - On Darwin: libSystem stays dynamic (Apple constraint), but tree
      #   has no other runtime deps so the binary is libSystem-only.
      buildTree = pkgs:
        pkgs.pkgsStatic.tree.overrideAttrs (_: {
          stripAllList = [ "bin" ];
        });
    in
    {
      packages = ulib.forAllNative (system:
        let pkgs = nixpkgsFor.${system}; in
        {
          default = buildTree pkgs;
        } // lib.optionalAttrs (system == "aarch64-darwin") {
          # Cross-built tree for x86_64-darwin, hosted on macos-14 — same
          # single-runner pattern as packages.x86_64-linux."windows-x86_64".
          "darwin-x86_64" = buildTree pkgs.pkgsCross.x86_64-darwin;
        });

      apps = ulib.forAllNative (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/tree";
        };
      });
    };
}
