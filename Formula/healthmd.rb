class Healthmd < Formula
  desc "Portable command-line client for Health.md"
  homepage "https://health.md"
  version "0.1.0-alpha.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.5/healthmd-cli-aarch64-apple-darwin.tar.xz"
      sha256 "5d47f371bdf1f698ffb45acf29b3f3cd380eed263e30a1d040e9b11933b0c66f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.5/healthmd-cli-x86_64-apple-darwin.tar.xz"
      sha256 "99e8bd255f6b3d26579cf7a9ff1a554d6cd264ccd9d8d777174d201552c254d3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.5/healthmd-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "055c03c62302c986de512dcef4c4931252fe43b043b07159c1e809532fd82370"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.5/healthmd-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5266a47dbfe96b156233304bc10205fc16d4c436548e43f284a0879423a018d3"
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
