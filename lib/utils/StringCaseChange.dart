
// ignore_for_file: file_names

class StringCaseChange {
  static String onlyFirstLetterCapital(String original) {
    if (original.isEmpty) return original;
    try {
      original = original.trim();
      var words = original.split(" ");
      String r = '';

      for (var word in words) {
        r += '${word[0].toUpperCase()}${word.substring(1).toLowerCase()} ';
      }

      return r.trim();
    } catch (e) {
      return original;
    }
  }
}
