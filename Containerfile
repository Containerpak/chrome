FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/chrome"

COPY google-chrome-cpak.desktop /usr/share/applications/google-chrome-cpak.desktop

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      fonts-liberation \
      libcups2t64 \
      libcurl4t64 \
      libnss3 \
      wget \
      xdg-utils && \
    cpak-clean-junk
