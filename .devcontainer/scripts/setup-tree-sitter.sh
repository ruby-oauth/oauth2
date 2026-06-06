#!/bin/bash
set -e

# Setup script for tree-sitter dependencies (Ubuntu/Debian)
# Works for both GitHub Actions and devcontainer environments
#
# Dual-Environment Design:
# - GitHub Actions: Runs as non-root user, auto-detects need for sudo
# - Devcontainer: Can run as root (apt-install feature) or non-root (postCreateCommand)
# - Auto-detection: Checks if running as root (id -u = 0), uses sudo if non-root
#
# Grammar building is delegated to tsdl (https://github.com/stackmystack/tsdl).
# Configure grammars and versions in parsers.toml at the project root.
#
# Options:
#   --sudo: Force use of sudo (optional, auto-detected by default)
#   --cli:  Install tree-sitter-cli via npm (optional)
#   --build: Build and install the tree-sitter C runtime from source when distro packages are missing (optional)
#   --tsdl-version VERSION: Pin tsdl release version (default: v2.0.0)
#   --workspace PATH: Workspace root path for informational/debugging purposes only

SUDO=""
INSTALL_CLI=false
BUILD_FROM_SOURCE=false
TSDL_VERSION="v2.0.0"
WORKSPACE_ROOT="/workspaces/${PWD##*/}"

while [[ $# -gt 0 ]]; do
  case $1 in
    --sudo)           SUDO="sudo"; shift ;;
    --cli)            INSTALL_CLI=true; shift ;;
    --build)          BUILD_FROM_SOURCE=true; shift ;;
    --tsdl-version)   TSDL_VERSION="$2"; shift 2 ;;
    --tsdl-version=*) TSDL_VERSION="${1#*=}"; shift ;;
    --workspace)      WORKSPACE_ROOT="$2"; shift 2 ;;
    --workspace=*)    WORKSPACE_ROOT="${1#*=}"; shift ;;
    *) echo "Unknown option: $1" >&2; shift ;;
  esac
done

# Auto-detect if we need sudo (running as non-root)
if [ -z "$SUDO" ] && [ "$(id -u)" -ne 0 ]; then
  SUDO="sudo"
fi

echo "Configuration:"
echo "  Workspace root: $WORKSPACE_ROOT (informational only)"
echo "  Using sudo: $([ -n "$SUDO" ] && echo "yes" || echo "no")"
echo "  Install CLI: $INSTALL_CLI"
echo "  Build from source: $BUILD_FROM_SOURCE"
echo "  tsdl version: $TSDL_VERSION"
echo ""

have_cmd() { command -v "$1" >/dev/null 2>&1; }

have_tree_sitter() {
  [ -f /usr/include/tree-sitter/api.h ] && return 0
  [ -f /usr/local/include/tree-sitter/api.h ] && return 0
  [ -f /usr/local/include/tree-sitter/lib/include/api.h ] && return 0
  ldconfig -p 2>/dev/null | grep -q libtree-sitter && return 0 || return 1
}

