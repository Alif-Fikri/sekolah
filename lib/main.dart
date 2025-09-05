import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sekolah/routes/app_router.dart';
import 'package:sekolah/screen/auth/login/screen/login_screen.dart';
import 'package:sekolah/screen/auth/register/screen/register_screen.dart';
import 'package:sekolah/screen/get_started_screen.dart';
import 'package:sekolah/screen/home/manajemen_siswa/daftar_tab.dart';
import 'package:sekolah/screen/home/quick_action/scan/scan_answer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('auth');
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final routerAsync = ref.watch(goRouterProvider);

        return routerAsync.when(
          data:
              (router) => MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Sekolah App',
                theme: ThemeData(
                  fontFamily: 'Lexend',
                  scaffoldBackgroundColor: Colors.white,
                  useMaterial3: true,
                ),
                routerConfig: router,
              ),
          loading:
              () => const MaterialApp(
                home: Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
              ),
          error:
              (err, stack) => MaterialApp(
                home: Scaffold(body: Center(child: Text("Error: $err"))),
              ),
        );
      },
    );
  }
}
