import '../../domain/repositories/quotes_repository.dart';
import '../datasources/quotes_local_datasource.dart';

class QuotesRepositoryImpl implements QuotesRepository {
  final QuotesLocalDataSource localDataSource;

  QuotesRepositoryImpl(this.localDataSource);

  @override
  Future<String> getRandomQuote() async {
    return await localDataSource.getRandomQuote();
  }

  @override
  Future<String> getQuoteOfTheDay() async {
    return await localDataSource.getQuoteOfTheDay();
  }
} 