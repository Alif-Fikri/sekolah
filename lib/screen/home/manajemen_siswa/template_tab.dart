import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/lexend_textstyle.dart';

class TemplateTabPage extends StatelessWidget {
  final String selectedClass;
  final String selectedSubject;

  const TemplateTabPage({
    super.key,
    required this.selectedClass,
    required this.selectedSubject,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.file_download,
            size: 48.sp,
            color: AppColors.grey,
          ),
          SizedBox(height: 16.h),
          Text(
            'Template CSV',
            style: LexendTextStyle.regular(16.sp, color: AppColors.grey),
          ),
          SizedBox(height: 8.h),
          Text(
            'Download template CSV untuk impor data siswa',
            style: LexendTextStyle.light(12.sp, color: AppColors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.main,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Download Template',
              style: LexendTextStyle.medium(12.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}