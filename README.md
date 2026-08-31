# homebrew-myd

Homebrew tap for [myd](https://github.com/tachijuan/myd), a vi-like terminal
file browser with size bars, a treemap, previews, archives and SFTP.

## Install

```bash
brew install tachijuan/myd/myd
```

Or tap first, then install:

```bash
brew tap tachijuan/myd
brew install myd
```

## Notes

The formula builds from source, so a Rust toolchain is installed as a build
dependency. Expect the build to take a minute or two; nothing is required at
runtime beyond the system C library.

To install the latest commit on `master` rather than the newest release:

```bash
brew install --HEAD tachijuan/myd/myd
```
