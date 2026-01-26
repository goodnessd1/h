# Netlify Deployment Guide

## Quick Deployment Options

### Option 1: Deploy via Git (Recommended - Easiest)

This is the best method because Netlify will automatically build your site.

1. **Create a GitHub/GitLab/Bitbucket repository**
   - Go to GitHub.com and create a new repository
   - Don't initialize with README (we already have files)

2. **Push your code to GitHub**
   ```bash
   cd C:\Users\dimejigoodness\Desktop\netlify-app
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
   git push -u origin main
   ```

3. **Connect to Netlify**
   - Go to [app.netlify.com](https://app.netlify.com)
   - Click "New site from Git"
   - Choose your Git provider (GitHub/GitLab/Bitbucket)
   - Select your repository
   - Configure build settings:
     - **Build command:** `npm run build`
     - **Publish directory:** `dist`
   - Click "Deploy site"

4. **Set Environment Variables**
   - After deployment, go to Site settings → Environment variables
   - Add these variables:
     - `REDIRECT_URL` = Your redirect URL (e.g., `https://example.com`)
     - `TELEGRAM_BOT_TOKEN` = Your Telegram bot token
     - `TELEGRAM_CHAT_ID` = Your Telegram chat ID
   - Click "Save" and redeploy

### Option 2: Deploy via Netlify CLI

1. **Install Netlify CLI globally**
   ```bash
   npm install -g netlify-cli
   ```

2. **Login to Netlify**
   ```bash
   netlify login
   ```

3. **Initialize and deploy**
   ```bash
   cd C:\Users\dimejigoodness\Desktop\netlify-app
   netlify init
   ```
   - Choose "Create & configure a new site"
   - Follow the prompts
   - Build command: `npm run build`
   - Publish directory: `dist`

4. **Set environment variables**
   ```bash
   netlify env:set REDIRECT_URL "https://your-url.com"
   netlify env:set TELEGRAM_BOT_TOKEN "your-bot-token"
   netlify env:set TELEGRAM_CHAT_ID "your-chat-id"
   ```

5. **Deploy**
   ```bash
   netlify deploy --prod
   ```

### Option 3: Drag and Drop (Manual Build Required)

1. **Build the project locally first**
   ```bash
   cd C:\Users\dimejigoodness\Desktop\netlify-app
   npm install
   npm run build
   ```

2. **Upload to Netlify**
   - Go to [app.netlify.com/drop](https://app.netlify.com/drop)
   - Drag and drop the `dist` folder
   - **Important:** After deployment, set environment variables in Site settings

3. **Set Environment Variables**
   - Go to Site settings → Environment variables
   - Add: `REDIRECT_URL`, `TELEGRAM_BOT_TOKEN`, `TELEGRAM_CHAT_ID`
   - Redeploy after setting variables

## Important Notes

- **Environment Variables are REQUIRED** for the app to work properly
- The `dist` folder contains only the built frontend - Netlify Functions need to be deployed via Git or CLI
- For drag-and-drop, you'll need to manually upload the `netlify/functions` folder or use Git/CLI

## Recommended: Use Git Deployment

Git deployment is recommended because:
- ✅ Automatic builds on every push
- ✅ Netlify Functions work automatically
- ✅ Easy to update
- ✅ Version control

## Troubleshooting

If npm install fails:
- Try running as Administrator
- Or use Git deployment (Netlify will build it for you)

If functions don't work:
- Make sure you deployed via Git or CLI (not drag-and-drop)
- Check that environment variables are set
- Check Netlify Function logs in the dashboard
