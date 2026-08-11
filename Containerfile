FROM ghcr.io/containerpak/gtk:main

RUN apt update && \
    apt install -y --no-install-recommends \
      ca-certificates \
      dpkg \
      fonts-liberation \
      libasound2 \
      libatk-bridge2.0-0 \
      libglib2.0-0 \
      libgtk-3-0 \
      libnspr4 \
      libnss3 \
      libxss1 \
      libx11-xcb1 \
      libxcb1 \
      libatk1.0-0 \
      libcups2 \
      libdbus-1-3 \
      libdrm2 \
      libgbm1 \
      libpango-1.0-0 \
      libpangocairo-1.0-0 \
      libstdc++6 \
      libu2f-udev \
      libvulkan1 \
      libxcomposite1 \
      libxdamage1 \
      libxrandr2 \
      libxtst6 \
      xdg-utils && \
    cpak-clean-junk
