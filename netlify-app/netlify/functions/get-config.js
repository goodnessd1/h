exports.handler = async (event, context) => {
  // Return redirect URL (we don't expose sensitive tokens)
  const redirectUrl = process.env.REDIRECT_URL || 'https://example.com';

  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': 'Content-Type',
    },
    body: JSON.stringify({ 
      redirectUrl: redirectUrl
    })
  };
};
