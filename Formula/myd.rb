class Myd < Formula
  desc "Vi-like terminal file browser with size bars, treemap, archives and SFTP"
  homepage "https://github.com/tachijuan/myd"
  url "https://github.com/tachijuan/myd/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "43d342d9c8558f983594cad52da3eccd08f6f02eacd9f389b77fd791a1e39901"
  license "MIT"
  head "https://github.com/tachijuan/myd.git", branch: "master"

  # OpenSSL and pkg-config are build-time only, and the reason is not obvious.
  # The installed binary links against libc, libm and libgcc alone -- every
  # compression backend and the whole SFTP stack is static. But `ssh2-config`
  # declares `git2` under [build-dependencies], which drags in `openssl-sys`,
  # whose build script needs OpenSSL headers and pkg-config to find them.
  # Verified: without these the build fails with "Could not find directory of
  # OpenSSL installation"; with them, `ldd` on the result still shows no
  # OpenSSL, which is why both are `=> :build` and not runtime dependencies.
  depends_on "openssl@3" => :build
  depends_on "pkg-config" => :build
  depends_on "rust" => :build

  def install
    # The crate lives in myd/, not at the repo root; there is no workspace
    # manifest above it. std_cargo_args supplies --locked and the right --root.
    system "cargo", "install", *std_cargo_args(path: "myd")
    man1.install "doc/myd.1"
  end

  test do
    # The TUI needs a terminal, so only the non-interactive paths are testable.
    assert_match "myd #{version}", shell_output("#{bin}/myd --version")
    assert_match "Usage: myd", shell_output("#{bin}/myd --help")
  end
end
