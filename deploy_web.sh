#!/bin/zsh

# Clean previous builds
echo "Cleaning previous builds..."
flutter clean

# Get dependencies
echo "Getting dependencies..."
flutter pub get

# Build web app with HTML renderer (faster initial load)
echo "Building web app with HTML renderer..."
# For Flutter 3.29+ we use FLUTTER_WEB_RENDERER environment variable instead of --web-renderer
export FLUTTER_WEB_RENDERER=html
# Add optimization flags for smaller build size
flutter build web --release --dart-define=Dart2jsOptimization=O4 --no-tree-shake-icons --pwa-strategy=none

# Optimize main.dart.js with compression
echo "Optimizing JS bundle..."
# Gzip compression
gzip -9 -c build/web/main.dart.js > build/web/main.dart.js.gz
# Brotli compression (if available) - even better than gzip
if command -v brotli &> /dev/null; then
  echo "Creating Brotli compressed version..."
  brotli -9 -c build/web/main.dart.js > build/web/main.dart.js.br
fi

# Check and update firebase.json to ensure proper caching
echo "Ensuring proper caching configuration..."
# Make sure the firebase configuration has the necessary settings
if ! grep -q '"max-age=31536000"' firebase.json; then
  echo "Warning: firebase.json may not have proper caching configurations"
fi

# Add preconnect hint to index.html for faster loading
if ! grep -q "preconnect" build/web/index.html; then
  echo "Adding preconnect hints to index.html..."
  sed -i '' 's/<meta charset="UTF-8">/<meta charset="UTF-8">\n  <link rel="preconnect" href="https:\/\/fonts.googleapis.com">\n  <link rel="preconnect" href="https:\/\/fonts.gstatic.com" crossorigin>/' build/web/index.html
fi

# Deploy to Firebase
echo "Deploying to Firebase..."
firebase deploy --only hosting

echo "Deployment complete! Your app should load much faster now."
echo "For best performance, consider visiting the deployed URL in Chrome, then run a Lighthouse audit to identify any remaining issues."
