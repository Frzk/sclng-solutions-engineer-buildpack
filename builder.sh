#!/bin/bash

# set -x
set -e

STACK_VERSIONS=(20)
PRECOMPILED_DIR="compiled"


# Retrieves the latest version of libvips from GitHub.
function retrieve_latest_version() {
    local url="https://api.github.com/repos/libvips/libvips/releases/latest"

    curl -s "${url}" \
    | grep "browser_download_url.*tar.gz" \
    | grep "[0-9]*\.[0-9]*\.[0-9]" -o \
    | head -1
}


LATEST_VERSION="$( retrieve_latest_version )"
VIPS_VERSION="${VIPS_VERSION:-${LATEST_VERSION}}"

#
#
function build_all() {
    for stack_version in "${STACK_VERSIONS[@]}"
    do
        image_name="libvips-scalingo-${stack_version}:${VIPS_VERSION}"

        docker build \
            --build-arg VIPS_VERSION=${VIPS_VERSION} \
            --build-arg STACK_VERSION=${stack_version}\
            --tag "${image_name}" \
            builder

        mkdir -p "${PRECOMPILED_DIR}"

        # Compile libvips in the container and retrieve the generated .tar.gz file:
        docker run \
            --rm \
            --tty \
            --volume "${PWD}/${PRECOMPILED_DIR}":/build \
            "${image_name}" \
            sh -c "cp -f /usr/local/vips/build/*.tar.gz /build"
    done
}

build_all
