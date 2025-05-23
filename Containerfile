# 1. BUILD
FROM ghcr.io/containerpak/gtk-sdk:main AS builder
ARG VERSION=136.0.7103.113-1
WORKDIR /tmp

RUN apt update && \
    apt install -y --no-install-recommends \
      wget \
      dpkg && \
    rm -rf /var/lib/apt/lists/*

RUN wget -O chrome.deb \
      "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${VERSION}_amd64.deb"

RUN dpkg-deb -x chrome.deb / && \
    rm chrome.deb

# 2. RUNTIME

FROM ghcr.io/containerpak/gtk:main AS runtime
COPY --from=builder /opt/google/chrome /app
COPY com.google.Chrome.desktop /usr/share/applications/com.google.Chrome.desktop
COPY com.google.Chrome.svg /usr/share/icons/hicolor/scalable/apps/com.google.Chrome.svg
RUN ln -s /app/google-chrome /usr/bin/google-chrome
RUN ln -s /app/google-chrome /usr/bin/chrome
RUN apt update && \
    apt install -y --no-install-recommends \
      libglib2.0-0 \
      libgtk-3-0 \
      libnss3 \
      libxss1 \
      libasound2t64 \
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
      fonts-liberation && \
    cpak-clean-junk
