# Ghidra Linux ARM64 native decompiler

This repository builds the native Ghidra components missing from some Linux ARM64 release archives. The GitHub Actions workflow checks out the upstream Ghidra source and runs the supported Gradle task:

```text
./gradlew buildNatives_linux_arm_64
```

The workflow runs on a native `ubuntu-24.04-arm` runner, uses a 64-bit Temurin JDK 25, and publishes `decompile` and `sleigh` under the layout expected by Ghidra:

```text
Ghidra/Features/Decompiler/os/linux_arm_64/
```

## Run it

1. Push this repository to GitHub.
2. Run **Actions → Build Ghidra Linux ARM64 natives**.
3. Optionally provide a Ghidra tag, branch, or commit through `ghidra_ref`.
4. Download the workflow artifact and copy its `Ghidra/Features/Decompiler/os/linux_arm_64` directory into the matching Ghidra installation.

The default ref is `Ghidra_12.2_build`, the upstream source tag for the `ghidra_12.2_PUBLIC_20261016.zip` release currently available locally. For REA 6.8.0 compatibility, dispatch the workflow with a supported Ghidra 12.1.x ref instead, then use the resulting binary with that same Ghidra release.

## Local build

Use a full upstream Ghidra source checkout, not a release ZIP:

```bash
./scripts/build-local.sh /path/to/ghidra-source
```

The generated executable must match the Ghidra version and host architecture. Do not mix a native binary built from one Ghidra ref with a different release.

## Why this exists

Ghidra's native build model defines `linux_arm_64`, but release archives may omit that platform's native decompiler. The workflow builds the native component from the exact upstream source ref selected for the installation.
# ghidra-arm64-decompiler
