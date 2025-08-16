import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/appbar.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/lexend_textstyle.dart';
import 'package:sekolah/screen/home/monitoring/create_class.dart';

class MonitoringPage extends StatelessWidget {
  const MonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16.h),
                  Text(
                    "Kelas yang Diampu",
                    style: LexendTextStyle.semiBold(16.sp, color: Colors.white),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Manage Your Classes",
                    style: LexendTextStyle.light(13.sp, color: Colors.white),
                  ),
                  SizedBox(height: 70.h),
                  Expanded(
                    child: ListView(
                      children: [
                        _classCard(
                          imagePath: "assets/images/fisika.png",
                          title: "Fisika Kelas 12 IPA 1",
                          subtitle: "Fisika",
                          students: 28,
                          schedule: "Senin, 09:00",
                          activeExams: "30 Ujian Aktif",
                        ),
                        _classCard(
                          imagePath: "assets/images/fisika.png",
                          title: "Fisika Kelas 12 IPA 2",
                          subtitle: "Fisika",
                          students: 34,
                          schedule: "Selasa, 10:00",
                          activeExams: "2 Ujian Aktif",
                        ),
                        _classCard(
                          imagePath: "assets/images/kimia.png",
                          title: "Kimia Kelas 11 IPA 1",
                          subtitle: "Kimia",
                          students: 32,
                          schedule: "Rabu, 08:00",
                          activeExams: "",
                        ),
                        _classCard(
                          imagePath: "assets/images/kimia.png",
                          title: "Kimia Kelas 12 IPA 2",
                          subtitle: "Kimia",
                          students: 30,
                          schedule: "Kamis, 11:00",
                          activeExams: "3 Ujian Aktif",
                        ),
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateClassPage(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade400,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: Text(
                                "+ Tambah Kelas",
                                style: LexendTextStyle.regular(
                                  10.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _classCard({
    required String imagePath,
    required String title,
    required String subtitle,
    required int students,
    required String schedule,
    required String activeExams,
  }) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    imagePath,
                    height: 40.h,
                    width: 61.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.people, size: 14.sp, color: Colors.black54),
                    SizedBox(width: 4.w),
                    Text(
                      "$students Siswa",
                      style: LexendTextStyle.light(10.sp, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14.sp, color: Colors.black54),
                    SizedBox(width: 4.w),
                    Text(
                      schedule,
                      style: LexendTextStyle.light(10.sp, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: LexendTextStyle.semiBold(
                            12.sp,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (activeExams.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.badgeaktif,
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(color: Color(0xff34A853)),
                          ),
                          child: Text(
                            activeExams,
                            style: LexendTextStyle.light(
                              10.sp,
                              color: Color(0xff27AE60),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    subtitle,
                    style: LexendTextStyle.light(10.sp, color: Colors.black),
                  ),
                  SizedBox(height: 24.h),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Lihat Kelas",
                          style: LexendTextStyle.light(
                            10.sp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14.sp,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
