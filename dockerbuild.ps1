# dockerbuild.ps1

$dockerCommand = @"
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH && \
apt update -y && \
apt install -y curl gnupg build-essential libwebkit2gtk-4.1-dev libssl-dev libgtk-3-dev file apt-utils -y && \
/usr/bin/curl -fsSL https://deb.nodesource.com/setup_lts.x | /bin/bash - && \
apt-get install -y nodejs && \
export SHELL=/bin/bash && /usr/bin/curl -fsSL https://get.pnpm.io/install.sh | /bin/sh - && \
export PATH="/root/.local/share/pnpm:$PATH" && \
/usr/bin/curl -fsSL https://sh.rustup.rs -o /tmp/rustup-init.sh && \
/bin/chmod +x /tmp/rustup-init.sh && \
/usr/bin/env PATH="/usr/bin:$PATH" /tmp/rustup-init.sh -y --profile minimal && \
export PATH="/root/.cargo/bin:$PATH" && \
cd /app && \
/bin/chown -R root:root /app && \
/root/.local/share/pnpm/pnpm install --force && \
cargo install tauri-cli --version "^2.0.0" --locked && \
/root/.local/share/pnpm/pnpm app:build
"@

$dockerCommand = $dockerCommand -replace "`r", ""

docker run -it --rm `
  --privileged `
  -v "${PWD}:/app" `
  ubuntu:latest `
  bash -c $dockerCommand
