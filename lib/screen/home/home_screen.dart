import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/lexend_textstyle.dart';
import 'package:sekolah/screen/home/notification/notification_screen.dart';
import 'package:sekolah/screen/home/quick_action/cheating/cheating_log.dart';
import 'package:sekolah/screen/home/quick_action/exam/create_exam.dart';
import 'package:sekolah/screen/home/quick_action/export/export_nilai.dart';
import 'package:sekolah/screen/home/quick_action/scan/scan_answer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/header.png',
                    height: 140.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 16.h,
                    left: 16.w,
                    right: 16.w,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Hi, Mrs.Intan',
                            style: LexendTextStyle.semiBold(
                              18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationPage(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/icons/icon_absensi.png',
                              height: 15.h,
                              width: 14.w,
                            ),
                            label: Text(
                              'Absensi',
                              style: LexendTextStyle.medium(
                                10.sp,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.button2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.r),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/icons/icon_manajemen.png',
                              height: 15.h,
                              width: 14.w,
                            ),
                            label: Text(
                              'Manajemen Siswa',
                              style: LexendTextStyle.medium(
                                10.sp,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.button3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.r),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/icon_absensi.png',
                          height: 15.h,
                          width: 14.w,
                        ),
                        label: Text(
                          'Rekap Absensi',
                          style: LexendTextStyle.medium(
                            10.sp,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.button4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Aksi Cepat',
                      style: LexendTextStyle.semiBold(
                        14.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.h,
                      crossAxisSpacing: 8.w,
                      childAspectRatio: 3.5,
                      children: [
                        _quickAction(
                          "assets/icons/icon_sylabus.png",
                          'Syllabus Analysis',
                          () {},
                        ),
                        _quickAction(
                          "assets/icons/icon_test.png",
                          'Create Test',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateExamPage(),
                              ),
                            );
                          },
                        ),
                        _quickAction(
                          "assets/icons/icon_scan.png",
                          'Scan Answer',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScanAnswerPage(),
                              ),
                            );
                          },
                        ),
                        _quickAction(
                          "assets/icons/icon_log.png",
                          'Cheating Log',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheatingLogPage(),
                              ),
                            );
                          },
                        ),
                        _quickAction(
                          "assets/icons/icon_export.png",
                          'Export Nilai',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExportNilaiPage(),
                              ),
                            );
                          },
                        ),
                        _quickAction(
                          "assets/icons/icon_history.png",
                          'History',
                          () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Global Monitoring',
                      style: LexendTextStyle.semiBold(
                        14.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _monitoringTile('Ahmad Rizki', 'Mengerjakan', '25:30'),
                    _monitoringTile('Siti Nurhaliza', 'Submit', '00:00'),
                    _monitoringTile('Budi Santoso', 'Mengerjakan', '18:45'),
                    SizedBox(height: 8.h),
                    Center(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Lihat Semua',
                          style: LexendTextStyle.regular(
                            13.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickAction(String assetPath, String label, VoidCallback onTap) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        side: BorderSide(color: Colors.grey.shade500),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetPath, height: 18.h, width: 18.w),
          SizedBox(width: 4.w),
          Text(
            label,
            style: LexendTextStyle.regular(13.sp, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _monitoringTile(String name, String status, String time) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade500),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, size: 10.sp, color: AppColors.button1),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: LexendTextStyle.regular(13.sp)),
                Text(status, style: LexendTextStyle.light(12.sp)),
              ],
            ),
          ),
          Text(time, style: LexendTextStyle.regular(13.sp)),
        ],
      ),
    );
  }
}
