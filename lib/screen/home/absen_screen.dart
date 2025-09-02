import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/appbar.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/input_field.dart';
import 'package:sekolah/common/lexend_textstyle.dart';

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({super.key});

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  String _selectedClass = '12 IPA 1';
  String _selectedSubject = 'Fisika';
  DateTime _selectedDate = DateTime.now();

  final List<String> _classList = [
    '10 IPA 1',
    '10 IPA 2',
    '11 IPA 1',
    '11 IPA 2',
    '12 IPA 1',
    '12 IPA 2',
  ];
  final List<String> _subjectList = [
    'Matematika',
    'Fisika',
    'Kimia',
    'Biologi',
    'Sejarah',
    'Geografi',
  ];

  final List<Map<String, String>> _students = [
    {'id': '1', 'name': 'Ahmad Rizki Pratama'},
    {'id': '2', 'name': 'Siti Nurhaliza'},
    {'id': '3', 'name': 'Budi Santoso'},
    {'id': '4', 'name': 'Andi Prasetyo'},
    {'id': '5', 'name': 'Dewi Kartika'},
    {'id': '6', 'name': 'Rini Susanti'},
    {'id': '7', 'name': 'Asep Suparman'},
  ];
  final Map<String, String?> _attendanceStatus = {};

  @override
  void initState() {
    super.initState();
    for (var s in _students) {
      _attendanceStatus[s['id']!] = null;
    }
  }

  String _formatDate(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yyyy = d.year.toString();
    return '$dd/$mm/$yyyy';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.main,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitAbsensi() {
    final filled =
        _attendanceStatus.entries.where((e) => e.value != null).length;
    if (filled < _students.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi status absensi semua siswa')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Absensi untuk ${_formatDate(_selectedDate)} tersimpan'),
      ),
    );
  }

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
                              'Absensi',
                              style: LexendTextStyle.semiBold(
                                16.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Kelola absensi harian dan export laporan',
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
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Form Absensi Harian',
                    style: LexendTextStyle.bold(11.sp, color: AppColors.black),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: AppColors.grey.withOpacity(0.3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: AppColors.white,
                            isExpanded: true,
                            value: _selectedClass,
                            items:
                                _classList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged:
                                (v) => setState(() => _selectedClass = v!),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 8.w, right: 6.w),
                                child: Icon(
                                  Icons.group,
                                  color: AppColors.main,
                                  size: 18.sp,
                                ),
                              ),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 36.w,
                                minHeight: 36.h,
                              ),
                              hintText: 'Pilih Kelas',
                              hintStyle: LexendTextStyle.regular(
                                12.sp,
                                color: AppColors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                            style: LexendTextStyle.regular(
                              12.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: AppColors.grey.withOpacity(0.3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: AppColors.white,
                            isExpanded: true,
                            value: _selectedSubject,
                            items:
                                _subjectList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged:
                                (v) => setState(() => _selectedSubject = v!),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 8.w, right: 6.w),
                                child: Icon(
                                  Icons.menu_book,
                                  color: AppColors.main,
                                  size: 18.sp,
                                ),
                              ),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 36.w,
                                minHeight: 36.h,
                              ),
                              hintText: 'Pilih Mata Pelajaran',
                              hintStyle: LexendTextStyle.regular(
                                12.sp,
                                color: AppColors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                            style: LexendTextStyle.regular(
                              12.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppColors.grey.withOpacity(0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tanggal', style: LexendTextStyle.regular(12.sp)),
                        SizedBox(height: 4.h),
                        Text(
                          'Pilih Tanggal yang sesuai dengan hari ini!',
                          style: LexendTextStyle.regular(
                            11.sp,
                            color: AppColors.grey,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        GestureDetector(
                          onTap: _pickDate,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: AppColors.grey.withOpacity(0.35),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _formatDate(_selectedDate),
                                    style: LexendTextStyle.regular(
                                      12.sp,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_month_outlined,
                                  size: 18.sp,
                                  color: AppColors.main,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          '${_selectedDate.weekdayName()}, ${_selectedDate.day} ${_selectedDate.monthName()} ${_selectedDate.year}',
                          style: LexendTextStyle.regular(
                            11.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ..._students.map((s) {
                    final id = s['id']!;
                    return Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: AppColors.grey.withOpacity(0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 18.r,
                                backgroundColor: AppColors.main,
                                child: Text(
                                  _initials(s['name']!),
                                  style: LexendTextStyle.semiBold(
                                    12.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  s['name']!,
                                  style: LexendTextStyle.semiBold(
                                    13.sp,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          DropdownButtonFormField<String>(
                            dropdownColor: AppColors.white,
                            value: _attendanceStatus[id],
                            items:
                                ['Hadir', 'Izin', 'Sakit', 'Alpha']
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                            onChanged:
                                (v) =>
                                    setState(() => _attendanceStatus[id] = v),
                            decoration: InputDecoration(
                              hintText: "Pilih Status Absensi",
                              hintStyle: LexendTextStyle.regular(
                                12.sp,
                                color: AppColors.grey,
                              ),
                              filled: true,
                              fillColor: AppColors.grey.withOpacity(0.1),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 12.h,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: AppColors.grey.withOpacity(0.35),
                                ),
                              ),
                            ),
                            style: LexendTextStyle.regular(
                              12.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: ElevatedButton.icon(
            onPressed: _submitAbsensi,
            icon: Icon(Icons.check_circle, color: Colors.white, size: 18.sp),
            label: Text(
              'Submit Absensi Hari Ini',
              style: LexendTextStyle.bold(11.sp, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.main,
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}

extension _DateExt on DateTime {
  String weekdayName() {
    const names = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    return names[(weekday - 1) % 7];
  }

  String monthName() {
    const names = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return names[month - 1];
  }
}
