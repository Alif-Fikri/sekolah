import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sekolah/screen/auth/login/screen/login_screen.dart';
import 'package:sekolah/screen/auth/register/screen/register_screen.dart';
import 'package:sekolah/screen/get_started_screen.dart';
import 'package:sekolah/screen/home/home_menu.dart';
import 'package:sekolah/screen/auth/login/provider/login_provider.dart';
import 'package:sekolah/screen/home/manajemen_siswa/daftar_tab.dart';
import 'package:sekolah/services/app_storage.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _sub = stream.listen((_) {
      notifyListeners();
    }, onError: (_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

final goRouterProvider = FutureProvider<GoRouter>((ref) async {
  final authState = ref.watch(authProvider);
  final authNotifier = ref.read(authProvider.notifier);

  final refreshListenable = GoRouterRefreshStream(authNotifier.refreshStream);

  final firstRun = await AppStorage.isFirstRun();

  return GoRouter(
    initialLocation: firstRun ? '/getstarted' : '/login',
    debugLogDiagnostics: true,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final location = state.uri.toString();
      final loggingIn = location == '/login' || location == '/register';
      final isLoggedIn = authState.auth != null && authState.auth!.token.isNotEmpty;

      if (!isLoggedIn) {
        if (location == '/getstarted' && !firstRun) {
          return '/login';
        }
        if (!loggingIn && location != '/getstarted') {
          return '/login';
        }
      }

      if (isLoggedIn && (loggingIn || location == '/getstarted')) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/getstarted', name: 'getstarted', builder: (ctx, st) => const GetStartedScreen()),
      GoRoute(path: '/login', name: 'login', builder: (ctx, st) => const LoginScreen()),
      GoRoute(path: '/register', name: 'register', builder: (ctx, st) => const RegisterScreen()),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (ctx, st) => const HomeMenu(),
        routes: [
          GoRoute(
            path: 'manajemen-siswa',
            name: 'manajemensiswa',
            builder: (ctx, st) => const ManajemenSiswaPage(),
          ),
        ],
      ),
    ],
  );
});
