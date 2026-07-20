class RetuneForAll < Formula
  desc "A performance-oriented microtonal MIDI retuner that can send multi-timbral or MPE midi, supports scala scl/kbm file import, and reads & writes YAML presets."
  homepage "https://github.com/johnmichaelplatter/retune-for-all"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johnmichaelplatter/retune-for-all/releases/download/v0.1.1/retune-for-all-aarch64-apple-darwin.tar.xz"
      sha256 "9fcd4e3d21be7335e7d17aea923d5c01fdcc7b4d0c68fd8a497dbf2798a57548"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnmichaelplatter/retune-for-all/releases/download/v0.1.1/retune-for-all-x86_64-apple-darwin.tar.xz"
      sha256 "9cbae8b1ab0d20f5a0a98f57a92939daf2b685beb25cdca5e0d93e240530c1e0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johnmichaelplatter/retune-for-all/releases/download/v0.1.1/retune-for-all-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "55b0bb26032af7193c3f9f5b92a14059ee4e4557969df87d18ff7b70c843f426"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnmichaelplatter/retune-for-all/releases/download/v0.1.1/retune-for-all-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5ec1eb1c4fb422e05df88b4c76bc9f4f5763b3b552571ef546871b6ee903e4cb"
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
    bin.install "retune-for-all" if OS.mac? && Hardware::CPU.arm?
    bin.install "retune-for-all" if OS.mac? && Hardware::CPU.intel?
    bin.install "retune-for-all" if OS.linux? && Hardware::CPU.arm?
    bin.install "retune-for-all" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
