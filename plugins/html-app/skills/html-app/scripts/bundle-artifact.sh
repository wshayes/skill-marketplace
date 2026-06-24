#!/bin/bash
# Adapted from Anthropic's "web-artifacts-builder" skill (Apache 2.0; see LICENSE.txt).
set -e

echo "📦 Bundling React app to a single self-contained HTML artifact..."

# Check if we're in a project directory
if [ ! -f "package.json" ]; then
  echo "❌ Error: No package.json found. Run this script from your project root."
  exit 1
fi

# Check if index.html exists
if [ ! -f "index.html" ]; then
  echo "❌ Error: No index.html found in project root."
  echo "   This script requires an index.html entry point."
  exit 1
fi

# Install bundling dependencies
echo "📦 Installing bundling dependencies..."
pnpm add -D parcel @parcel/config-default parcel-resolver-tspaths html-inline

# Create Parcel config with tspaths resolver (resolves the @/ alias)
if [ ! -f ".parcelrc" ]; then
  echo "🔧 Creating Parcel configuration with path alias support..."
  cat > .parcelrc << 'EOF'
{
  "extends": "@parcel/config-default",
  "resolvers": ["parcel-resolver-tspaths", "..."]
}
EOF
fi

# Clean previous build
echo "🧹 Cleaning previous build..."
rm -rf dist .parcel-cache bundle.html

# Build with Parcel. Parcel auto-detects postcss.config.js, so Tailwind v4
# (@tailwindcss/postcss) compiles here exactly as it does under Vite dev.
echo "🔨 Building with Parcel..."
pnpm exec parcel build index.html --dist-dir dist --no-source-maps

# Inline everything (JS, CSS, assets) into a single HTML file
echo "🎯 Inlining all assets into single HTML file..."
pnpm exec html-inline dist/index.html > bundle.html

# Self-containment guardrails — claude.ai artifacts run under a strict CSP that
# blocks ALL external requests. Warn loudly if anything escaped the bundle.
echo "🔎 Verifying self-containment (no external references)..."
# Catch both element attributes (src/href) and CSS url()/@import — the latter is
# the usual way an external font or image sneaks past the bundler.
if grep -qiE '(src|href)="https?://|url\(["'"'"']?https?://' bundle.html; then
  echo "⚠️  WARNING: bundle.html references external URLs. These will be BLOCKED"
  echo "   by the claude.ai artifact CSP. Embed fonts/images/scripts as data: URIs."
  grep -oiE '(src|href)="https?://[^"]*"|url\(["'"'"']?https?://[^)]*' bundle.html | sort -u | head
fi
if ! grep -q '<script' bundle.html; then
  echo "⚠️  WARNING: No inline <script> found — the bundle may not have inlined JS."
fi

# Get file size
FILE_SIZE=$(du -h bundle.html | cut -f1)

echo ""
echo "✅ Bundle complete!"
echo "📄 Output: bundle.html ($FILE_SIZE)"
echo ""
echo "This single HTML file is a self-contained artifact for claude.ai conversations."
echo "To test locally: open bundle.html in your browser"
