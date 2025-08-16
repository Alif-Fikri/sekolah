import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/screen/auth/login_screen.dart';
import 'package:sekolah/screen/auth/register_screen.dart';
import 'package:sekolah/screen/get_started_screen.dart';
import 'package:sekolah/screen/home/quick_action/scan/scan_answer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, 
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sekolah App',
          theme: ThemeData(
            fontFamily: 'Lexend',
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          home: GetStartedScreen(),
        );
      },
    );
  }
}
