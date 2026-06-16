# Changelog

## [Unreleased]

## [v2.3.2-2] - 2026-06-16

Packaging-only re-release — no functional changes to `tree`.

## [v2.3.2-1] - 2026-06-03

### Changed

- Updated to `tree` 2.3.2, built on the nixos-26.05 nixpkgs channel.

## [v2.2.1-1] - 2026-05-24

Initial release — `tree` 2.2.1 as a single self-contained binary, built
natively for Linux, macOS, and Windows.

### Added

- Builds for Linux (x86_64, aarch64, armv7l, i686, ppc64le, riscv64), macOS
  (x86_64, aarch64), and Windows.
- `tree.1` man page embedded in the binary — read it with `unpin man tree`.
