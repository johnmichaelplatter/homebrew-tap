class Guitab < Formula
  desc "guitab — MNX based guitar tablature editor with broad microtonal support"
  homepage "https://github.com/johnmichaelplatter/guitab"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.8.0/guitab-aarch64-apple-darwin.tar.xz"
      sha256 "49e1998d0e22ae4f3b4d6db649e0bb344c1e84f2cf70912916dd2a5ed04a11ef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.8.0/guitab-x86_64-apple-darwin.tar.xz"
      sha256 "90c6cd6833508dfea3a3b6d2ebab96fe79ad0af8c9990158256bb7f0098c72d3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.8.0/guitab-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "60c097514feedbeb321ecb02970d57cb8ab180bef950fe6cc31d2089a6fe5534"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.8.0/guitab-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4deb656429d48b5ef636095c8aaf801517dd4f4e62f164c26eb3388bc5db985e"
    end
  end
  license "MIT"

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
