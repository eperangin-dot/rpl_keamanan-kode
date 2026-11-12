/// Kumpulan fungsi validasi dan sanitasi input.
///
/// Class ini menyediakan method statis untuk memvalidasi input
/// pengguna dan membersihkan karakter berbahaya.
class Validators {
  // ========================= HELPER (BOOLEAN) =========================

  /// Memvalidasi format email.
  ///
  /// Mengembalikan `true` jika [email] memiliki format yang valid.
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return regex.hasMatch(email);
  }

  /// Memeriksa apakah [value] tidak kosong.
  ///
  /// Mengembalikan `true` jika [value] berisi teks (setelah trim).
  static bool isEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Memvalidasi panjang [value] antara [min] dan [max].
  static bool hasValidLength(String value, {int min = 1, int max = 100}) {
    final length = value.trim().length;
    return length >= min && length <= max;
  }

  /// Memvalidasi nomor telepon: hanya angka, 10-13 digit.
  static bool isValidPhone(String phone) {
    final regex = RegExp(r'^[0-9]{10,13}$');
    return regex.hasMatch(phone.trim());
  }

  /// Memvalidasi URL: harus dimulai dengan `http://` atau `https://`.
  static bool isValidUrl(String url) {
    final regex = RegExp(r'^https?://\S+$', caseSensitive: false);
    return regex.hasMatch(url.trim());
  }

  /// Memvalidasi password: minimal 8 karakter, mengandung huruf kapital,
  /// angka, dan simbol.
  static bool isValidPassword(String password) {
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasDigit = RegExp(r'[0-9]').hasMatch(password);
    final hasSymbol = RegExp(r'[^A-Za-z0-9]').hasMatch(password);
    return password.length >= 8 && hasUppercase && hasDigit && hasSymbol;
  }

  /// Membersihkan input dari karakter berbahaya.
  ///
  /// Mengganti karakter `<`, `>`, `"`, dan `'` dengan HTML entities
  /// untuk mencegah XSS.
  static String sanitize(String input) {
    return input
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;')
        .trim();
  }

  // ========================= VALIDATOR (STRING? ERROR) =========================

  /// Memvalidasi dan membersihkan input teks.
  ///
  /// Mengembalikan pesan error jika tidak valid, atau `null` jika valid.
  static String? validateText(
    String? value, {
    String fieldName = 'Field',
    int minLength = 1,
    int maxLength = 100,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    if (!hasValidLength(value, min: minLength, max: maxLength)) {
      return '$fieldName harus antara $minLength-$maxLength karakter';
    }
    return null;
  }

  /// Memvalidasi dan membersihkan email.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!isValidEmail(value.trim())) {
      return 'Format email tidak valid';
    }
    return null;
  }

  /// Memvalidasi nomor telepon: wajib, hanya angka, 10-13 digit.
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }
    final phone = value.trim();
    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      return 'Nomor telepon hanya boleh berisi angka';
    }
    if (phone.length < 10 || phone.length > 13) {
      return 'Nomor telepon harus 10-13 digit';
    }
    return null;
  }

  /// Memvalidasi URL: harus diawali http:// atau https://.
  static String? validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'URL tidak boleh kosong';
    }
    if (!RegExp(
      r'^https?://\S+$',
      caseSensitive: false,
    ).hasMatch(value.trim())) {
      return 'URL harus diawali http:// atau https://';
    }
    return null;
  }

  /// Memvalidasi password: min 8 karakter, kapital, angka, dan simbol.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password tidak boleh kosong';
    if (value.length < 8) return 'Password minimal 8 karakter';
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password harus mengandung huruf kapital';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password harus mengandung angka';
    }
    if (!value.contains(RegExp(r'[^A-Za-z0-9]'))) {
      return 'Password harus mengandung simbol';
    }
    return null;
  }
}
