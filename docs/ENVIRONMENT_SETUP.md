# Environment Configuration Guide

This document explains how to configure environment variables for the Dynamic Dashboard app.

## Overview

The app uses environment variables to securely store API keys and configuration settings. This approach provides several benefits:

- **Security**: API keys are not hardcoded in source code
- **Flexibility**: Easy to switch between development/production environments
- **Version Control Safety**: Sensitive data is not committed to repository

## Setup Instructions

### 1. Copy Environment Template

```bash
cp .env.example .env
```

### 2. Configure API Keys

Edit the `.env` file and replace the placeholder values with your actual API keys:

```env
# API Keys - Replace with your actual keys
OPENWEATHER_API_KEY=your_actual_openweather_key_here
NEWS_API_KEY=your_actual_news_api_key_here
FINNHUB_API_KEY=your_actual_finnhub_key_here
```

### 3. Get API Keys

#### OpenWeather API
1. Visit [https://openweathermap.org/api](https://openweathermap.org/api)
2. Sign up for a free account
3. Generate an API key
4. Copy the key to your `.env` file

#### News API
1. Visit [https://newsapi.org/](https://newsapi.org/)
2. Sign up for a developer account
3. Get your API key from the dashboard
4. Copy the key to your `.env` file

#### Finnhub API
1. Visit [https://finnhub.io/](https://finnhub.io/)
2. Create a free account
3. Get your API token
4. Copy the token to your `.env` file

## Environment Variables Reference

| Variable | Description | Required | Default |
|----------|-------------|----------|---------|
| `OPENWEATHER_API_KEY` | OpenWeather API key for weather data | Yes | - |
| `NEWS_API_KEY` | News API key for news articles | Yes | - |
| `FINNHUB_API_KEY` | Finnhub API key for stock prices | Yes | - |
| `OPENWEATHER_BASE_URL` | OpenWeather API base URL | No | https://api.openweathermap.org/data/2.5 |
| `NEWS_API_BASE_URL` | News API base URL | No | https://newsapi.org/v2 |
| `FINNHUB_WS_URL` | Finnhub WebSocket URL | No | wss://ws.finnhub.io |
| `APP_NAME` | Application name | No | Dynamic Dashboard |
| `APP_VERSION` | Application version | No | 1.0.0 |
| `DEBUG_MODE` | Enable debug features | No | false |

## Troubleshooting

### Common Issues

1. **"Missing required API keys" error**
   - Ensure your `.env` file exists in the project root
   - Check that all required API keys are configured
   - Verify there are no extra spaces or quotes around the values

2. **API calls failing**
   - Verify your API keys are valid and active
   - Check that you haven't exceeded rate limits
   - Ensure your API keys have the necessary permissions

3. **Environment variables not loading**
   - Make sure the `.env` file is in the project root directory
   - Run `flutter clean` and `flutter pub get`
   - Check that the `.env` file is listed in `pubspec.yaml` assets

### Debug Mode Features

When `DEBUG_MODE=true`, the app will show:
- API configuration status on the dashboard
- Detailed error messages
- Additional logging information

## Security Best Practices

1. **Never commit `.env` files** - They contain sensitive API keys
2. **Use different keys** for development and production
3. **Regularly rotate** your API keys
4. **Monitor usage** to detect unauthorized access
5. **Use minimal permissions** for each API key

## Production Deployment

For production deployment, you may want to use more secure methods:

- Environment variables in your CI/CD pipeline
- Secret management services (AWS Secrets Manager, etc.)
- Encrypted configuration files

## Development Team

When working with a team:
1. Each developer should have their own `.env` file
2. Share the `.env.example` file as a template
3. Document any new environment variables in this guide
4. Use consistent variable naming conventions