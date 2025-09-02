import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/custom_toast.dart';
import 'package:sekolah/common/lexend_textstyle.dart';
import 'package:sekolah/common/text_field.dart';
import 'package:sekolah/common/validators.dart';
import 'package:sekolah/screen/auth/register/screen/register_screen.dart';
import 'package:sekolah/screen/home/home_menu.dart';
import 'package:sekolah/screen/auth/login/provider/login_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _doLogin() {
    final email = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final emailErr = Validators.validateEmail(email);
    final passErr = Validators.validatePassword(password);
    if (emailErr != null) {
      ToastHelper.showError(emailErr);
      return;
    }
    if (passErr != null) {
      ToastHelper.showError(passErr);
      return;
    }

    ref.read(authProvider.notifier).login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.auth != null && previous?.auth == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeMenu()),
        );
      }
      if (next.error != null && next.error != previous?.error) {
        ScaffoldMessenger.of(context);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.splash,
      body: Stack(
        children: [
          Positioned(
            top: 150.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 100.h),
                SizedBox(width: 16.w),
                Text(
                  'Study Class',
                  style: LexendTextStyle.semiBold(
                    20.sp,
                    color: AppColors.text1,
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 0.65,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.r),
                    topRight: Radius.circular(50.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 70.w,
                        height: 5.h,
                        margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      Text(
                        'Masuk',
                        style: LexendTextStyle.semiBold(
                          20.sp,
                          color: AppColors.text1,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Selamat Datang Kembali!',
                        style: LexendTextStyle.light(
                          12.sp,
                          color: AppColors.text1,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CustomTextField(
                        icon: Icons.person,
                        controller: _usernameController,
                        hintText: 'Nama Pengguna',
                      ),
                      SizedBox(height: 16.h),
                      CustomPasswordField(
                        controller: _passwordController,
                        hintText: 'Kata Sandi',
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Lupa Kata Sandi?',
                          style: LexendTextStyle.light(
                            10.sp,
                            color: AppColors.text1,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: authState.isLoading ? null : _doLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 3,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.w,
                              vertical: 12.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                              side: BorderSide(color: AppColors.splash),
                            ),
                          ),
                          child:
                              authState.isLoading
                                  ? SizedBox(
                                    height: 18.h,
                                    width: 18.h,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.splash,
                                    ),
                                  )
                                  : Text(
                                    'Masuk',
                                    style: LexendTextStyle.medium(
                                      12.sp,
                                      color: AppColors.text1,
                                    ),
                                  ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              'Masuk Dengan',
                              style: LexendTextStyle.light(
                                12.sp,
                                color: AppColors.text1,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Image.asset('assets/icons/google.png', height: 24.h),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Belum Punya Akun? ",
                            style: LexendTextStyle.light(
                              12.sp,
                              color: AppColors.text1,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Daftar',
                              style: LexendTextStyle.semiBold(
                                12.sp,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
