class Guitab < Formula
  desc "guitab — MNX based guitar tablature editor with broad microtonal support"
  homepage "https://github.com/johnmichaelplatter/guitab"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.7.1/guitab-aarch64-apple-darwin.tar.xz"
      sha256 "a3c70a090234e10bd77bb8f06d31c6117d824bda0444378aa8e4d97fbb70667e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.7.1/guitab-x86_64-apple-darwin.tar.xz"
      sha256 "2595f714234355804b1adf77a3ad28169fa13947a14db778645acf5724d216db"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.7.1/guitab-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c50acacbdc086b8389ebfe4217b4af4faa00a2dc4dbf5336ea3ea7145f9b3b06"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.7.1/guitab-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f2e7cbd2b3db9b384407b9543602033bd38c2687a00708a7a43906d20014d593"
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
