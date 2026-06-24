#!/bin/bash

# Adapted from Anthropic's "web-artifacts-builder" skill (Apache 2.0; see LICENSE.txt).
# Modernized to Node 20+, Tailwind CSS v4 (CSS-first, OKLCH tokens), React 19, the
# unified radix-ui package, and 56 native-v4 shadcn/ui components. Changes by William Hayes.

# Exit on error
set -e

# Detect Node version
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)

echo "🔍 Detected Node.js version: $NODE_VERSION"

# Tailwind v4 and modern Vite both require Node 20+
if [ "$NODE_VERSION" -lt 20 ]; then
  echo "❌ Error: Node.js 20 or higher is required (Tailwind CSS v4 + Vite)"
  echo "   Current version: $(node -v)"
  exit 1
fi
echo "✅ Node $NODE_VERSION meets the Node 20+ baseline"

# Detect OS and set sed syntax
if [[ "$OSTYPE" == "darwin"* ]]; then
  SED_INPLACE="sed -i ''"
else
  SED_INPLACE="sed -i"
fi

# Check if pnpm is installed
if ! command -v pnpm &> /dev/null; then
  echo "📦 pnpm not found. Installing pnpm..."
  npm install -g pnpm
fi

# Check if project name is provided
if [ -z "$1" ]; then
  echo "❌ Usage: bash init-artifact.sh <project-name>"
  exit 1
fi

PROJECT_NAME="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPONENTS_TARBALL="$SCRIPT_DIR/shadcn-components.tar.gz"

# Check if components tarball exists
if [ ! -f "$COMPONENTS_TARBALL" ]; then
  echo "❌ Error: shadcn-components.tar.gz not found in script directory"
  echo "   Expected location: $COMPONENTS_TARBALL"
  exit 1
fi

echo "🚀 Creating new React + Vite project: $PROJECT_NAME"

# Create new Vite project (latest create-vite, React + TypeScript template)
pnpm create vite "$PROJECT_NAME" --template react-ts

# Navigate into project directory
cd "$PROJECT_NAME"

echo "🧹 Cleaning up Vite template..."
# Remove the template favicon <link> (filename varies across create-vite versions:
# vite.svg, favicon.svg, ...). Leaving it makes the bundler fail to resolve the asset.
$SED_INPLACE '/<link rel="icon"/d' index.html
$SED_INPLACE 's/<title>.*<\/title>/<title>'"$PROJECT_NAME"'<\/title>/' index.html

echo "📦 Installing base dependencies..."
pnpm install

echo "📦 Installing Tailwind CSS v4 and dependencies..."
# Tailwind v4 ships its own PostCSS plugin; autoprefixer + postcss-import are built in.
# tw-animate-css is the v4 replacement for tailwindcss-animate.
pnpm install -D tailwindcss@4 @tailwindcss/postcss tw-animate-css @types/node
pnpm install class-variance-authority clsx tailwind-merge lucide-react next-themes

echo "⚙️  Creating PostCSS configuration (works for both Vite dev and Parcel bundle)..."
cat > postcss.config.js << 'EOF'
export default {
  plugins: {
    "@tailwindcss/postcss": {},
  },
}
EOF

# Tailwind v4 is CSS-first: no tailwind.config.js. Theme, tokens, dark mode,
# and custom animations all live in index.css.
echo "🎨 Writing Tailwind v4 CSS-first theme (OKLCH tokens + shadcn bridge)..."
cat > src/index.css << 'EOF'
@import "tailwindcss";
@import "tw-animate-css";

/* Enable class-based dark mode: `dark` variant applies under a `.dark` ancestor. */
@custom-variant dark (&:is(.dark *));

/* Bridge shadcn semantic tokens to Tailwind v4 color/radius/animation utilities.
   `inline` makes utilities reference var(--token) at use-site so the .dark
   overrides below actually flip at runtime. */
