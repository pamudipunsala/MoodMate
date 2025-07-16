abstract class QuotesRepository {
  Future<String> getRandomQuote();
  Future<String> getQuoteOfTheDay();
} 