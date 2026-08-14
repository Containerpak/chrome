FROM ubuntu:26.04 AS chrome-source

ARG CHROME_SHA256=bfb6e6d345055eb481a50db423256fa2732ce010f785a56c327e213a638efdef

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl && \
    curl --fail --location --output /tmp/google-chrome.deb \
      https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    echo "${CHROME_SHA256}  /tmp/google-chrome.deb" | sha256sum --check -

FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/chrome"

RUN --mount=type=bind,from=chrome-source,source=/tmp/google-chrome.deb,target=/run/google-chrome.deb \
    apt-get update && \
    apt-get install -y /run/google-chrome.deb && \
    sed -i 's|/usr/bin/google-chrome-stable|/usr/local/bin/cpak chromium-launch --user-data-dir ~/.config/google-chrome --executable /usr/bin/google-chrome-stable --|g' \
      /usr/share/applications/google-chrome.desktop && \
    cpak-clean-junk
