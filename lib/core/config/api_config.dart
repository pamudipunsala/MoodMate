class ApiConfig {
  static const String huggingFaceApiKey = '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';

  static bool get isApiKeyConfigured {
    return huggingFaceApiKey.isNotEmpty && huggingFaceApiKey.startsWith('hf_');
  }

  static String get currentApiKey => huggingFaceApiKey;
}