import 'package:flutter/widgets.dart';

import '../services/api_service.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import '../repositories/post_repository.dart';
import '../repositories/post_repository_impl.dart';

/// Singleton container untuk dependency aplikasi.
///
/// Menyimpan satu instance [ApiService] yang dipakai bersama oleh
/// [UserRepository] dan [PostRepository], sehingga tidak ada duplikasi
/// client HTTP dan konfigurasi dibaca sekali saja.
class DependencyInjector {
  DependencyInjector._internal();

  static final DependencyInjector instance = DependencyInjector._internal();

  factory DependencyInjector() => instance;

  // Dibuat lazy saat pertama diakses (setelah .env dimuat)
  final ApiService apiService = ApiService();
  late final UserRepository userRepository = UserRepositoryImpl(
    apiService: apiService,
  );
  late final PostRepository postRepository = PostRepositoryImpl(
    apiService: apiService,
  );

  /// Menutup semua resource yang digunakan.
  void dispose() {
    apiService.dispose();
  }
}

/// Menyediakan [DependencyInjector] ke widget tree.
///
/// Menggunakan [InheritedWidget] agar dependency dapat diakses
/// dari widget mana pun di bawahnya, termasuk di `initState()`
/// (karena [updateShouldNotify] selalu `false`).
class Dependencies extends InheritedWidget {
  final DependencyInjector injector;

  const Dependencies({super.key, required this.injector, required super.child});

  /// Mengambil [DependencyInjector] dari context.
  ///
  /// Aman dipanggil di `initState()` karena menggunakan
  /// [getInheritedWidgetOfExactType] (tidak membuat dependency).
  static DependencyInjector of(BuildContext context) {
    final widget = context.getInheritedWidgetOfExactType<Dependencies>();
    assert(widget != null, 'Dependencies tidak ditemukan di context');
    return widget!.injector;
  }

  @override
  bool updateShouldNotify(Dependencies oldWidget) => false;
}
