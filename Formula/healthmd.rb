class Healthmd < Formula
  desc "Portable command-line client for Health.md"
  homepage "https://health.md"
  version "0.1.0-alpha.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.6/healthmd-cli-aarch64-apple-darwin.tar.xz"
      sha256 "18dedb50d8f186cf009ca13ca76bff703a64f6389b76e921b1951364880724b7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.6/healthmd-cli-x86_64-apple-darwin.tar.xz"
      sha256 "2235d92bd8b4904775b55f2e29bf8765a000dc5e782cc1ebfe78b3ae1f71af2f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.6/healthmd-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "517c488b432c8f011a78f0bad523aeb7ba0ae7069a198b21d8ee6ee603342c2b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.6/healthmd-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1407cf0cb3ef0a136b130220ec1a00b42fe96b09ea881e28e14713c47eac9a6b"
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
