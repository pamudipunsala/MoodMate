import '../repositories/quotes_repository.dart';

class GetRandomQuote {
  final QuotesRepository repository;

  GetRandomQuote(this.repository);

  Future<String> call() async {
    return await repository.getRandomQuote();
  }
}

class GetQuoteOfTheDay {
  final QuotesRepository repository;

  GetQuoteOfTheDay(this.repository);

  Future<String> call() async {
    return await repository.getQuoteOfTheDay();
  }
} 