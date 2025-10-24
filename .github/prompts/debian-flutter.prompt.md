---
mode: agent
description: Build a Debian-based container with Flutter SDK installed via manual installation.
model: Claude Sonnet 4 (copilot)
---

# General Container Requirements
- Build Containers for Podman runtime
- Use Debian as the base OS for the containers
- Install Flutter SDK in the container using manual installation below
- Use `src/debian-flutter` as the project directory
- Ensure the container is optimized for size and performance

# Containerfile Requirements
- Use `debian:bullseye` as the base image
- Include label for author
- Include label for version. Base version on Flutter version being installed.


# Flutter Manual Installation on Linux (Debian-based)
- Install Flutter version `3.35.7`
- Fetch install instructions from the official Flutter documentation - https://docs.flutter.dev/install/manual

## Container Security Requirements
- **Non-root execution**: Create a dedicated non-root user (`flutter`) to run Flutter commands instead of root
- **Proper file ownership**: Set correct ownership (`chown -R flutter:flutter /flutter`) for Flutter SDK files
- **Secure permissions**: Apply appropriate file permissions (`chmod -R 755 /flutter`) to Flutter directory

## Git Repository Safety Requirements
- **Safe directory configuration**: Add Flutter SDK path to git safe directories (`git config --global --add safe.directory /flutter`) to prevent dubious ownership warnings
- **Repository access**: Ensure git can properly access the Flutter SDK repository without security errors

## Flutter Configuration Requirements
- **Analytics disabled**: Use correct command (`flutter --disable-analytics`) to disable Flutter analytics collection
- **Optimized precaching**: Use selective precaching (`flutter precache --no-android --no-ios`) to:
  - Reduce container image size
  - Exclude unnecessary mobile platform dependencies
  - Focus on web and desktop development capabilities
  - Minimize build time and bandwidth usage

## Container Build Requirements
- **Multi-stage optimization**: Maintain efficient multi-stage build to separate build dependencies from runtime
- **Package cleanup**: Remove package manager cache (`rm -rf /var/lib/apt/lists/*`) to reduce image size
- **PATH configuration**: Ensure Flutter tools are accessible via system PATH

