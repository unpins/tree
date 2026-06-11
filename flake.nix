{
  description = "tree as a single self-contained binary";

  nixConfig = {
    extra-substituters = [ "https://unpins.cachix.org" ];
    extra-trusted-public-keys = [ "unpins.cachix.org-1:DDaShjbZ8VvcqxeTcAU3kV9vxZQBlyb7V/uLBHfTynI=" ];
  };

  inputs.unpins-lib.url = "github:unpins/nix-lib";

  # Native Linux/macOS comes from pkgsStatic.tree as-is.
  # Windows uses cosmocc, not mingw. The mingw cross built with a 62-line POSIX
  # shim patch and produced a 120K .exe, but msvcrt's `readdir()` runs in ANSI
  # code page mode — any filename outside the active code page (CJK, emoji,
  # often even Latin-1 with accents on a CP437/CP850 console) is mangled or
  # silently dropped from the listing. That's data loss, not just rendering.
  # Cosmocc's libc uses Win32 wide-char APIs internally and exposes UTF-8 to
  # user code, so filenames round-trip correctly. It also auto-sets
  # `SetConsoleOutputCP(CP_UTF8)` at startup so box-drawing chars render
  # without manual `chcp 65001`. Cost: ~440KB extra on disk (560K APE vs 120K
  # mingw PE). The `LDFLAGS=` override needed for apelink lives in
  # nix-lib/cosmo/tree.nix (auto-discovered via readDir).
  outputs = { self, unpins-lib }:
    unpins-lib.lib.mkStandaloneFlake {
      inherit self;
      name = "tree";
      windowsCosmo = true;
    };
}
