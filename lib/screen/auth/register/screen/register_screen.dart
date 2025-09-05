import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/lexend_textstyle.dart';
import 'package:sekolah/common/text_field.dart';
import 'package:sekolah/common/custom_toast.dart';
import 'package:sekolah/screen/auth/register/provider/register_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  bool _isSLB = false;
  String? _selectedSchoolLevel;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _nuptkController = TextEditingController();
  final TextEditingController _schoolNameController = TextEditingController();
  final List<String> _schoolLevels = ['SD', 'SMP', 'SMA', 'SLB'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nikController.dispose();
    _nuptkController.dispose();
    _schoolNameController.dispose();
    super.dispose();
  }

  void _onSubmit() async {
    final regState = ref.read(registerProvider);
    if (regState.isLoading) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ToastHelper.showError('Kata sandi tidak cocok');
      return;
    }

    final notifier = ref.read(registerProvider.notifier);
    await notifier.registerTeacher(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      nik: _nikController.text.trim(),
      nuptk:
          _nuptkController.text.trim().isEmpty
              ? null
              : _nuptkController.text.trim(),
      schoolName: _schoolNameController.text.trim(),
      schoolLevel: _selectedSchoolLevel ?? '',
      isSlb: _isSLB,
    );

    final newState = ref.read(registerProvider);

    if (!newState.success && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final regState = ref.watch(registerProvider);

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
            initialChildSize: 0.68,
            minChildSize: 0.68,
            maxChildSize: 0.95,
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
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 20,
                      offset: const Offset(0, 9),
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
                        'Daftar Akun',
                        style: LexendTextStyle.semiBold(
                          20.sp,
                          color: AppColors.text1,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Buat akun baru untuk memulai',
                        style: LexendTextStyle.light(
                          12.sp,
                          color: AppColors.text1,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "Data Akun",
                        style: LexendTextStyle.semiBold(
                          14.sp,
                          color: AppColors.text1,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        controller: _nameController,
                        hintText: 'Nama Lengkap',
                        icon: Icons.person_outline,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16.h),
                      CustomPasswordField(
                        controller: _passwordController,
                        hintText: 'Kata Sandi',
                      ),
                      SizedBox(height: 16.h),
                      CustomPasswordField(
                        controller: _confirmPasswordController,
                        hintText: 'Konfirmasi Kata Sandi',
                      ),

                      SizedBox(height: 24.h),
                      Text(
                        "Data Sekolah",
                        style: LexendTextStyle.semiBold(
                          14.sp,
                          color: AppColors.text1,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        controller: _schoolNameController,
                        hintText: 'Nama Sekolah',
                        icon: Icons.school_outlined,
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.splash,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: DropdownButtonFormField<String>(
                            value: _selectedSchoolLevel,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.school,
                                color: Colors.grey[600],
                                size: 20.h,
                              ),
                              hintText: 'Pilih Jenjang Sekolah',
                            ),
                            items:
                                _schoolLevels.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: LexendTextStyle.medium(12.sp),
                                    ),
                                  );
                                }).toList(),
                            onChanged:
                                (newValue) => setState(
                                  () => _selectedSchoolLevel = newValue,
                                ),
                            style: LexendTextStyle.medium(12.sp),
                            isExpanded: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      GestureDetector(
                        onTap: () => setState(() => _isSLB = !_isSLB),
                        child: Container(
                          height: 48.h,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: AppColors.splash,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.accessibility_new,
                                color: Colors.grey[600],
                                size: 20.h,
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Text(
                                  'Sekolah Luar Biasa (SLB)',
                                  style: LexendTextStyle.medium(
                                    12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              Checkbox(
                                value: _isSLB,
                                activeColor: AppColors.splash,
                                checkColor: Colors.black,
                                onChanged:
                                    (v) => setState(() => _isSLB = v ?? false),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),
                      Text(
                        "Data Identitas (Opsional)",
                        style: LexendTextStyle.semiBold(
                          14.sp,
                          color: AppColors.text1,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        controller: _nikController,
                        hintText: 'NIK',
                        icon: Icons.badge_outlined,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        controller: _nuptkController,
                        hintText: 'NUPTK',
                        icon: Icons.work_outline,
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: regState.isLoading ? null : _onSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                              side: BorderSide(color: AppColors.splash),
                            ),
                          ),
                          child:
                              regState.isLoading
                                  ? SizedBox(
                                    width: 18.w,
                                    height: 18.h,
                                    child: CircularProgressIndicator(
                                      color: AppColors.splash,
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : Text(
                                    'Daftar',
                                    style: LexendTextStyle.medium(
                                      12.sp,
                                      color: AppColors.text1,
                                    ),
                                  ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sudah Punya Akun? ",
                            style: LexendTextStyle.light(
                              12.sp,
                              color: AppColors.text1,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              'Masuk',
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
