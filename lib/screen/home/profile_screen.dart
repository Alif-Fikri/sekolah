import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/appbar.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/lexend_textstyle.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.profile,
      body: Stack(
        children: [
          CustomPaint(
            painter: CustomBackgroundPainter(),
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.18,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Text(
                  "Profil Saya",
                  textAlign: TextAlign.center,
                  style: LexendTextStyle.semiBold(16.sp, color: Colors.white),
                ),
                SizedBox(height: 10.h),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 30.w),
                      child: Container(
                        margin: EdgeInsets.only(top: 85.h),
                        padding: EdgeInsets.only(
                          top: 40.h,
                          left: 40.w,
                          right: 16.w,
                          bottom: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(30.r),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(30.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Dra. Sarah Wijayanti, M.Pd",
                              style: LexendTextStyle.semiBold(
                                16.sp,
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "NIP: 196512121990032001",
                              style: LexendTextStyle.light(
                                14.sp,
                                color: AppColors.text2,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "sarah.wijayanti@smpn1.sch.id",
                              style: LexendTextStyle.light(
                                12.sp,
                                color: AppColors.text2,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Divider(color: AppColors.grey),
                            _menuItem(Icons.access_time, "Working Hours"),
                            _menuItem(Icons.person, "My Account"),
                            _menuItem(Icons.phone, "Phone Number"),
                            _menuItem(Icons.lock, "Change Password"),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 24.h,
                      child: Container(
                        width: 100.r,
                        height: 100.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.profile,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 30.h,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 12.r,
                              spreadRadius: 1.r,
                              offset: Offset(0, 6.h),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 43.r,
                          backgroundColor: AppColors.white,
                          child: Icon(
                            Icons.person,
                            size: 50.sp,
                            color: AppColors.main,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.only(right: 30.w),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.w,
                      vertical: 15.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(30.r),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(30.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _simpleMenu("About Us"),
                        _simpleMenu("Terms of Service"),
                        _simpleMenu("LogOut"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.text2, size: 20.sp),
      title: Text(
        title,
        style: LexendTextStyle.medium(14.sp, color: AppColors.text2),
      ),
      onTap: () {},
    );
  }

  Widget _simpleMenu(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Text(
        title,
        style: LexendTextStyle.medium(14.sp, color: AppColors.text2),
      ),
    );
  }
}
