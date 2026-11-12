import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/logger.dart';

/// Service untuk menyimpan data sensitif secara aman.
///
/// Menggunakan [FlutterSecureStorage] yang memanfaatkan
/// Keystore (Android) / Keychain (iOS).
class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  // Key yang digunakan
  static const String _tokenKey = 'auth_token';
  static const String _pinKey = 'user_pin';

  /// Tag untuk logging.
  static const String _tag = 'SECURE_STORAGE';

  // Menyimpan token
  Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      // Logging aman: tidak mencetak token
      Logger.info('Token berhasil disimpan', tag: _tag);
    } catch (e) {
      Logger.error('Gagal menyimpan token: $e', tag: _tag);
    }
  }

  // Membaca token
  Future<String?> getToken() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      // Logging aman: hanya menyebutkan status
      Logger.debug(
        token != null ? 'Token ditemukan' : 'Token tidak ditemukan',
        tag: _tag,
      );
      return token;
    } catch (e) {
      Logger.error('Gagal membaca token: $e', tag: _tag);
      return null;
    }
  }

  // Menghapus token
  Future<void> deleteToken() async {
    try {
      await _storage.delete(key: _tokenKey);
      Logger.info('Token berhasil dihapus', tag: _tag);
    } catch (e) {
      Logger.error('Gagal menghapus token: $e', tag: _tag);
    }
  }

  // Menyimpan PIN
  Future<void> savePin(String pin) async {
    try {
      await _storage.write(key: _pinKey, value: pin);
      Logger.info('PIN berhasil disimpan', tag: _tag);
    } catch (e) {
      Logger.error('Gagal menyimpan PIN: $e', tag: _tag);
    }
  }

  // Membaca PIN
  Future<String?> getPin() async {
    try {
      final pin = await _storage.read(key: _pinKey);
      Logger.debug(
        pin != null ? 'PIN ditemukan' : 'PIN tidak ditemukan',
        tag: _tag,
      );
      return pin;
    } catch (e) {
      Logger.error('Gagal membaca PIN: $e', tag: _tag);
      return null;
    }
  }

  // Menghapus semua data
  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
      Logger.info('Semua data berhasil dihapus', tag: _tag);
    } catch (e) {
      Logger.error('Gagal menghapus semua data: $e', tag: _tag);
    }
  }

  // Cek keberadaan token
  Future<bool> hasToken() async {
    try {
      return await _storage.containsKey(key: _tokenKey);
    } catch (e) {
      Logger.error('Gagal mengecek keberadaan token: $e', tag: _tag);
      return false;
    }
  }
}
