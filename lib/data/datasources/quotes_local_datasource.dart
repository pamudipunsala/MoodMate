abstract class QuotesLocalDataSource {
  Future<String> getRandomQuote();
  Future<String> getQuoteOfTheDay();
}

class QuotesLocalDataSourceImpl implements QuotesLocalDataSource {
  static const List<String> _quotes = [
    "This too shall pass.",
    "You're stronger than you feel.",
    "Every day is a new beginning.",
    "You are capable of amazing things.",
    "It's okay to not be okay.",
    "You matter, and your feelings are valid.",
    "Take it one breath at a time.",
    "You have survived 100% of your bad days so far.",
    "Your worth is not determined by your productivity.",
    "It's brave to ask for help when you need it.",
    "You are loved, even when you don't feel like it.",
    "Tomorrow is a new day with new possibilities.",
    "You don't have to be perfect to be worthy.",
    "Your feelings are temporary, but your strength is permanent.",
    "You are doing better than you think.",
    "It's okay to take time for yourself.",
    "You are not alone in this.",
    "Every step forward, no matter how small, is progress.",
    "You have the power to change your story.",
    "Be gentle with yourself today.",
    "You are enough, just as you are.",
    "The sun will rise again tomorrow.",
    "You are resilient and you will get through this.",
    "Your mental health is just as important as your physical health.",
    "It's okay to rest when you're tired.",
    "You are worthy of love and kindness.",
    "Every emotion you feel is valid.",
    "You are making progress, even if it doesn't feel like it.",
    "You have survived every difficult day so far.",
    "You are not defined by your struggles.",
  ];

  @override
  Future<String> getRandomQuote() async {
    final random = DateTime.now().millisecondsSinceEpoch;
    final index = random % _quotes.length;
    return _quotes[index];
  }

  @override
  Future<String> getQuoteOfTheDay() async {
    final today = DateTime.now();
    final dayOfYear = today.difference(DateTime(today.year, 1, 1)).inDays;
    final index = dayOfYear % _quotes.length;
    return _quotes[index];
  }
} 