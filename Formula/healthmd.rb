class Healthmd < Formula
  desc "Portable command-line client for Health.md"
  homepage "https://health.md"
  version "0.1.0-alpha.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.4/healthmd-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6f8c84bba674252b3733a492c6e7dc576f8649c1ca8bcc20c436b26b715e0249"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.4/healthmd-cli-x86_64-apple-darwin.tar.xz"
      sha256 "98502466c479f8829e017986c3c409605313e44e4d3bc21ab8a0b5a3772d731d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.4/healthmd-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cc80ed2104de7d3e7d39e91dec2904be7edcd7518773707f8b2dd3a678be6fa9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.4/healthmd-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5d26e1927b3eae656b0aec38c7f7a69e83a21855a83632ecb389a16b108af9ad"
    end
  end
  license "AGPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
      bin.install "healthmd", "healthmd-mcp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "healthmd", "healthmd-mcp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "healthmd", "healthmd-mcp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "healthmd", "healthmd-mcp"
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
