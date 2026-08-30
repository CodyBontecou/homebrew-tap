# Health.md Homebrew tap

Official Homebrew and Linuxbrew formulae for [Health.md](https://health.md).

Install the explicitly unqualified Health.md CLI public preview on macOS or Linux:

```sh
brew install CodyBontecou/tap/healthmd
healthmd --version
```

The tap currently tracks preview releases. Package publication does not qualify a CLI/mobile pair;
use the exact matching Health.md mobile build named by the release evidence. The first stable CLI
release remains gated on the complete physical-device compatibility matrix.

Upgrade with:

```sh
brew update
brew upgrade healthmd
```

Formulae in this tap are generated from versioned, checksummed Health.md CLI release archives. The release workflow publishes the CLI without changing the repository-wide latest release, which remains reserved for the Apple apps.

Release and verification documentation lives in the [`health-md`](https://github.com/CodyBontecou/health-md/tree/main/apps/cli) repository.
