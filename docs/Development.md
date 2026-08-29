# Development guide

## First setup

1. Install the current Xcode release required by the project.
2. Install XcodeGen if it is not already available.
3. Build the Rust framework with `./script/build_rust.sh apple`.
4. Generate the project with `xcodegen generate`.
5. Open `toolpouch.xcodeproj` and select the scheme for the platform you want to run.

`project.yml` is the source of truth for targets, build settings, resources, and source exclusions. Avoid making lasting project-structure changes only in Xcode because regenerating the project can remove them.

## Building and testing

Run the macOS test suite with:

```bash
xcodebuild test \
  -project toolpouch.xcodeproj \
  -scheme toolpouch \
  -destination 'platform=macOS'
```

Build the mobile and watch targets with:

```bash
xcodebuild build \
  -project toolpouch.xcodeproj \
  -scheme toolpouchMobile \
  -destination 'generic/platform=iOS Simulator'

xcodebuild build \
  -project toolpouch.xcodeproj \
  -scheme toolpouchWatch \
  -destination 'generic/platform=watchOS Simulator'
```

When Xcode is installed outside the default location, prefix the command with the matching `DEVELOPER_DIR` path.

## Rust checks

Run these commands from the repository root after changing a Rust engine or its C interface:

```bash
cargo fmt --manifest-path Rust/Cargo.toml --check
cargo test --manifest-path Rust/Cargo.toml --locked
cargo clippy --manifest-path Rust/Cargo.toml --workspace --all-targets -- -D warnings
```

Build the Apple XCFramework with:

```bash
./script/build_rust.sh apple
```

See [Rust integration](RustIntegration.md) before exposing a new Rust function to Swift.

## Versioning and App Store releases

ToolPouch uses two independent version values shared by the macOS, iOS, and
watchOS targets:

- `MARKETING_VERSION` uses semantic versioning (`MAJOR.MINOR.PATCH`) and is
  visible to users, for example `0.2.0`.
- `CURRENT_PROJECT_VERSION` is an integer build number. Increase it for every
  App Store Connect upload, including a replacement upload for the same release.

Use the version helper instead of editing generated Xcode settings by hand:

```bash
./script/version.sh show
./script/version.sh set-version 0.2.0
./script/version.sh bump-build
```

`project.yml` remains the source of truth. The helper also synchronizes the
currently generated `.xcodeproj`, so it is not necessary to regenerate the
project only to change a version number.

For a release:

1. Set the intended semantic version and increase the build number.
2. Run the complete tests and build all supported targets.
3. Archive and upload the application to App Store Connect.
4. Commit the release changes and create an annotated Git tag, for example
   `git tag -a v0.2.0 -m "ToolPouch 0.2.0"`.
5. Push the commit and tag after the release candidate is accepted.

## Code organization

Each feature should keep its domain rules, data implementation, plugin, and presentation code together. A view should depend on a small domain protocol where the feature talks to the network, filesystem, system framework, or a Rust engine.

Keep shared types in `Core` only when more than one feature genuinely needs them. Platform APIs belong in `Platform` or in the data layer of a platform-specific feature, not in shared SwiftUI views.

## Style and comments

- Write code, symbols, comments, documentation, and user-facing English copy in English.
- Prefer clear names over comments that repeat the implementation.
- Add a short documentation comment to an important contract or a function whose behavior, ownership, or side effects are not obvious.
- Keep SwiftUI views small enough that their layout can be understood without explanatory comments.
- Use design-system values for recurring spacing, icon sizes, and surfaces instead of introducing local constants.

## Before committing

1. Review the changed files and make sure unrelated work is not included.
2. Run the relevant unit tests and build every affected platform.
3. Run the Rust checks when Rust or FFI files changed.
4. Run `git diff --check` to catch whitespace and merge-marker problems.
5. Update documentation when a tool, supported platform, permission, or architectural boundary changes.
