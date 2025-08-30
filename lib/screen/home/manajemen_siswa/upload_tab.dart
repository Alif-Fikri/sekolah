import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/lexend_textstyle.dart';

class UploadTabPage extends StatelessWidget {
  const UploadTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.cloud_upload, size: 18.sp, color: AppColors.main),
              SizedBox(width: 6.w),
              Text(
                'Upload CSV',
                style: LexendTextStyle.bold(12.sp, color: AppColors.black),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            'Upload file CSV yang sudah diisi sesuai template',
            style: LexendTextStyle.light(11.sp, color: AppColors.grey),
          ),
          SizedBox(height: 24.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey.withOpacity(0.4),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.insert_drive_file,
                  size: 48.sp,
                  color: AppColors.main,
                ),
                SizedBox(height: 12.h),
                Text(
                  'Pilih File CSV',
                  style: LexendTextStyle.bold(11.sp, color: AppColors.black),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Pastikan format sesuai template ya!',
                  style: LexendTextStyle.light(11.sp, color: AppColors.grey),
                ),
                SizedBox(height: 20.h),
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: uplod
                  },
                  icon: Icon(
                    Icons.file_open,
                    size: 16.sp,
                    color: AppColors.main,
                  ),
                  label: Text(
                    'Pilih File CSV',
                    style: LexendTextStyle.medium(12.sp, color: AppColors.main),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 10.h,
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
}
