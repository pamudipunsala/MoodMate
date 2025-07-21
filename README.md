# MoodMate - Emotional Support App

MoodMate is a Flutter app designed to provide emotional support for people feeling sad, with AI-powered chat and simple emotional tracking. The app features a soothing UI, empathy-driven UX, and is built following Clean Architecture principles with BLoC for state management.

## Features

### 🏠 Home Screen
- Today's mood status display with emoji
- Quick access buttons for Check-In, Chat, Calm, and Help
- Daily inspirational quote
- Soft, calming UI theme

### 😊 Mood Check-In
- Emoji mood picker (😢 😐 😊)
- Optional text input for thoughts and feelings
- Local storage of mood entries
- Mood history display

### 💬 AI Chat
- GPT-3.5 powered emotional support chat
- Empathetic and comforting responses
- Message history with soft, rounded bubbles
- Loading animations during AI responses
- Offline fallback responses

### 🧘 Calm & Support
- Breathing exercise animation
- Positive affirmations
- Emergency resources and hotlines
- Crisis support information

## Architecture

The app follows Clean Architecture principles with the following structure:

```
lib/
├── core/
│   ├── constants/     # App constants and configuration
│   ├── config/        # API configuration
│   └── theme/         # App theme and styling
├── data/
│   ├── datasources/   # Data sources (local/remote)
│   ├── models/        # Data models
│   └── repositories/  # Repository implementations
├── domain/
│   ├── entities/      # Business entities
│   ├── repositories/  # Repository interfaces
│   └── usecases/      # Business logic use cases
└── presentation/
    ├── bloc/          # BLoC state management
    ├── pages/         # Screen pages
    └── widgets/       # Reusable widgets
```

## State Management

The app uses **BLoC (Business Logic Component)** pattern for state management:
- **MoodBloc**: Manages mood entries and check-ins
- **ChatBloc**: Handles chat messages and AI interactions
- **QuotesBloc**: Manages inspirational quotes

## Setup Instructions

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd MoodMate
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure OpenAI API (Required for AI Chat)**
   
   **Option 1: Direct Configuration**
   - Open `lib/core/config/api_config.dart`
   - Replace `'your-openai-api-key-here'` with your actual OpenAI API key
   - Get an API key from [OpenAI Platform](https://platform.openai.com/api-keys)
   
   **Option 2: Environment Variable (Recommended)**
   - Run the app with your API key as an environment variable:
   ```bash
   flutter run --dart-define=OPENAI_API_KEY=sk-your-actual-api-key-here
   ```
   
   **Option 3: Fallback Mode**
   - If no API key is configured, the app will use empathetic fallback responses
   - The chat will still work but won't use real AI responses

4. **Run the app**
   ```bash
   flutter run
   ```

### API Key Setup

To enable AI-powered chat responses:

1. **Get an OpenAI API Key:**
   - Visit [OpenAI Platform](https://platform.openai.com/)
   - Sign up or log in to your account
   - Go to "API Keys" section
   - Create a new API key
   - Copy the key (starts with `sk-`)

2. **Configure the API Key:**
   - **Method 1:** Edit `lib/core/config/api_config.dart` and replace the placeholder
   - **Method 2:** Use environment variable when running: `flutter run --dart-define=OPENAI_API_KEY=your-key`

3. **Test the Integration:**
   - Open the app and go to the Chat section
   - Send a message to test if AI responses are working
   - Check the console logs for any API errors

### Dependencies

The app uses the following key dependencies:

- **flutter_bloc**: State management
- **shared_preferences**: Local data storage
- **http**: API communication
- **url_launcher**: External links and phone calls
- **google_fonts**: Typography
- **uuid**: Unique ID generation

## Design System

### Colors
- **Primary**: Light Blue (#E8F4FD)
- **Secondary**: Light Lavender (#F3E5F5)
- **Accent**: Light Blush (#FFE5E5)
- **Background**: Very Light Gray (#FAFAFA)
- **Text Primary**: Dark Blue Gray (#2C3E50)
- **Text Secondary**: Gray (#7F8C8D)

### Typography
- **Font Family**: Nunito
- **Weights**: Light (300), Regular (400), Medium (500), Semi-Bold (600), Bold (700)

### Spacing
- **XS**: 4px
- **S**: 8px
- **M**: 16px
- **L**: 24px
- **XL**: 32px
- **XXL**: 48px

## API Configuration

### OpenAI Integration
The app integrates with OpenAI's GPT-3.5-turbo model for empathetic chat responses. The API configuration includes:

- **Model**: gpt-3.5-turbo
- **Max Tokens**: 200
- **Temperature**: 0.7
- **System Prompt**: Configured for emotional support and empathy

### Error Handling
The app includes robust error handling for API issues:
- **Invalid API Key**: Shows helpful error message
- **Rate Limiting**: Graceful fallback to offline responses
- **Network Issues**: Automatic fallback to local responses
- **API Errors**: Detailed logging for debugging

### Fallback Responses
When the API is unavailable, the app provides empathetic fallback responses that maintain the supportive tone of the conversation.

## Troubleshooting

### Chat Not Working
1. **Check API Key**: Ensure your OpenAI API key is properly configured
2. **Check Console Logs**: Look for API error messages in the debug console
3. **Test API Key**: Verify your API key works on the OpenAI platform
4. **Check Network**: Ensure you have internet connectivity

### Common Issues
- **"Invalid API key"**: Update your API key in the configuration
- **"Rate limit exceeded"**: Wait a few minutes and try again
- **"Network error"**: Check your internet connection
- **Empty responses**: The app will use fallback responses automatically

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you're experiencing emotional distress or having thoughts of self-harm, please reach out for help:

- **National Suicide Prevention Lifeline**: 988
- **Crisis Text Line**: Text HOME to 741741
- **Emergency Services**: 911

You are not alone, and there are people who care about you and want to help.

## Disclaimer

This app is designed to provide emotional support and is not a substitute for professional mental health care. If you're experiencing severe emotional distress, please contact a mental health professional or emergency services.
