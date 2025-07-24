#!/bin/bash

# Memorix AI Documentation Deployment Script

echo "🚀 Building Memorix AI Documentation..."

# Check if mkdocs is installed
if ! command -v mkdocs &> /dev/null; then
    echo "❌ MkDocs is not installed. Installing dependencies..."
    pip install -r requirements.txt
fi

# Build the documentation
echo "📚 Building documentation..."
mkdocs build

if [ $? -eq 0 ]; then
    echo "✅ Documentation built successfully!"
    
    # Ask user if they want to deploy
    read -p "🌐 Deploy to GitHub Pages? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🚀 Deploying to GitHub Pages..."
        mkdocs gh-deploy
        
        if [ $? -eq 0 ]; then
            echo "✅ Documentation deployed successfully!"
            echo "🌍 Your site will be available at: https://memorix-ai.github.io/memorix-docs/"
        else
            echo "❌ Deployment failed!"
        fi
    else
        echo "📁 Documentation built in 'site/' directory"
        echo "🌐 To deploy manually, run: mkdocs gh-deploy"
    fi
else
    echo "❌ Build failed!"
    exit 1
fi 