@theme inline {
  --color-background: var(--background);
  --color-foreground: var(--foreground);
  --color-card: var(--card);
  --color-card-foreground: var(--card-foreground);
  --color-popover: var(--popover);
  --color-popover-foreground: var(--popover-foreground);
  --color-primary: var(--primary);
  --color-primary-foreground: var(--primary-foreground);
  --color-secondary: var(--secondary);
  --color-secondary-foreground: var(--secondary-foreground);
  --color-muted: var(--muted);
  --color-muted-foreground: var(--muted-foreground);
  --color-accent: var(--accent);
  --color-accent-foreground: var(--accent-foreground);
  --color-destructive: var(--destructive);
  --color-destructive-foreground: var(--destructive-foreground);
  --color-border: var(--border);
  --color-input: var(--input);
  --color-ring: var(--ring);
  --color-chart-1: var(--chart-1);
  --color-chart-2: var(--chart-2);
  --color-chart-3: var(--chart-3);
  --color-chart-4: var(--chart-4);
  --color-chart-5: var(--chart-5);
  --color-sidebar: var(--sidebar);
  --color-sidebar-foreground: var(--sidebar-foreground);
  --color-sidebar-primary: var(--sidebar-primary);
  --color-sidebar-primary-foreground: var(--sidebar-primary-foreground);
  --color-sidebar-accent: var(--sidebar-accent);
  --color-sidebar-accent-foreground: var(--sidebar-accent-foreground);
  --color-sidebar-border: var(--sidebar-border);
  --color-sidebar-ring: var(--sidebar-ring);

  --radius-sm: calc(var(--radius) - 4px);
  --radius-md: calc(var(--radius) - 2px);
  --radius-lg: var(--radius);
  --radius-xl: calc(var(--radius) + 4px);

  --animate-accordion-down: accordion-down 0.2s ease-out;
  --animate-accordion-up: accordion-up 0.2s ease-out;

  @keyframes accordion-down {
    from { height: 0; }
    to { height: var(--radix-accordion-content-height); }
  }
  @keyframes accordion-up {
    from { height: var(--radix-accordion-content-height); }
    to { height: 0; }
  }
}

:root {
  --radius: 0.5rem;
  --background: oklch(1 0 0);
  --foreground: oklch(0.145 0 0);
  --card: oklch(1 0 0);
  --card-foreground: oklch(0.145 0 0);
  --popover: oklch(1 0 0);
  --popover-foreground: oklch(0.145 0 0);
  --primary: oklch(0.205 0 0);
  --primary-foreground: oklch(0.985 0 0);
  --secondary: oklch(0.97 0 0);
  --secondary-foreground: oklch(0.205 0 0);
  --muted: oklch(0.97 0 0);
  --muted-foreground: oklch(0.556 0 0);
  --accent: oklch(0.97 0 0);
  --accent-foreground: oklch(0.205 0 0);
  --destructive: oklch(0.577 0.245 27.325);
  --destructive-foreground: oklch(0.985 0 0);
  --border: oklch(0.922 0 0);
  --input: oklch(0.922 0 0);
  --ring: oklch(0.708 0 0);
  --chart-1: oklch(0.87 0 0);
  --chart-2: oklch(0.556 0 0);
  --chart-3: oklch(0.439 0 0);
  --chart-4: oklch(0.371 0 0);
  --chart-5: oklch(0.269 0 0);
  --sidebar: hsl(0 0% 98%);
  --sidebar-foreground: hsl(240 5.3% 26.1%);
  --sidebar-primary: hsl(240 5.9% 10%);
  --sidebar-primary-foreground: hsl(0 0% 98%);
  --sidebar-accent: hsl(240 4.8% 95.9%);
  --sidebar-accent-foreground: hsl(240 5.9% 10%);
  --sidebar-border: hsl(220 13% 91%);
  --sidebar-ring: hsl(217.2 91.2% 59.8%);
}

.dark {
  --background: oklch(0.145 0 0);
  --foreground: oklch(0.985 0 0);
  --card: oklch(0.205 0 0);
  --card-foreground: oklch(0.985 0 0);
  --popover: oklch(0.205 0 0);
  --popover-foreground: oklch(0.985 0 0);
  --primary: oklch(0.922 0 0);
  --primary-foreground: oklch(0.205 0 0);
  --secondary: oklch(0.269 0 0);
  --secondary-foreground: oklch(0.985 0 0);
  --muted: oklch(0.269 0 0);
  --muted-foreground: oklch(0.708 0 0);
  --accent: oklch(0.269 0 0);
  --accent-foreground: oklch(0.985 0 0);
  --destructive: oklch(0.704 0.191 22.216);
  --destructive-foreground: oklch(0.985 0 0);
  --border: oklch(1 0 0 / 10%);
  --input: oklch(1 0 0 / 15%);
  --ring: oklch(0.556 0 0);
  --chart-1: oklch(0.87 0 0);
  --chart-2: oklch(0.556 0 0);
  --chart-3: oklch(0.439 0 0);
  --chart-4: oklch(0.371 0 0);
  --chart-5: oklch(0.269 0 0);
  --sidebar: hsl(240 5.9% 10%);
  --sidebar-foreground: hsl(240 4.8% 95.9%);
  --sidebar-primary: hsl(224.3 76.3% 48%);
  --sidebar-primary-foreground: hsl(0 0% 100%);
  --sidebar-accent: hsl(240 3.7% 15.9%);
  --sidebar-accent-foreground: hsl(240 4.8% 95.9%);
  --sidebar-border: hsl(240 3.7% 15.9%);
  --sidebar-ring: hsl(217.2 91.2% 59.8%);
}

