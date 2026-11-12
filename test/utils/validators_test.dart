import 'package:flutter_test/flutter_test.dart';
import 'package:rpl_keamanan/utils/validators.dart'; // sesuaikan nama package

void main() {
  group('isValidEmail', () {
    test('menerima email valid', () {
      expect(Validators.isValidEmail('budi@example.com'), isTrue);
    });
    test('menolak email tanpa @', () {
      expect(Validators.isValidEmail('budi.example.com'), isFalse);
    });
    test('menolak email tanpa domain', () {
      expect(Validators.isValidEmail('budi@example'), isFalse);
    });
    test('menolak email tanpa nama dan string kosong', () {
      expect(Validators.isValidEmail('@example.com'), isFalse);
      expect(Validators.isValidEmail(''), isFalse);
    });
  });

  group('sanitize', () {
    test('mengganti tag script dengan entity', () {
      expect(
        Validators.sanitize('<script>alert("x")</script>'),
        '&lt;script&gt;alert(&quot;x&quot;)&lt;/script&gt;',
      );
    });
    test('mengganti tanda kutip tunggal dan ampersand', () {
      // Catatan: fungsi sanitize() kita mengganti ' dengan &#39; dan & tidak diubah.
      expect(Validators.sanitize("A ' & B"), 'A &#39; & B');
    });
    test('memangkas spasi di awal dan akhir', () {
      expect(Validators.sanitize('  halo  '), 'halo');
    });
  });

  group('validateText', () {
    test('menolak null dan teks kosong/spasi', () {
      expect(Validators.validateText(null), 'Field tidak boleh kosong');
      expect(Validators.validateText('    '), 'Field tidak boleh kosong');
    });
    test('menolak teks lebih pendek dari minLength', () {
      expect(
        Validators.validateText('ab', fieldName: 'Nama', minLength: 3),
        'Nama harus antara 3-100 karakter',
      );
    });
    test('menolak teks lebih panjang dari maxLength', () {
      expect(
        Validators.validateText('a' * 101),
        'Field harus antara 1-100 karakter',
      );
    });
    test('menerima teks dengan panjang valid', () {
      expect(Validators.validateText('Budi'), isNull);
    });
  });
}
