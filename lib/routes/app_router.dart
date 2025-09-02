import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sekolah/screen/auth/login/screen/login_screen.dart';
import 'package:sekolah/screen/auth/register/screen/register_screen.dart';
import 'package:sekolah/screen/get_started_screen.dart';
import 'package:sekolah/screen/home/home_screen.dart';
import 'package:sekolah/screen/home/manajemen_siswa/daftar_tab.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/getstarted",
    routes: [
      // GoRoute(
      //   path: "/splash",
      //   name: "splash",
      //   builder: (context, state) => const SplashPage(),
      // ),
      GoRoute(
        path: "/getstarted",
        name: "getstarted",
        builder: (context, state) => const GetStartedScreen(),
      ),
      GoRoute(
        path: "/login",
        name: "login",
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: "/register",
        name: "register",
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: "/home",
        name: "home",
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: "daftar-siswa",
            name: "daftarSiswa",
            builder: (context, state) => const ManajemenSiswaPage(),
          ),
          GoRoute(
            path: "detail-siswa/:id",
            name: "detailSiswa",
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return ManajemenSiswaPage();
            },
          ),
        ],
      ),
    ],
  );
}