@layer base {
  * {
    @apply border-border outline-ring/50;
  }
  body {
    @apply bg-background text-foreground;
  }
}
EOF

# Add path aliases to tsconfig.json
echo "🔧 Adding path aliases to tsconfig.json..."
node -e "
const fs = require('fs');
const config = JSON.parse(fs.readFileSync('tsconfig.json', 'utf8'));
config.compilerOptions = config.compilerOptions || {};
// No baseUrl: it's deprecated in current TypeScript (TS5101) and 'paths' resolves
// relative to the tsconfig without it since TS 5.4.
config.compilerOptions.paths = { '@/*': ['./src/*'] };
fs.writeFileSync('tsconfig.json', JSON.stringify(config, null, 2));
"

# Add path aliases to tsconfig.app.json
echo "🔧 Adding path aliases to tsconfig.app.json..."
node -e "
const fs = require('fs');
const path = 'tsconfig.app.json';
const content = fs.readFileSync(path, 'utf8');
// Remove comments manually
const lines = content.split('\n').filter(line => !line.trim().startsWith('//'));
const jsonContent = lines.join('\n');
const config = JSON.parse(jsonContent.replace(/\/\*[\s\S]*?\*\//g, '').replace(/,(\s*[}\]])/g, '\$1'));
config.compilerOptions = config.compilerOptions || {};
// No baseUrl (deprecated, TS5101); 'paths' alone resolves the @/ alias in TS 5.4+.
config.compilerOptions.paths = { '@/*': ['./src/*'] };
fs.writeFileSync(path, JSON.stringify(config, null, 2));
"

# Update vite.config.ts (Tailwind v4 runs via PostCSS, so no Vite plugin needed here)
echo "⚙️  Updating Vite configuration..."
cat > vite.config.ts << 'EOF'
import path from "path";
import react from "@vitejs/plugin-react";
import { defineConfig } from "vite";

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
});
EOF

# Install all shadcn/ui dependencies.
# Tailwind v4 / new-york components import from the unified `radix-ui` package
# (not the individual @radix-ui/react-* packages) plus @base-ui/react.
echo "📦 Installing shadcn/ui dependencies..."
pnpm install radix-ui @base-ui/react lucide-react
# react-day-picker (calendar) and react-resizable-panels (resizable) had breaking
# major bumps; pin to the versions the current shadcn components target. recharts 3
# powers the chart component.
pnpm install recharts@^3 input-otp sonner cmdk vaul embla-carousel-react \
  react-day-picker@^10 react-resizable-panels@^4 date-fns \
  react-hook-form @hookform/resolvers zod

# Extract shadcn components from tarball
echo "📦 Extracting shadcn/ui components..."
tar -xzf "$COMPONENTS_TARBALL" -C src/

# Create components.json for reference (Tailwind v4 / CSS-first)
echo "📝 Creating components.json config..."
cat > components.json << 'EOF'
{
  "$schema": "https://ui.shadcn.com/schema.json",
  "style": "new-york",
  "rsc": false,
  "tsx": true,
  "tailwind": {
    "config": "",
    "css": "src/index.css",
    "baseColor": "neutral",
    "cssVariables": true,
    "prefix": ""
  },
  "aliases": {
    "components": "@/components",
    "utils": "@/lib/utils",
    "ui": "@/components/ui",
    "lib": "@/lib",
    "hooks": "@/hooks"
  }
}
EOF

echo "✅ Setup complete! Tailwind CSS v4 + shadcn/ui are ready."
echo ""
echo "📦 Included components (56 total, native Tailwind v4 / new-york):"
echo "  - accordion, alert, alert-dialog, aspect-ratio, avatar, badge"
echo "  - breadcrumb, button, button-group, calendar, card, carousel, chart"
echo "  - checkbox, collapsible, combobox, command, context-menu, dialog"
echo "  - direction, drawer, dropdown-menu, empty, field, form, hover-card"
echo "  - input, input-group, input-otp, item, kbd, label, menubar"
echo "  - native-select, navigation-menu, pagination, popover, progress"
echo "  - radio-group, resizable, scroll-area, select, separator, sheet"
echo "  - sidebar, skeleton, slider, sonner, spinner, switch, table, tabs"
echo "  - textarea, toggle, toggle-group, tooltip"
echo ""
echo "To start developing:"
echo "  cd $PROJECT_NAME"
echo "  pnpm dev"
echo ""
echo "📚 Import components like:"
echo "  import { Button } from '@/components/ui/button'"
echo "  import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card'"
echo "  import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog'"
