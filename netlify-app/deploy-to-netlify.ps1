# Netlify Deployment Helper Script
# This script helps you prepare your project for Netlify deployment

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Netlify Deployment Helper" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if git is installed
try {
    $gitVersion = git --version
    Write-Host "✓ Git is installed: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Git is not installed. Please install Git first." -ForegroundColor Red
    Write-Host "Download from: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Choose deployment method:" -ForegroundColor Yellow
Write-Host "1. Prepare for Git deployment (Recommended)" -ForegroundColor White
Write-Host "2. Install Netlify CLI and deploy" -ForegroundColor White
Write-Host "3. Show manual instructions" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Enter your choice (1-3)"

switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "Preparing for Git deployment..." -ForegroundColor Cyan
        
        # Initialize git if not already initialized
        if (-not (Test-Path .git)) {
            Write-Host "Initializing Git repository..." -ForegroundColor Yellow
            git init
            Write-Host "✓ Git repository initialized" -ForegroundColor Green
        } else {
            Write-Host "✓ Git repository already exists" -ForegroundColor Green
        }
        
        # Add all files
        Write-Host "Adding files to Git..." -ForegroundColor Yellow
        git add .
        
        # Check if there are changes to commit
        $status = git status --porcelain
        if ($status) {
            git commit -m "Initial commit - Netlify redirect app"
            Write-Host "✓ Files committed" -ForegroundColor Green
        } else {
            Write-Host "✓ No new changes to commit" -ForegroundColor Green
        }
        
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host "Next Steps:" -ForegroundColor Cyan
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "1. Create a repository on GitHub/GitLab/Bitbucket" -ForegroundColor White
        Write-Host "2. Run these commands:" -ForegroundColor White
        Write-Host "   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git" -ForegroundColor Yellow
        Write-Host "   git branch -M main" -ForegroundColor Yellow
        Write-Host "   git push -u origin main" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "3. Go to https://app.netlify.com" -ForegroundColor White
        Write-Host "4. Click 'New site from Git'" -ForegroundColor White
        Write-Host "5. Select your repository" -ForegroundColor White
        Write-Host "6. Build settings:" -ForegroundColor White
        Write-Host "   - Build command: npm run build" -ForegroundColor Yellow
        Write-Host "   - Publish directory: dist" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "7. After deployment, set environment variables:" -ForegroundColor White
        Write-Host "   - REDIRECT_URL" -ForegroundColor Yellow
        Write-Host "   - TELEGRAM_BOT_TOKEN" -ForegroundColor Yellow
        Write-Host "   - TELEGRAM_CHAT_ID" -ForegroundColor Yellow
        Write-Host ""
    }
    "2" {
        Write-Host ""
        Write-Host "Installing Netlify CLI..." -ForegroundColor Cyan
        
        # Check if Netlify CLI is installed
        try {
            $netlifyVersion = netlify --version
            Write-Host "✓ Netlify CLI is already installed: $netlifyVersion" -ForegroundColor Green
        } catch {
            Write-Host "Installing Netlify CLI globally..." -ForegroundColor Yellow
            npm install -g netlify-cli
            Write-Host "✓ Netlify CLI installed" -ForegroundColor Green
        }
        
        Write-Host ""
        Write-Host "Logging in to Netlify..." -ForegroundColor Yellow
        netlify login
        
        Write-Host ""
        Write-Host "Initializing Netlify site..." -ForegroundColor Yellow
        netlify init
        
        Write-Host ""
        Write-Host "Setting environment variables..." -ForegroundColor Yellow
        Write-Host "Please enter your values:" -ForegroundColor White
        
        $redirectUrl = Read-Host "REDIRECT_URL"
        $botToken = Read-Host "TELEGRAM_BOT_TOKEN"
        $chatId = Read-Host "TELEGRAM_CHAT_ID"
        
        netlify env:set REDIRECT_URL $redirectUrl
        netlify env:set TELEGRAM_BOT_TOKEN $botToken
        netlify env:set TELEGRAM_CHAT_ID $chatId
        
        Write-Host ""
        Write-Host "Deploying to production..." -ForegroundColor Yellow
        netlify deploy --prod
        
        Write-Host ""
        Write-Host "✓ Deployment complete!" -ForegroundColor Green
    }
    "3" {
        Write-Host ""
        Write-Host "Opening DEPLOY.md file..." -ForegroundColor Cyan
        if (Test-Path "DEPLOY.md") {
            notepad DEPLOY.md
        } else {
            Write-Host "DEPLOY.md not found. Please check the README.md for instructions." -ForegroundColor Yellow
        }
    }
    default {
        Write-Host "Invalid choice. Please run the script again." -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
