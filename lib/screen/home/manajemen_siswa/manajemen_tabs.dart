import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/lexend_textstyle.dart';

class ManajemenTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const ManajemenTabs({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  Widget _tabButton(IconData icon, String label, int index) {
    final bool selected = selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 180),
                scale: selected ? 1.06 : 1.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 18.sp,
                      color: selected ? AppColors.main : AppColors.grey,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      label,
                      style: LexendTextStyle.regular(
                        12.sp,
                        color: selected ? AppColors.main : AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.h),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                height: 3.h,
                width: selected ? 48.w : 24.w,
                decoration: BoxDecoration(
                  color: selected ? AppColors.main : Colors.transparent,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _tabButton(Icons.group, 'Daftar', 0),
        _tabButton(Icons.edit, 'Manual', 1),
        _tabButton(Icons.file_download, 'Template', 2),
        _tabButton(Icons.cloud_upload, 'Upload', 3),
      ],
    );
  }
}
