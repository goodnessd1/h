# Script to prepare netlify-app folder for drag-and-drop deployment
# This will build the project and create a deployment package

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Preparing for Netlify Drag-and-Drop" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if we're in the right directory
if (-not (Test-Path "package.json")) {
    Write-Host "✗ Error: package.json not found. Please run this script from the netlify-app folder." -ForegroundColor Red
    exit 1
}

Write-Host "Step 1: Installing dependencies..." -ForegroundColor Yellow
try {
    npm install
    Write-Host "✓ Dependencies installed" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to install dependencies. Trying to continue anyway..." -ForegroundColor Yellow
    Write-Host "Note: You may need to run 'npm install' manually" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Step 2: Building the project..." -ForegroundColor Yellow
try {
    npm run build
    Write-Host "✓ Project built successfully" -ForegroundColor Green
} catch {
    Write-Host "✗ Build failed. Please check the errors above." -ForegroundColor Red
    Write-Host "You can try building manually with: npm run build" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Step 3: Creating deployment package..." -ForegroundColor Yellow

# Create a deployment folder
$deployFolder = "netlify-deploy"
if (Test-Path $deployFolder) {
    Remove-Item -Recurse -Force $deployFolder
}
New-Item -ItemType Directory -Path $deployFolder | Out-Null

# Copy dist folder
if (Test-Path "dist") {
    Copy-Item -Recurse "dist\*" "$deployFolder\" -Force
    Write-Host "✓ Copied dist folder" -ForegroundColor Green
} else {
    Write-Host "✗ dist folder not found. Build may have failed." -ForegroundColor Red
    exit 1
}

# Copy netlify functions
if (Test-Path "netlify\functions") {
    New-Item -ItemType Directory -Path "$deployFolder\netlify\functions" -Force | Out-Null
    Copy-Item -Recurse "netlify\functions\*" "$deployFolder\netlify\functions\" -Force
    Write-Host "✓ Copied Netlify functions" -ForegroundColor Green
}

# Copy netlify.toml
if (Test-Path "netlify.toml") {
    Copy-Item "netlify.toml" "$deployFolder\" -Force
    Write-Host "✓ Copied netlify.toml" -ForegroundColor Green
}

# Create a zip file
Write-Host ""
Write-Host "Step 4: Creating ZIP file..." -ForegroundColor Yellow
$zipFile = "netlify-app-deploy.zip"
if (Test-Path $zipFile) {
    Remove-Item $zipFile -Force
}

# Use .NET compression (available in PowerShell)
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory($deployFolder, $zipFile)

Write-Host "✓ Created $zipFile" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Deployment Package Ready!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "IMPORTANT NOTES:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Drag-and-drop deployment has limitations:" -ForegroundColor White
Write-Host "   - Netlify Functions may not work properly" -ForegroundColor Yellow
Write-Host "   - Environment variables need to be set manually" -ForegroundColor Yellow
Write-Host ""
Write-Host "2. To deploy:" -ForegroundColor White
Write-Host "   - Go to: https://app.netlify.com/drop" -ForegroundColor Cyan
Write-Host "   - Drag the '$deployFolder' folder OR '$zipFile' file" -ForegroundColor Cyan
Write-Host ""
Write-Host "3. After deployment, set environment variables:" -ForegroundColor White
Write-Host "   - Go to Site settings → Environment variables" -ForegroundColor Cyan
Write-Host "   - Add: REDIRECT_URL, TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID" -ForegroundColor Cyan
Write-Host ""
Write-Host "4. RECOMMENDED: Use Git deployment instead for full functionality" -ForegroundColor Yellow
Write-Host "   - See DEPLOY.md for Git deployment instructions" -ForegroundColor Yellow
Write-Host ""
Write-Host "Files created:" -ForegroundColor White
Write-Host "  - $deployFolder (folder to drag)" -ForegroundColor Green
Write-Host "  - $zipFile (ZIP file to drag)" -ForegroundColor Green
Write-Host ""
