import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/lexend_textstyle.dart';

class Inputfield extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;

  const Inputfield({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.readOnly =  false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: LexendTextStyle.bold(12.sp, color: AppColors.black)),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: LexendTextStyle.regular(12.sp, color: AppColors.black),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: LexendTextStyle.regular(12.sp, color: AppColors.grey),
            filled: true,
            fillColor: AppColors.grey.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 10.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.4)),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final String? hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    this.hint,
    this.value,
    required this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: LexendTextStyle.bold(12.sp, color: AppColors.black)),
        SizedBox(height: 6.h),
        DropdownButtonFormField<T>(
          dropdownColor: AppColors.white,
          value: value,
          items: items,
          onChanged: onChanged,
          style: LexendTextStyle.regular(12.sp, color: AppColors.black),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: LexendTextStyle.regular(12.sp, color: AppColors.grey),
            filled: true,
            fillColor: AppColors.grey.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 10.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.4)),
            ),
          ),
        ),
      ],
    );
  }
}
