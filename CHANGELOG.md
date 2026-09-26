# Changelog

## [Unreleased]

## [2.3.2-3] - 2026-09-26

### Changed

- Built by the same compiler as the rest of the catalog. The Linux x86_64
  binary grew from 148 KB to 220 KB; behaviour is unchanged.

## [2.3.2-2] - 2026-06-16

Packaging-only re-release — no functional changes to `tree`.

## [2.3.2-1] - 2026-06-03

### Changed

- Updated to `tree` 2.3.2, built on the nixos-26.05 nixpkgs channel.

## [2.2.1-1] - 2026-05-24

Initial release — `tree` 2.2.1 as a single self-contained binary, built
natively for Linux, macOS, and Windows.

### Added

- Builds for Linux (x86_64, aarch64, armv7l, i686, ppc64le, riscv64), macOS
  (x86_64, aarch64), and Windows.
- `tree.1` man page embedded in the binary — read it with `unpin man tree`.
