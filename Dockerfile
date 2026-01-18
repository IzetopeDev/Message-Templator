FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# 1. Install ALL system dependencies (Slowest / Heaviest / Most Stable)
#    We use 'openjdk-21-jdk' (LTS) which is the standard for Android development in 2025/2026.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    liblzma-dev \
    libstdc++-12-dev \
    adb \
    usbutils \
    openjdk-21-jdk \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# 2. Setup Android SDK Environment Variables
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH="${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${PATH}"

# 3. Install Android Command Line Tools (as root)
#    We bootstrap with a known zip, but then explicitly install 'cmdline-tools;latest'
#    to ensure we have the absolute newest tools.
#    We also target Android 35 (Android 15) which is the stable target for 2026.
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools \
    && curl -o android_tools.zip https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip \
    && unzip -q android_tools.zip -d ${ANDROID_HOME}/cmdline-tools \
    && mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest \
    && rm android_tools.zip \
    && yes | ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager --licenses \
    && ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager "cmdline-tools;latest" "platform-tools" "platforms;android-35" "build-tools;35.0.0" \
    && chown -R vscode:vscode ${ANDROID_HOME}

# 4. Set up the non-root user (vscode)
USER vscode
WORKDIR /home/vscode

# 5. Install Flutter SDK (Latest Stable)
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1

# 6. Add Flutter to the PATH
ENV PATH="/home/vscode/flutter/bin:${PATH}"

# 7. Pre-download development binaries & Config
RUN flutter config --no-analytics \
    && flutter config --android-sdk ${ANDROID_HOME} \
    && flutter precache \
    && flutter doctor \
    && flutter config --enable-web

COPY --chown=vscode:vscode ./container_config /home/vscode/container_config