import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/lexend_textstyle.dart';

class TemplateTab extends StatelessWidget {
  final VoidCallback onDownload;

  const TemplateTab({super.key, required this.onDownload});

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.file_download_outlined,
              color: AppColors.main,
              size: 18.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              'Download Template CSV',
              style: LexendTextStyle.bold(12.sp, color: AppColors.black),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          'Unduh template untuk format data yang sesuai',
          style: LexendTextStyle.light(11.sp, color: AppColors.grey),
        ),
      ],
    );
  }

  Widget _templateCard() {
    return Column(
      children: [
        SizedBox(height: 24.h),
        Icon(Icons.description_outlined, size: 64.sp, color: Colors.green),
        SizedBox(height: 16.h),
        Text(
          'Template CSV Siswa',
          style: LexendTextStyle.bold(11.sp, color: AppColors.black),
        ),
        SizedBox(height: 6.h),
        Text(
          'Template berisi kolom: Nama Lengkap, NIM/NIS, Nama Orang Tua, Agama, DLL',
          textAlign: TextAlign.center,
          style: LexendTextStyle.light(11.sp, color: AppColors.grey),
        ),
        SizedBox(height: 24.h),
        SizedBox(
          width: 240.w,
          height: 40.h,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              elevation: 2,
            ),
            onPressed: onDownload,
            icon: Icon(Icons.download, size: 16.sp, color: Colors.white),
            label: Text(
              'Download Template CSV',
              style: LexendTextStyle.medium(12.sp, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_header(), _templateCard()],
      ),
    );
  }
}
