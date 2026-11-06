class Guitab < Formula
  desc "guitab — MNX based guitar tablature editor with broad microtonal support"
  homepage "https://github.com/johnmichaelplatter/guitab"
  version "0.8.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.8.5/guitab-aarch64-apple-darwin.tar.xz"
      sha256 "21b6ec6f3e2afae31c350bff2054683a811af09b7b217e34ab9d37e27b54d701"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.8.5/guitab-x86_64-apple-darwin.tar.xz"
      sha256 "017eb7f7859bee3ef0c9fafda1f983977381082885e2fef35d909df47f850597"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.8.5/guitab-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "28f9b897a00c5f89ad98fcbca4502c678b07fc00f29de740af943d2a72b105f4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.8.5/guitab-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "04ea24a0644ce61fe936ecddcb11c32bc9019c3050518809326f44d9a891384a"
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
