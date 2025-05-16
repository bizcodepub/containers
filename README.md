# dev-containers

## Overview

This repository contains a collection of container build contexts for various development and data science environments. Each subdirectory in `src/` or `incubate/` provides a `Containerfile` (or `Dockerfile`) and optional configuration files for building custom container images.

## Structure

- `src/`: Main container build contexts (e.g., Python, Node.js, R, Spark, etc.)
- `incubate/`: Experimental or in-progress container builds
- `build.sh`: Script to build a container image from a specified directory
- `repo.conf`: Repository configuration (e.g., image registry)
- `build.log`: Build logs (if any)

## Usage

To build a container image:

```sh
. build.sh <directory>
```
- `<directory>`: Path to a build context (must contain a `Containerfile` or `Dockerfile`).

Example:
```sh
. build.sh src/base-debian-nodejs
```

## Adding a New Container

1. Create a new directory under `src/` or `incubate/`.
2. Add a `Containerfile` and any required files (e.g., `requirements.txt`).
3. Optionally, update `repo.conf` with your repository name.

## Notes

- Images are tagged using the `version` label in the `Containerfile`. If not present, `latest` is used.
- The repository name is read from `repo.conf` if available.
- See each subdirectory for specific environment details.