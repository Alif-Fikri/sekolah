import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/appbar.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/lexend_textstyle.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'type': 'ujian',
        'title': 'Ujian Fisika Selesai',
        'subtitle': '34 siswa telah menyelesaikan ujian',
        'time': '5 menit lalu',
        'read': true,
      },
      {
        'type': 'peringatan',
        'title': 'Peringatan Kecurangan',
        'subtitle': 'Ahmad Rizki terdeteksi suspicious activity',
        'time': '15 menit lalu',
        'read': false,
      },
      {
        'type': 'tugas',
        'title': 'Tugas Baru Terkumpul',
        'subtitle': 'Siti Nurhaliza submit tugas kimia',
        'time': '1 jam lalu',
        'read': true,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Stack(
            children: [
              CustomPaint(
                painter: CustomBackgroundPainter(),
                size: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.18,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  child: SizedBox(
                    height: 88.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Notifikasi',
                              style: LexendTextStyle.semiBold(
                                16.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Semua pemberitahuan sistem',
                              style: LexendTextStyle.light(
                                12.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTab("Semua", isActive: true),
                  _buildTab("Ujian"),
                  _buildTab("Tugas"),
                  _buildTab("Lainnya"),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tandai Sudah Dibaca",
                style: LexendTextStyle.regular(12.sp, color: Colors.blue),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children:
                    notifications.map((n) {
                      final type = n['type'];
                      IconData icon;
                      Color iconColor;
                      Color borderColor;

                      if (type == 'ujian') {
                        icon = Icons.check_circle;
                        iconColor = Colors.green;
                        borderColor = Colors.blue.shade100;
                      } else if (type == 'peringatan') {
                        icon = Icons.error_outline;
                        iconColor = Colors.red;
                        borderColor = Colors.blue.shade100;
                      } else {
                        icon = Icons.description_outlined;
                        iconColor = Colors.blue;
                        borderColor = Colors.grey.shade300;
                      }

                      return Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color:
                              type == 'peringatan' || type == 'ujian'
                                  ? const Color(0xfff5f8ff)
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: borderColor),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(icon, color: iconColor, size: 24.sp),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    n['title'] as String? ?? '',
                                    style: LexendTextStyle.medium(
                                      12.sp,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    n['subtitle'] as String? ?? '',
                                    style: LexendTextStyle.light(
                                      11.sp,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    n['time'] as String? ?? '',
                                    style: LexendTextStyle.regular(
                                      10.sp,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (n['read'] == false)
                              Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, {bool isActive = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isActive ? AppColors.main : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        title,
        style: LexendTextStyle.medium(
          12.sp,
          color: isActive ? Colors.white : AppColors.grey,
        ),
      ),
    );
  }
}
