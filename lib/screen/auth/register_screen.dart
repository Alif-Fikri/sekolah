import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/lexend_textstyle.dart';
import 'package:sekolah/common/textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isButtonPressed = false;
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
  final List<String> _schoolLevels = ['SD', 'SMP', 'SMA'];

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

  @override
  Widget build(BuildContext context) {
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
                      CustomTextField(
                        controller: _nikController,
                        hintText: 'NIK (Nomor Induk Kependudukan)',
                        icon: Icons.badge_outlined,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        controller: _nuptkController,
                        hintText:
                            'NUPTK (Nomor Unik Pendidik dan Tenaga Kependidikan)',
                        icon: Icons.work_outline,
                      ),
                      SizedBox(height: 16.h),
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
                              color: Colors.black.withOpacity(0.1),
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
                            onChanged: (newValue) {
                              setState(() {
                                _selectedSchoolLevel = newValue;
                              });
                            },
                            style: LexendTextStyle.medium(12.sp),
                            isExpanded: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.splash,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 2.h,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.accessibility_new,
                              color: Colors.grey[600],
                              size: 20.h,
                            ),
                            SizedBox(width: 16.w),
                            Text(
                              'Apakah SLB?',
                              style: LexendTextStyle.medium(
                                12.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            const Spacer(),
                            Checkbox(
                              value: _isSLB,
                              activeColor: AppColors.splash,
                              checkColor: Colors.black,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isSLB = value ?? false;
                                });
                              },
                            ),
                          ],
                        ),
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
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isButtonPressed = true;
                          });
                          Future.delayed(const Duration(milliseconds: 300), () {
                            setState(() {
                              _isButtonPressed = false;
                            });
                          });
                          if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Kata sandi tidak cocok',
                                  style: LexendTextStyle.medium(12.sp),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (_nameController.text.isEmpty ||
                              _emailController.text.isEmpty ||
                              _nikController.text.isEmpty ||
                              _schoolNameController.text.isEmpty ||
                              _selectedSchoolLevel == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Harap lengkapi semua field yang wajib diisi',
                                  style: LexendTextStyle.medium(12.sp),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            // TODO: proses registrasi
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isButtonPressed
                                  ? AppColors.splash
                                  : Colors.white,
                          elevation: 3,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                            vertical: 12.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            side: BorderSide(
                              color:
                                  _isButtonPressed
                                      ? Colors.transparent
                                      : AppColors.splash,
                            ),
                          ),
                        ),
                        child: Text(
                          'Daftar',
                          style: LexendTextStyle.medium(
                            12.sp,
                            color:
                                _isButtonPressed
                                    ? Colors.white
                                    : AppColors.text1,
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
                            onTap: () {
                              Navigator.pop(context);
                            },
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
