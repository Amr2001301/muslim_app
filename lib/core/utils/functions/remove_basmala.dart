String removeBasmalah(String text) {
  const String basmalah = 'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَـٰنِ ٱلرَّحِیمِ';
  final String normalizedText = text.replaceAll(RegExp(r'\s+'), ' ').trim();
  if (normalizedText.startsWith(basmalah)) {
    return normalizedText.substring(basmalah.length).trim();
  }
  return text.trim();
}
