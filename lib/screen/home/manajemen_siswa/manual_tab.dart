import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/lexend_textstyle.dart';

class ManualTab extends StatefulWidget {
  final String selectedClass;
  final String selectedSubject;
  final List<String> schoolLevels;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const ManualTab({
    super.key,
    required this.selectedClass,
    required this.selectedSubject,
    required this.onSubmit,
    this.schoolLevels = const ['SD', 'SMP', 'SMA', 'SLB'],
  });

  @override
  ManualTabState createState() => ManualTabState();
}

class ManualTabState extends State<ManualTab> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _nisnCtrl = TextEditingController();
  final _tempatLahirCtrl = TextEditingController();
  final _tglLahirCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _waliCtrl = TextEditingController();
  final _agamaCtrl = TextEditingController();

  String? _schoolLevel;
  String? _gender;
  bool _isSlb = false;
  DateTime? _birthDate;

  @override
  void initState() {
    super.initState();
    _schoolLevel =
        widget.schoolLevels.isNotEmpty ? widget.schoolLevels.first : null;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _nisnCtrl.dispose();
    _tempatLahirCtrl.dispose();
    _tglLahirCtrl.dispose();
    _alamatCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _waliCtrl.dispose();
    _agamaCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(2010),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder:
          (ctx, child) => Theme(
            data: Theme.of(
              ctx,
            ).copyWith(colorScheme: ColorScheme.light(primary: AppColors.main)),
            child: child!,
          ),
    );
    if (d != null) {
      setState(() {
        _birthDate = d;
        _tglLahirCtrl.text =
            '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
      });
    }
  }

  void submit() {
    if (!_formKey.currentState!.validate()) return;
    final data = {
      'name': _nameCtrl.text.trim(),
      'nisn': _nisnCtrl.text.trim(),
      'level': _schoolLevel,
      'gender': _gender,
      'isSlb': _isSlb,
      'tempatLahir': _tempatLahirCtrl.text.trim(),
      'tanggalLahir': _birthDate?.toIso8601String(),
      'alamat': _alamatCtrl.text.trim(),
      'email': _emailCtrl.text.trim(),
      'phone': _phoneCtrl.text.trim(),
      'wali': _waliCtrl.text.trim(),
      'agama': _agamaCtrl.text.trim(),
      'kelas': widget.selectedClass,
      'mapel': widget.selectedSubject,
    };
    widget.onSubmit(data);
  }

  InputDecoration _whiteDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: LexendTextStyle.regular(12.sp, color: AppColors.grey),
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.grey.withOpacity(0.35)),
      ),
    );
  }

  Widget _label(String text, {bool required = false}) {
    return Row(
      children: [
        Text(
          text,
          style: LexendTextStyle.regular(12.sp, color: AppColors.black),
        ),
        if (required)
          Text('*', style: LexendTextStyle.regular(12.sp, color: Colors.red)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(
                  Icons.person_add_alt_1_outlined,
                  color: AppColors.main,
                  size: 18.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Tambah Siswa Manual',
                  style: LexendTextStyle.regular(12.sp),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              'Input data siswa baru secara manual',
              style: LexendTextStyle.light(11.sp, color: AppColors.grey),
            ),
            SizedBox(height: 12.h),
            _label('Nama Lengkap', required: true),
            SizedBox(height: 4.h),
            TextFormField(
              controller: _nameCtrl,
              validator:
                  (v) =>
                      v == null || v.trim().isEmpty ? 'Nama wajib diisi' : null,
              style: LexendTextStyle.regular(12.sp, color: AppColors.black),
              decoration: _whiteDecoration(hint: 'Masukkan Nama Lengkap'),
            ),
            SizedBox(height: 12.h),
            _label('NISN', required: true),
            SizedBox(height: 4.h),
            TextFormField(
              controller: _nisnCtrl,
              keyboardType: TextInputType.number,
              validator:
                  (v) =>
                      v == null || v.trim().isEmpty ? 'NISN wajib diisi' : null,
              style: LexendTextStyle.regular(12.sp, color: AppColors.black),
              decoration: _whiteDecoration(hint: 'Masukkan NISN'),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Tingkat Sekolah', required: true),
                      SizedBox(height: 4.h),
                      DropdownButtonFormField<String>(
                        
                        value: _schoolLevel,
                        items:
                            widget.schoolLevels
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        onChanged: (v) => setState(() => _schoolLevel = v),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: AppColors.grey.withOpacity(0.35),
                            ),
                          ),
                        ),
                        validator:
                            (v) =>
                                v == null || v.isEmpty ? 'Pilih level' : null,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Jenis Kelamin', required: true),
                      SizedBox(height: 4.h),
                      DropdownButtonFormField<String>(
                        value: _gender,
                        items:
                            ['Laki-laki', 'Perempuan']
                                .map(
                                  (g) => DropdownMenuItem(
                                    value: g,
                                    child: Text(g),
                                  ),
                                )
                                .toList(),
                        onChanged: (v) => setState(() => _gender = v),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: AppColors.grey.withOpacity(0.35),
                            ),
                          ),
                        ),
                        validator:
                            (v) =>
                                v == null || v.isEmpty
                                    ? 'Pilih jenis kelamin'
                                    : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Sekolah Luar Biasa (SLB)?',
                    style: LexendTextStyle.regular(12.sp),
                  ),
                ),
                Switch(
                  value: _isSlb,
                  onChanged: (v) => setState(() => _isSlb = v),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Tempat Lahir', required: true),
                      SizedBox(height: 4.h),
                      TextFormField(
                        controller: _tempatLahirCtrl,
                        validator:
                            (v) =>
                                v == null || v.trim().isEmpty
                                    ? 'Wajib diisi'
                                    : null,
                        style: LexendTextStyle.regular(
                          12.sp,
                          color: AppColors.black,
                        ),
                        decoration: _whiteDecoration(hint: 'Kota Tempat Lahir'),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Tanggal Lahir', required: true),
                      SizedBox(height: 4.h),
                      GestureDetector(
                        onTap: _pickDate,
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _tglLahirCtrl,
                            readOnly: true,
                            validator:
                                (v) =>
                                    v == null || v.trim().isEmpty
                                        ? 'Wajib diisi'
                                        : null,
                            style: LexendTextStyle.regular(
                              12.sp,
                              color: AppColors.black,
                            ),
                            decoration: _whiteDecoration(
                              hint:
                                  _tglLahirCtrl.text.isEmpty
                                      ? 'hh/bb/tt'
                                      : _tglLahirCtrl.text,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            _label('Alamat', required: true),
            SizedBox(height: 4.h),
            TextFormField(
              controller: _alamatCtrl,
              validator:
                  (v) => v == null || v.trim().isEmpty ? 'Wajib diisi' : null,
              style: LexendTextStyle.regular(12.sp, color: AppColors.black),
              decoration: _whiteDecoration(hint: 'Masukkan Alamat'),
              maxLines: 2,
            ),
            SizedBox(height: 12.h),
            _label('Email', required: true),
            SizedBox(height: 4.h),
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                  return 'Format email tidak valid';
                }
                return null;
              },
              style: LexendTextStyle.regular(12.sp, color: AppColors.black),
              decoration: _whiteDecoration(hint: 'email@example.com'),
            ),
            SizedBox(height: 12.h),
            _label('No. Telp', required: true),
            SizedBox(height: 4.h),
            TextFormField(
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              validator:
                  (v) => v == null || v.trim().isEmpty ? 'Wajib diisi' : null,
              style: LexendTextStyle.regular(12.sp, color: AppColors.black),
              decoration: _whiteDecoration(hint: 'Masukkan No Telp'),
            ),
            SizedBox(height: 12.h),
            _label('Nama Wali Murid', required: true),
            SizedBox(height: 4.h),
            TextFormField(
              controller: _waliCtrl,
              validator:
                  (v) => v == null || v.trim().isEmpty ? 'Wajib diisi' : null,
              style: LexendTextStyle.regular(12.sp, color: AppColors.black),
              decoration: _whiteDecoration(hint: 'Nama Wali Murid'),
            ),
            SizedBox(height: 12.h),
            _label('Agama', required: true),
            SizedBox(height: 4.h),
            TextFormField(
              controller: _agamaCtrl,
              validator:
                  (v) => v == null || v.trim().isEmpty ? 'Wajib diisi' : null,
              style: LexendTextStyle.regular(12.sp, color: AppColors.black),
              decoration: _whiteDecoration(hint: 'Agama'),
            ),
            SizedBox(height: 120.h),
          ],
        ),
      ),
    );
  }
}
