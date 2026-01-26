# Drag-and-Drop Deployment Guide

## Quick Steps

### Option 1: Use the Preparation Script (Easiest)

1. **Run the preparation script:**
   ```powershell
   cd C:\Users\dimejigoodness\Desktop\netlify-app
   .\prepare-for-drag-drop.ps1
   ```

2. **This will:**
   - Install dependencies
   - Build the project
   - Create a `netlify-deploy` folder ready for upload
   - Create a `netlify-app-deploy.zip` file

3. **Deploy to Netlify:**
   - Go to [app.netlify.com/drop](https://app.netlify.com/drop)
   - Drag and drop the `netlify-deploy` folder OR the `netlify-app-deploy.zip` file

4. **Set Environment Variables:**
   - After deployment, go to **Site settings** → **Environment variables**
   - Add these variables:
     - `REDIRECT_URL` = Your redirect URL
     - `TELEGRAM_BOT_TOKEN` = Your Telegram bot token
     - `TELEGRAM_CHAT_ID` = Your Telegram chat ID
   - Click **Save** and **Redeploy**

### Option 2: Manual Preparation

1. **Build the project:**
   ```powershell
   cd C:\Users\dimejigoodness\Desktop\netlify-app
   npm install
   npm run build
   ```

2. **Create deployment package:**
   - Copy the `dist` folder contents
   - Copy the `netlify` folder (for functions)
   - Copy `netlify.toml` file
   - Put everything in a new folder (e.g., `netlify-deploy`)

3. **Deploy:**
   - Go to [app.netlify.com/drop](https://app.netlify.com/drop)
   - Drag and drop your deployment folder

## ⚠️ Important Limitations

### Netlify Functions with Drag-and-Drop

**Drag-and-drop deployment has limitations:**
- Netlify Functions may not work properly with drag-and-drop
- Functions need to be deployed via Git or Netlify CLI to work correctly
- The functions folder structure might not be recognized

### Recommended Solution

For full functionality (especially Netlify Functions), use **Git deployment** instead:

1. Push your code to GitHub/GitLab/Bitbucket
2. Connect to Netlify via Git
3. Netlify will automatically:
   - Build your project
   - Deploy functions correctly
   - Handle environment variables

See `DEPLOY.md` for Git deployment instructions.

## What Gets Deployed

When you drag and drop, you're deploying:
- ✅ Built React app (from `dist` folder)
- ⚠️ Netlify Functions (may not work with drag-and-drop)
- ✅ Configuration (netlify.toml)

## Troubleshooting

### Functions not working?
- Use Git deployment instead (see DEPLOY.md)
- Or use Netlify CLI deployment

### Build fails?
- Make sure Node.js is installed
- Try running `npm install` manually
- Check for error messages

### Environment variables not working?
- Make sure you set them in Netlify dashboard
- Redeploy after setting variables
- Check that variable names match exactly (case-sensitive)

## Alternative: Zip File Upload

You can also:
1. Run the preparation script to create `netlify-app-deploy.zip`
2. Upload the ZIP file to Netlify Drop
3. Netlify will extract and deploy it
