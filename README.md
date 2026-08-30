# Health.md Homebrew tap

Official Homebrew and Linuxbrew formulae for [Health.md](https://health.md).

No Health.md CLI formula is currently published. Once the first checksummed public preview passes
its release and clean-install gates, install it on macOS or Linux with:

```sh
brew install CodyBontecou/tap/healthmd
healthmd --version
```

Preview publication does not qualify a CLI/mobile pair. Use only the exact matching Health.md mobile
build named by published release evidence. The first stable CLI release remains gated on the
complete physical-device compatibility matrix.

After publication, upgrade with:

```sh
brew update
brew upgrade healthmd
```

Formulae in this tap are generated from versioned, checksummed Health.md CLI release archives. The release workflow publishes the CLI without changing the repository-wide latest release, which remains reserved for the Apple apps.

Release and verification documentation lives in the [`health-md`](https://github.com/CodyBontecou/health-md/tree/main/apps/cli) repository.
