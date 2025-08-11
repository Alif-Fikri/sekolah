import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/appbar.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/inputfield.dart';
import 'package:sekolah/common/lexend_textstyle.dart';

class CreateExamPage extends StatelessWidget {
  const CreateExamPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  children: [
                    Padding(
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
                                  "Buat Ujian Baru",
                                  textAlign: TextAlign.center,
                                  style: LexendTextStyle.semiBold(
                                    16.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "Siapkan Ujian Untuk Siswa",
                                  textAlign: TextAlign.center,
                                  style: LexendTextStyle.light(
                                    11.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Inputfield(
                    label: "Nama Ujian",
                    hint: "Contoh: Ujian Tengah Semester Fisika",
                  ),
                  SizedBox(height: 12.h),
                  CustomDropdown<String>(
                    label: "Mata Pelajaran",
                    hint: "Pilih Mata Pelajaran",
                    items: const [
                      DropdownMenuItem(value: "Fisika", child: Text("Fisika")),
                      DropdownMenuItem(value: "Kimia", child: Text("Kimia")),
                    ],
                    onChanged: (v) {},
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: Inputfield(
                          label: "Durasi (Menit)",
                          hint: "90",
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Inputfield(
                          label: "Jumlah Soal",
                          hint: "40",
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  CustomDropdown<String>(
                    label: "Kelas Target",
                    hint: "Pilih Kelas",
                    items: const [
                      DropdownMenuItem(
                        value: "Kelas 12 IPA 1",
                        child: Text("Kelas 12 IPA 1"),
                      ),
                      DropdownMenuItem(
                        value: "Kelas 12 IPA 2",
                        child: Text("Kelas 12 IPA 2"),
                      ),
                    ],
                    onChanged: (v) {},
                  ),
                  SizedBox(height: 12.h),
                  CustomDropdown<String>(
                    label: "Ujian Luring atau Daring",
                    hint: "Pilih Metode Ujian",
                    items: const [
                      DropdownMenuItem(value: "Luring", child: Text("Luring")),
                      DropdownMenuItem(value: "Daring", child: Text("Daring")),
                    ],
                    onChanged: (v) {},
                  ),
                  SizedBox(height: 16.h),
                  _buildUploadSection(
                    title: "Upload Soal via web",
                    uploadHint: "Upload File Soal (.csv)",
                    onUpload: () {},
                    onDownload: () {},
                  ),
                  SizedBox(height: 16.h),
                  _buildUploadSection(
                    title: "Upload Soal via tertulis",
                    showUpload: false,
                    onDownload: () {},
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.save_outlined,
                            color: AppColors.black,
                            size: 18,
                          ),
                          label: Text(
                            "Simpan Draft",
                            style: LexendTextStyle.medium(
                              12.sp,
                              color: AppColors.black,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            side: const BorderSide(color: AppColors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.send,
                            color: AppColors.white,
                            size: 18,
                          ),
                          label: Text(
                            "Publikasikan",
                            style: LexendTextStyle.medium(
                              12.sp,
                              color: AppColors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.main,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadSection({
    required String title,
    String? uploadHint,
    bool showUpload = true,
    required VoidCallback onDownload,
    VoidCallback? onUpload,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.grey.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: LexendTextStyle.bold(12.sp, color: AppColors.black),
          ),
          SizedBox(height: 8.h),
          if (showUpload && uploadHint != null) ...[
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onUpload,
                icon: const Icon(
                  Icons.upload,
                  size: 18,
                  color: AppColors.black,
                ),
                label: Text(
                  uploadHint,
                  style: LexendTextStyle.medium(12.sp, color: AppColors.black),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.grey.withOpacity(0.1),
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 12.w,
                  ),
                  side: BorderSide(color: AppColors.grey.withOpacity(0.4)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: Text(
                "atau",
                style: LexendTextStyle.regular(11.sp, color: AppColors.grey),
              ),
            ),
            SizedBox(height: 8.h),
          ],
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onDownload,
              icon: const Icon(
                Icons.download,
                size: 18,
                color: AppColors.black,
              ),
              label: Text(
                "Download Template Soal",
                style: LexendTextStyle.medium(12.sp, color: AppColors.black),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.grey.withOpacity(0.1),
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                side: BorderSide(color: AppColors.grey.withOpacity(0.4)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
