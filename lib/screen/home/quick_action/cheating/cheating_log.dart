import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/appbar.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/lexend_textstyle.dart';

class CheatingLogPage extends StatelessWidget {
  const CheatingLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'name': 'Ahmad Rizki',
        'kelas': 'Fisika 12 IPA 1',
        'pelanggaran': 'Beralih tab',
        'waktu': '28 Jan 2025, 10:15:30',
        'tindakan': 'Peringatan',
        'level': 'sedang',
      },
      {
        'name': 'Rina Pratiwi',
        'kelas': 'Fisika 12 IPA 2',
        'pelanggaran': 'Beberapa jendela browser',
        'waktu': '28 Jan 2024, 09:45:15',
        'tindakan': 'Diskualifikasi',
        'level': 'tinggi',
      },
      {
        'name': 'Rina Pratiwi',
        'kelas': 'Fisika 12 IPA 2',
        'pelanggaran': 'Beberapa jendela browser',
        'waktu': '28 Jan 2024, 09:45:15',
        'tindakan': 'Diskualifikasi',
        'level': 'rendah',
      },
      {
        'name': 'Rina Pratiwi',
        'kelas': 'Fisika 12 IPA 2',
        'pelanggaran': 'Beberapa jendela browser',
        'waktu': '28 Jan 2024, 09:45:15',
        'tindakan': 'Diskualifikasi',
        'level': 'tinggi',
      },
      {
        'name': 'Rina Pratiwi',
        'kelas': 'Fisika 12 IPA 2',
        'pelanggaran': 'Beberapa jendela browser',
        'waktu': '28 Jan 2024, 09:45:15',
        'tindakan': 'Diskualifikasi',
        'level': 'tinggi',
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
                              'Log Kecurangan',
                              textAlign: TextAlign.center,
                              style: LexendTextStyle.semiBold(
                                16.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Catatan kecurangan siswa',
                              textAlign: TextAlign.center,
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
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children:
                    items.map((e) {
                      final level = e['level'];
                      Color dotColor = Colors.orange;
                      Color badgeBg = AppColors.badgeaktif;
                      Color badgeText = const Color(0xff27AE60);
                      String levelText = 'Sedang';

                      if (level == 'tinggi') {
                        dotColor = Colors.red;
                        badgeBg = const Color(0xffffe5e5);
                        badgeText = const Color(0xffd9534f);
                        levelText = 'Tinggi';
                      } else if (level == 'sedang') {
                        dotColor = Colors.orange;
                        badgeBg = const Color(0xfffff5e6);
                        badgeText = const Color(0xfff2a900);
                        levelText = 'Sedang';
                      } else {
                        dotColor = Colors.green;
                        badgeBg = const Color(0xffe8fbef);
                        badgeText = const Color(0xff2e7d32);
                        levelText = 'Rendah';
                      }

                      return Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.grey.withOpacity(0.3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 8.w,
                                    height: 8.w,
                                    decoration: BoxDecoration(
                                      color: dotColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      e['name'] ?? '',
                                      style: LexendTextStyle.regular(
                                        12.sp,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: badgeBg,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      levelText,
                                      style: LexendTextStyle.regular(
                                        10.sp,
                                        color: badgeText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              TableLayoutRow(
                                label: 'Kelas:',
                                value: e['kelas'] ?? '',
                              ),
                              SizedBox(height: 10.h),
                              TableLayoutRow(
                                label: 'Pelanggaran:',
                                value: e['pelanggaran'] ?? '',
                              ),
                              SizedBox(height: 10.h),
                              TableLayoutRow(
                                label: 'Waktu:',
                                value: e['waktu'] ?? '',
                              ),
                              SizedBox(height: 10.h),
                              TableLayoutRow(
                                label: 'Tindakan:',
                                value: e['tindakan'] ?? '',
                                valueStyle: LexendTextStyle.medium(
                                  12.sp,
                                  color:
                                      level == 'tinggi'
                                          ? const Color(0xffd9534f)
                                          : level == 'sedang'
                                          ? const Color(0xfff2a900)
                                          : Colors.green,
                                ),
                              ),
                            ],
                          ),
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
}

class TableLayoutRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const TableLayoutRow({
    super.key,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style:
              labelStyle ??
              LexendTextStyle.regular(11.sp, color: AppColors.grey),
        ),
        Text(value, style: valueStyle ?? LexendTextStyle.regular(12.sp)),
      ],
    );
  }
}
