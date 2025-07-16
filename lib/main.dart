import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';

// Data Sources
import 'data/datasources/mood_local_datasource.dart';
import 'data/datasources/chat_local_datasource.dart';
import 'data/datasources/chat_remote_datasource.dart';
import 'data/datasources/quotes_local_datasource.dart';

// Repositories
import 'data/repositories/mood_repository_impl.dart';
import 'data/repositories/chat_repository_impl.dart';
import 'data/repositories/quotes_repository_impl.dart';

// Use Cases
import 'domain/usecases/mood_usecases.dart' as mood_usecases;
import 'domain/usecases/chat_usecases.dart' as chat_usecases;
import 'domain/usecases/quotes_usecases.dart' as quotes_usecases;

// BLoCs
import 'presentation/bloc/mood/mood_bloc.dart';
import 'presentation/bloc/chat/chat_bloc.dart';
import 'presentation/bloc/quotes/quotes_bloc.dart';

// Pages
import 'presentation/pages/home_screen.dart';
import 'presentation/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({
    super.key,
    required this.sharedPreferences,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Mood BLoC
        BlocProvider<MoodBloc>(
          create: (context) {
            final moodLocalDataSource = MoodLocalDataSourceImpl(sharedPreferences);
            final moodRepository = MoodRepositoryImpl(moodLocalDataSource);
            
            return MoodBloc(
              getMoodEntries: mood_usecases.GetMoodEntries(moodRepository),
              saveMoodEntryUseCase: mood_usecases.SaveMoodEntry(moodRepository),
              getTodayMood: mood_usecases.GetTodayMood(moodRepository),
            );
          },
        ),
        
        // Chat BLoC
        BlocProvider<ChatBloc>(
          create: (context) {
            final chatLocalDataSource = ChatLocalDataSourceImpl(sharedPreferences);
            final chatRemoteDataSource = ChatRemoteDataSourceImpl(
              client: http.Client(),
              apiKey: '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', // Replace with actual API key
            );
            final chatRepository = ChatRepositoryImpl(
              localDataSource: chatLocalDataSource,
              remoteDataSource: chatRemoteDataSource,
              uuid: Uuid(),
            );
            
            return ChatBloc(
              getChatHistory: chat_usecases.GetChatHistory(chatRepository),
              sendMessage: chat_usecases.SendMessage(chatRepository),
              clearChatHistory: chat_usecases.ClearChatHistory(chatRepository),
            );
          },
        ),
        
        // Quotes BLoC
        BlocProvider<QuotesBloc>(
          create: (context) {
            final quotesLocalDataSource = QuotesLocalDataSourceImpl();
            final quotesRepository = QuotesRepositoryImpl(quotesLocalDataSource);
            
            return QuotesBloc(
              getRandomQuote: quotes_usecases.GetRandomQuote(quotesRepository),
              getQuoteOfTheDay: quotes_usecases.GetQuoteOfTheDay(quotesRepository),
            );
          },
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        home: const SplashScreenWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
