class Healthmd < Formula
  desc "Portable command-line client for Health.md"
  homepage "https://health.md"
  version "0.1.0-alpha.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.3/healthmd-cli-aarch64-apple-darwin.tar.xz"
      sha256 "8ea16f2d4672d7b1d665e17787d672732bac870413f544772a589bb344fc45e2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.3/healthmd-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7829f25c0e280dd7e948daddc94f486a674188f1dc154220ebfc6dec6ec76380"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.3/healthmd-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "43bd57827db930d9cd271b305d1cf40b52540f48e83aaaf9ab4e27a8756e7ab7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CodyBontecou/health-md/releases/download/healthmd-cli/v0.1.0-alpha.3/healthmd-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f952c35fc4c448e533d0d742bbd4a0ca6d66143d9b257aa18d35ee9b004a6ba3"
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
