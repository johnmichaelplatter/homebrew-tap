class Guitab < Formula
  desc "guitab — MNX based guitar tablature editor with broad microtonal support"
  homepage "https://github.com/johnmichaelplatter/guitab"
  version "0.8.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.8.2/guitab-aarch64-apple-darwin.tar.xz"
      sha256 "453115456b6594304cd699bc7fced8ea2ec3678dc0519a01293c9e3cacfc9c24"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.8.2/guitab-x86_64-apple-darwin.tar.xz"
      sha256 "dc9aae1f750d57a6cc05c22451982b20808febd2330116e8a790baf64ff4ea4a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.8.2/guitab-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b9b1dd00cd11538bb14ad5b3bff7f1bab6b957f93cbdd9a06de5e25382dc7e34"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnmichaelplatter/guitab/releases/download/v0.8.2/guitab-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "561b69420cce12aef56e29661866212ac4065e1528481ae5b21e9b7f7e363fa9"
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
