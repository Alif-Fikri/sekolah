import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/appbar.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/inputfield.dart';
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
    final filled = _attendanceStatus.entries.where((e) => e.value != null).length;
    if (filled < _students.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lengkapi status absensi semua siswa')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Absensi untuk ${_formatDate(_selectedDate)} tersimpan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main.withOpacity(0.15),
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
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
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
                              child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Absensi',
                              style: LexendTextStyle.semiBold(16.sp, color: Colors.white),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Kelola absensi harian dan export laporan',
                              style: LexendTextStyle.light(11.sp, color: Colors.white),
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
                  Text('Form Absensi Harian', style: LexendTextStyle.semiBold(14.sp, color: AppColors.black)),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.grey.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: AppColors.main.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(Icons.group, color: AppColors.main, size: 18.sp),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Kelas', style: LexendTextStyle.medium(12.sp)),
                                  SizedBox(height: 4.h),
                                  Text(_selectedClass, style: LexendTextStyle.regular(12.sp, color: AppColors.grey)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.grey.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: Colors.purple.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(Icons.menu_book, color: Colors.purple, size: 18.sp),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Mata Pelajaran', style: LexendTextStyle.medium(12.sp)),
                                  SizedBox(height: 4.h),
                                  Text(_selectedSubject, style: LexendTextStyle.regular(12.sp, color: AppColors.grey)),
                                ],
                              ),
                            ],
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
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.grey.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tanggal', style: LexendTextStyle.medium(12.sp)),
                        SizedBox(height: 8.h),
                        GestureDetector(
                          onTap: _pickDate,
                          child: AbsorbPointer(
                            child: Inputfield(
                              label: '',
                              hint: _formatDate(_selectedDate),
                              readOnly: true,
                              onTap: _pickDate,
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          '${_selectedDate.weekdayName()}, ${_selectedDate.day} ${_selectedDate.monthName()} ${_selectedDate.year}',
                          style: LexendTextStyle.light(11.sp, color: AppColors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ..._students.map((s) {
                    final id = s['id']!;
                    return Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.grey.withOpacity(0.3)),
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
                                  style: LexendTextStyle.semiBold(12.sp, color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  s['name']!,
                                  style: LexendTextStyle.semiBold(13.sp, color: AppColors.black),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          DropdownButtonFormField<String>(
                            value: _attendanceStatus[id],
                            items: [
                              DropdownMenuItem(value: 'Hadir', child: Text('Hadir')),
                              DropdownMenuItem(value: 'Izin', child: Text('Izin')),
                              DropdownMenuItem(value: 'Sakit', child: Text('Sakit')),
                              DropdownMenuItem(value: 'Alpha', child: Text('Alpha')),
                            ],
                            onChanged: (v) => setState(() => _attendanceStatus[id] = v),
                            decoration: InputDecoration(
                              hintText: 'Pilih Status Absensi',
                              hintStyle: LexendTextStyle.regular(12.sp, color: AppColors.grey),
                              filled: true,
                              fillColor: AppColors.grey.withOpacity(0.1),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(color: AppColors.grey.withOpacity(0.35)),
                              ),
                            ),
                            style: LexendTextStyle.regular(12.sp, color: AppColors.black),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 20.h),
                  Center(
                    child: SizedBox(
                      width: 260.w,
                      child: ElevatedButton.icon(
                        onPressed: _submitAbsensi,
                        icon: Icon(Icons.check_circle, color: AppColors.white, size: 18.sp),
                        label: Text('Submit Absensi Hari Ini', style: LexendTextStyle.medium(12.sp, color: AppColors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.main,
                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}

extension _DateExt on DateTime {
  String weekdayName() {
    const names = ['Senin','Selasa','Rabu','Kamis','Jumat','Sabtu','Minggu'];
    return names[(weekday - 1) % 7];
  }

  String monthName() {
    const names = [
      'Januari','Februari','Maret','April','Mei','Juni',
      'Juli','Agustus','September','Oktober','November','Desember'
    ];
    return names[month - 1];
  }
}
