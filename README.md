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

3. **Configure OpenAI API (Optional)**
   - Get an OpenAI API key from [OpenAI Platform](https://platform.openai.com/)
   - Replace `'your-openai-api-key-here'` in `lib/main.dart` with your actual API key
   - If no API key is provided, the app will use fallback responses

4. **Run the app**
   ```bash
   flutter run
   ```

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
- **Max Tokens**: 150
- **Temperature**: 0.7
- **System Prompt**: "You are a kind and emotionally supportive friend. Provide empathetic, comforting responses to help people feel better. Keep responses warm, understanding, and encouraging."

### Fallback Responses
If the API is unavailable or no API key is provided, the app uses predefined empathetic responses to ensure users always receive support.

## Emergency Resources

The app includes access to:
- **National Suicide Prevention Lifeline**: 988
- **Crisis Text Line**: Text HOME to 741741
- **Emergency Services**: 911

## Local Storage

The app uses SharedPreferences for local data storage:
- Mood entries with timestamps and notes
- Chat message history
- User preferences

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

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
