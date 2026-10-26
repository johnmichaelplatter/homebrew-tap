class Guitab < Formula
  desc "guitab — MNX based guitar tablature editor with broad microtonal support"
  homepage "https://github.com/johnmichaelplatter/guitab"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.7.0/guitab-aarch64-apple-darwin.tar.xz"
      sha256 "36a968db2dc57231cd4b0c89f6f67c23b93e546c5abe8f0b7d4f9aaa1ba5bd57"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.7.0/guitab-x86_64-apple-darwin.tar.xz"
      sha256 "51e764af53e57fbf20774124667c7dcfa84f8fbeb70585336f860d54480e360b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.7.0/guitab-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "44f3d23d9aa79030887b7a1c7a8b65e69a11f93853166d27010a8c72b012e953"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.7.0/guitab-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2453ad4e07788ddf321ed6982cac00f8f6b49bad66f16430a23977c34f26a28d"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "guitab"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "guitab"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "guitab"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "guitab"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
