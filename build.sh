#!/bin/bash

# Build script for Toledo Tour
echo "🏗️  Building Toledo Tour for Firebase..."

# Clean and build
flutter clean
flutter build web --release

# Copy essential files for AdSense and SEO
echo "📋 Copying ads.txt and sitemap.xml..."
cp web/ads.txt build/web/ads.txt
cp web/sitemap.xml build/web/sitemap.xml

# Verify files are copied
echo "✅ Build complete! Files in build/web:"
ls -la build/web/ | grep -E "(ads\.txt|sitemap\.xml)"

echo "🚀 Ready to deploy to Firebase!"
echo "Run: firebase deploy"