install_tree_sitter_from_source() {
  echo "[tree-sitter] Building runtime from source..."
  tmpdir=$(mktemp -d /tmp/tree-sitter-src-XXXX)
  trap 'rm -rf "$tmpdir"' EXIT
  git clone --depth 1 https://github.com/tree-sitter/tree-sitter.git "$tmpdir" || return 1
  pushd "$tmpdir" >/dev/null || return 1
  if ! make; then
    echo "[tree-sitter] ERROR: 'make' failed" >&2
    popd >/dev/null
    return 1
  fi
  $SUDO mkdir -p /usr/local/include/tree-sitter
  $SUDO cp -r lib/include/* /usr/local/include/tree-sitter/ || true
  $SUDO cp -a lib/libtree-sitter.* /usr/local/lib/ 2>/dev/null || true
  have_cmd ldconfig && $SUDO ldconfig || true
  popd >/dev/null
  echo "[tree-sitter] Runtime installed to /usr/local."
  return 0
}

install_tsdl() {
  if have_cmd tsdl; then
    echo "[tsdl] Already installed: $(tsdl --version)"
    return 0
  fi

  echo "[tsdl] Installing tsdl ${TSDL_VERSION}..."
  local arch
  arch="$(uname -m)"
  case "$arch" in
    x86_64)  arch="x64" ;;
    aarch64) arch="arm64" ;;
    armv7l)  arch="arm" ;;
    i686)    arch="x86" ;;
    *) echo "[tsdl] ERROR: Unsupported architecture: $arch" >&2; return 1 ;;
  esac

  local os
  os="$(uname -s | tr '[:upper:]' '[:lower:]')"
  case "$os" in
    linux)  os="linux" ;;
    darwin) os="macos" ;;
    *) echo "[tsdl] ERROR: Unsupported OS: $os" >&2; return 1 ;;
  esac

  local url="https://github.com/stackmystack/tsdl/releases/download/${TSDL_VERSION}/tsdl-${os}-${arch}.gz"
  local tmpbin
  tmpbin=$(mktemp /tmp/tsdl-XXXX)

  if ! wget -q "$url" -O "${tmpbin}.gz"; then
    echo "[tsdl] ERROR: Failed to download from $url" >&2
    return 1
  fi
  gunzip -f "${tmpbin}.gz"
  chmod +x "$tmpbin"
  $SUDO mv "$tmpbin" /usr/local/bin/tsdl
  echo "[tsdl] Installed: $(tsdl --version)"
}

# --- 1. System dependencies ---
echo "Installing system dependencies..."
$SUDO apt-get update -y
if ! $SUDO apt-get install -y \
  build-essential \
  pkg-config \
  $( [ "$BUILD_FROM_SOURCE" = false ] && echo "libtree-sitter-dev" ) \
  wget \
  gcc \
  g++ \
  make \
  zlib1g-dev \
  libssl-dev \
  libreadline-dev \
  libyaml-dev \
  libxml2-dev \
  libxslt1-dev \
  libcurl4-openssl-dev \
  software-properties-common \
  libffi-dev; then
  echo "ERROR: apt-get failed to install required packages." >&2
  exit 1
fi

# --- 2. Tree-sitter runtime ---
if [ "$BUILD_FROM_SOURCE" = true ]; then
  echo "[tree-sitter] --build specified; building runtime from source."
fi

if ! have_tree_sitter; then
  if [ "$BUILD_FROM_SOURCE" = true ]; then
    if ! install_tree_sitter_from_source; then
      echo "[tree-sitter] ERROR: Failed to build runtime. Aborting." >&2
      exit 1
    fi
  else
    echo "[tree-sitter] ERROR: Runtime (headers/libs) not found." >&2
    echo "Install libtree-sitter-dev or re-run with --build." >&2
    exit 1
  fi
fi

# --- 3. tree-sitter-cli (optional) ---
if [ "$INSTALL_CLI" = true ]; then
  echo "Installing tree-sitter-cli via npm..."
  $SUDO npm install -g tree-sitter-cli
else
  echo "Skipping tree-sitter-cli (use --cli to install)"
fi

# --- 4. Install tsdl and build grammars ---
install_tsdl

echo ""
echo "Building tree-sitter grammars via tsdl..."
# Use parsers.toml from the project root if it exists, otherwise build defaults.
# tsdl automatically reads parsers.toml in the current directory.
if [ -f parsers.toml ]; then
  echo "[tsdl] Using parsers.toml config"
  $SUDO tsdl build --out-dir /usr/local/lib --progress plain
else
  echo "[tsdl] No parsers.toml found; building default grammars: toml json bash rbs"
  $SUDO tsdl build toml json bash rbs --out-dir /usr/local/lib --progress plain
fi

$SUDO ldconfig || echo "WARNING: ldconfig failed" >&2

echo ""
echo "tree-sitter setup complete!"
echo ""
echo "Detected library paths:"

if [ -f /usr/lib/x86_64-linux-gnu/libtree-sitter.so.0 ]; then
  echo "  TREE_SITTER_RUNTIME_LIB=/usr/lib/x86_64-linux-gnu/libtree-sitter.so.0"
elif [ -f /usr/lib/x86_64-linux-gnu/libtree-sitter.so ]; then
  echo "  TREE_SITTER_RUNTIME_LIB=/usr/lib/x86_64-linux-gnu/libtree-sitter.so"
elif [ -f /usr/lib/libtree-sitter.so.0 ]; then
  echo "  TREE_SITTER_RUNTIME_LIB=/usr/lib/libtree-sitter.so.0"
elif [ -f /usr/lib/libtree-sitter.so ]; then
  echo "  TREE_SITTER_RUNTIME_LIB=/usr/lib/libtree-sitter.so"
else
  echo "  WARNING: Could not find libtree-sitter runtime library!"
fi

echo ""
echo "Grammar libraries:"
for lib in /usr/local/lib/libtree-sitter-*.so; do
  [ -f "$lib" ] && echo "  $lib"
done
