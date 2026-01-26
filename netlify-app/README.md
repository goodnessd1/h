# Netlify Redirect App with Telegram Notifications

A beautiful loading page that redirects visitors to a configured URL and sends Telegram notifications with visitor IP addresses.

## Features

- ✨ Beautiful loading animation
- 🔄 Automatic redirect to configurable URL
- 📱 Telegram notifications with visitor IP addresses
- ⚙️ Environment variable configuration
- 🚀 Optimized for Netlify deployment

## Setup

### 1. Install Dependencies

```bash
npm install
```

### 2. Configure Environment Variables

You need to set up the following environment variables in Netlify:

#### Required Environment Variables:

1. **REDIRECT_URL** - The URL where visitors will be redirected
   - Example: `https://example.com` or `https://yourwebsite.com`

2. **TELEGRAM_BOT_TOKEN** - Your Telegram bot token
   - Get it from [@BotFather](https://t.me/botfather) on Telegram
   - Example: `123456789:ABCdefGHIjklMNOpqrsTUVwxyz`

3. **TELEGRAM_CHAT_ID** - Your Telegram chat ID where notifications will be sent
   - Get it by messaging [@userinfobot](https://t.me/userinfobot) on Telegram
   - Example: `123456789`

### 3. Setting Environment Variables in Netlify

#### Via Netlify Dashboard:

1. Go to your site in [Netlify Dashboard](https://app.netlify.com)
2. Navigate to **Site settings** → **Environment variables**
3. Click **Add variable** for each variable:
   - Key: `REDIRECT_URL`, Value: `https://your-redirect-url.com`
   - Key: `TELEGRAM_BOT_TOKEN`, Value: `your-bot-token`
   - Key: `TELEGRAM_CHAT_ID`, Value: `your-chat-id`
4. Click **Save**

#### Via Netlify CLI:

```bash
netlify env:set REDIRECT_URL "https://your-redirect-url.com"
netlify env:set TELEGRAM_BOT_TOKEN "your-bot-token"
netlify env:set TELEGRAM_CHAT_ID "your-chat-id"
```

### 4. Creating a Telegram Bot

1. Open Telegram and search for [@BotFather](https://t.me/botfather)
2. Send `/newbot` command
3. Follow the instructions to name your bot
4. Copy the bot token provided
5. Start a chat with your bot (click "Start" button)
6. Get your chat ID by messaging [@userinfobot](https://t.me/userinfobot)

## Development

### Local Development

Run the development server:

```bash
npm run dev
```

The app will be available at `http://localhost:5173`

**Note:** Netlify Functions work differently locally. For local testing:
- Install Netlify CLI: `npm install -g netlify-cli`
- Run: `netlify dev` (this will start both the app and functions)

### Build

Create a production build:

```bash
npm run build
```

### Preview

Preview the production build:

```bash
npm run preview
```

## Deploy to Netlify

### Option 1: Deploy via Netlify CLI

1. Install Netlify CLI:
   ```bash
   npm install -g netlify-cli
   ```

2. Login to Netlify:
   ```bash
   netlify login
   ```

3. Deploy:
   ```bash
   netlify deploy --prod
   ```

### Option 2: Deploy via Git

1. Push your code to GitHub, GitLab, or Bitbucket
2. Go to [Netlify](https://app.netlify.com)
3. Click "New site from Git"
4. Select your repository
5. Configure build settings:
   - Build command: `npm run build`
   - Publish directory: `dist`
6. Set environment variables (see step 3 above)
7. Click "Deploy site"

### Option 3: Drag and Drop

1. Build the project:
   ```bash
   npm run build
   ```
2. Go to [Netlify Drop](https://app.netlify.com/drop)
3. Drag and drop the `dist` folder
4. **Important:** Set environment variables in the dashboard after deployment

## How It Works

1. Visitor lands on your page
2. A beautiful loading animation is displayed
3. The app calls a Netlify Function to:
   - Get the visitor's IP address
   - Send a Telegram notification with redirect info and IP
   - Get the redirect URL from environment variables
4. After 2 seconds, the visitor is automatically redirected

## Project Structure

```
netlify-app/
├── netlify/
│   └── functions/
│       ├── notify.js      # Sends Telegram notification with IP
│       └── get-config.js  # Returns redirect URL
├── src/
│   ├── App.jsx            # Main app with loading and redirect
│   ├── App.css            # Loading animation styles
│   ├── main.jsx           # Entry point
│   └── index.css          # Global styles
├── index.html             # HTML template
├── vite.config.js         # Vite configuration
├── netlify.toml           # Netlify configuration
└── package.json           # Dependencies
```

## Technologies

- **React** - UI library
- **Vite** - Build tool and dev server
- **Netlify Functions** - Serverless functions for Telegram API
- **Telegram Bot API** - For sending notifications

## Troubleshooting

### Telegram notifications not working?

1. Verify your bot token is correct
2. Make sure you've started a chat with your bot
3. Verify your chat ID is correct
4. Check Netlify Function logs in the dashboard

### Redirect not working?

1. Verify `REDIRECT_URL` environment variable is set
2. Make sure the URL includes `https://` or `http://`
3. Check browser console for errors

### Functions not working locally?

- Use `netlify dev` instead of `npm run dev` to test functions locally
- Functions require Netlify CLI to run locally

Enjoy your redirect app! 🎉
