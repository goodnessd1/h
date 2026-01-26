exports.handler = async (event, context) => {
  // Get visitor IP address
  const ip = event.headers['x-forwarded-for'] || 
             event.headers['x-nf-client-connection-ip'] || 
             event.headers['client-ip'] ||
             'Unknown';

  // Get environment variables
  const telegramBotToken = process.env.TELEGRAM_BOT_TOKEN;
  const telegramChatId = process.env.TELEGRAM_CHAT_ID;
  const redirectUrl = process.env.REDIRECT_URL || 'https://example.com';

  // If Telegram credentials are not set, just return success
  if (!telegramBotToken || !telegramChatId) {
    return {
      statusCode: 200,
      body: JSON.stringify({ 
        message: 'Telegram notification skipped - credentials not configured',
        ip: ip,
        redirectUrl: redirectUrl
      })
    };
  }

  // Prepare Telegram message
  const message = `🔄 Redirect Notification\n\n` +
                  `Redirecting visitor to: ${redirectUrl}\n` +
                  `IP Address: ${ip}\n` +
                  `Time: ${new Date().toISOString()}`;

  // Send Telegram message
  try {
    const telegramUrl = `https://api.telegram.org/bot${telegramBotToken}/sendMessage`;
    
    const response = await fetch(telegramUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        chat_id: telegramChatId,
        text: message,
        parse_mode: 'HTML'
      })
    });

    const data = await response.json();

    if (!response.ok) {
      console.error('Telegram API error:', data);
      return {
        statusCode: 200,
        body: JSON.stringify({ 
          message: 'Failed to send Telegram notification',
          error: data.description,
          ip: ip,
          redirectUrl: redirectUrl
        })
      };
    }

    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'Content-Type',
      },
      body: JSON.stringify({ 
        success: true,
        message: 'Telegram notification sent',
        ip: ip,
        redirectUrl: redirectUrl
      })
    };
  } catch (error) {
    console.error('Error sending Telegram notification:', error);
    return {
      statusCode: 200,
      body: JSON.stringify({ 
        message: 'Error sending notification',
        error: error.message,
        ip: ip,
        redirectUrl: redirectUrl
      })
    };
  }
};
