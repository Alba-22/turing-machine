extension StringExtension on String {
  String replaceCharAt(int index, String newChar) {
    // ignore: unnecessary_this
    return this.substring(0, index) + newChar + this.substring(index + 1);
  }
}
