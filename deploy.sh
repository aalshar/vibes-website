#!/bin/bash

echo "🚀 Starting deployment to GitHub Pages..."

# Build the Flutter web app
echo "📦 Building Flutter web app..."
flutter build web --release --base-href "/Vibes_Website/"

# Check if build was successful
if [ $? -ne 0 ]; then
    echo "❌ Build failed! Please fix errors and try again."
    exit 1
fi

echo "✅ Build completed successfully!"

# Navigate to build directory
cd build/web

# Initialize git in build directory
echo "🔧 Initializing git..."
git init
git add -A
git commit -m "Deploy to GitHub Pages - $(date +'%Y-%m-%d %H:%M:%S')"

# Create gh-pages branch
git branch -M gh-pages

# Push to GitHub (replace with your repository URL)
echo "📤 Pushing to GitHub..."
git push -f https://github.com/aalsar/Vibes_Website.git gh-pages:gh-pages

if [ $? -eq 0 ]; then
    echo "✅ Deployment successful!"
    echo "🌐 Your site will be available at: https://aalsar.github.io/Vibes_Website/"
    echo "⏳ Please wait 1-2 minutes for GitHub Pages to update."
else
    echo "❌ Deployment failed! Please check your git credentials and repository URL."
fi

# Return to project root
cd ../..

echo "🎉 Done!"