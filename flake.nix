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
      nixpkgsFor = ulib.forAllNative (system: import nixpkgs { inherit system; });
    in
    {
      packages = ulib.forAllNative (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          # pkgsStatic on Linux yields a fully static musl binary.
          # On Darwin, libSystem stays dynamic (Apple constraint), but
          # everything else is linked statically — portable across any
          # macOS without a /nix/store.
          default = pkgs.pkgsStatic.tree.overrideAttrs (old: {
            stripAllList = [ "bin" ];
          });
        });

      apps = ulib.forAllNative (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/tree";
        };
      });
    };
}
