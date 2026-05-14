{
  description = "Standalone build of tree";

  nixConfig = {
    extra-substituters = [ "https://unpins.cachix.org" ];
    extra-trusted-public-keys = [ "unpins.cachix.org-1:DDaShjbZ8VvcqxeTcAU3kV9vxZQBlyb7V/uLBHfTynI=" ];
  };

  inputs.unpins-lib.url = "github:unpins/nix-lib";

  # Native Linux/macOS comes from pkgsStatic.tree as-is (no fixes registry entry).
  # Windows needs a small source patch (tree-mingw.patch) because upstream tree
  # 2.2.1 hard-includes <pwd.h>/<grp.h>/<langinfo.h> and references S_IFLNK/
  # S_IFSOCK/S_IS{UID,GID,VTX} + uid_t/gid_t/u_long types that MinGW lacks.
  # The patch wraps everything in `#ifdef _WIN32` and stubs each call so tree's
  # existing NULL/error fallbacks take over (no extra runtime libs needed).
  outputs = { self, unpins-lib }:
    unpins-lib.lib.mkStandaloneFlake {
      inherit self;
      name = "tree";
      windowsBuild = pkgs:
        let cross = unpins-lib.lib.mingwStaticCross pkgs; in
        cross.tree.overrideAttrs (old: {
          patches = (old.patches or [ ]) ++ [ ./tree-mingw.patch ];
          # MinGW gcc auto-appends `.exe`, but the Makefile installs
          # `${TREE_DEST}` literally — without this, install fails on `tree`.
          makeFlags = (old.makeFlags or [ ]) ++ [ "TREE_DEST=tree.exe" ];
        });
    };
}
