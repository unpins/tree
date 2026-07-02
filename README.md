# tree

[tree](https://oldmanprogrammer.net/source.php?dir=projects/tree) as a single self-contained binary, built natively for Linux, macOS, and Windows.

[![CI](https://github.com/unpins/tree/actions/workflows/tree.yml/badge.svg)](https://github.com/unpins/tree/actions)
![Linux](https://img.shields.io/badge/Linux-✓-success?logo=linux&logoColor=white)
![macOS](https://img.shields.io/badge/macOS-✓-success?logo=apple&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-✓-success?logo=windows&logoColor=white)

Part of the [unpins](https://unpins.org) catalog; install it with [`unpin`](https://github.com/unpins/unpin): `unpin install tree`.

## Usage

Run the `tree` program with [unpin](https://github.com/unpins/unpin):

```bash
unpin tree -L 2 dir/
```

To install it onto your PATH:

```bash
unpin install tree
```

## Man pages

`tree.1` is embedded in the binary — read it with `unpin man tree`.

## Build locally

```bash
nix build github:unpins/tree
./result/bin/tree
```

Or run directly:

```bash
nix run github:unpins/tree
```

The first invocation will offer to add the [unpins.cachix.org](https://unpins.cachix.org) substituter so most pulls come pre-built.

## Manual download

The [Releases](https://github.com/unpins/tree/releases) page has standalone binaries for manual download.

## Build notes

- **Windows** uses [Cosmopolitan](https://justine.lol/cosmopolitan/) (cosmocc), not mingw. The mingw cross built and ran, but msvcrt's `readdir()` runs in ANSI code-page mode and silently drops filenames outside the active code page (CJK, emoji, often Latin-1 accents on a CP437/CP850 console). Cosmocc's libc uses Win32 wide-char APIs internally and exposes UTF-8 to user code, so filenames round-trip correctly. Cost: larger on disk than the 120K mingw PE — cosmocc's libc is heavier.
- No upstream features are disabled; no platforms are excluded.
- **Tests:** tree ships no test suite of its own (a plain Makefile with no `make check` target), so there is nothing to wire; the release smoke test runs `tree --version`.
