# tree

Standalone build of [tree](https://oldmanprogrammer.net/source.php?dir=projects/tree).

[![CI](https://github.com/unpins/tree/actions/workflows/tree.yml/badge.svg)](https://github.com/unpins/tree/actions)
![Linux](https://img.shields.io/badge/Linux-✓-success?logo=linux&logoColor=white)
![macOS](https://img.shields.io/badge/macOS-✓-success?logo=apple&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-✓-success?logo=windows&logoColor=white)

Part of the [unpins](https://unpins.org) project — native single-binary builds with no third-party runtime dependencies.

## Installation

Install with [unpin](https://github.com/unpins/unpin):

```bash
unpin tree
```

Or run without installing:

```bash
unpin run tree
```

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

The [Releases](https://github.com/unpins/tree/releases) page has standalone binaries and a `.tar.zst` data archive (man pages and completions) for manual download.
