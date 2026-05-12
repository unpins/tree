# tree

Standalone build of [tree](https://oldmanprogrammer.net/source.php?dir=projects/tree). Runs on any Linux or macOS without external dependencies.

## Installation

You can install this package instantly using the [unpin](https://github.com/unpins/unpin) package manager:

```bash
unpin tree
```

Or run it without installing:

```bash
unpin run tree
```

## Build locally

```bash
nix build github:unpins/tree
./result/bin/tree
```

Or, in one shot:

```bash
nix run github:unpins/tree
```

The first invocation will offer to add the [unpins.cachix.org](https://unpins.cachix.org) substituter so most pulls come pre-built.

## Manual Download

Standalone binaries and data packages are available on the [Releases](https://github.com/unpins/tree/releases) page.
