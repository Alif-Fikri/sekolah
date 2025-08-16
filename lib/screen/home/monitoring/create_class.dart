import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/appbar.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/inputfield.dart';
import 'package:sekolah/common/lexend_textstyle.dart';

class CreateClassPage extends StatefulWidget {
  const CreateClassPage({super.key});

  @override
  State<CreateClassPage> createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String? _selectedYear;
  String? _selectedSubject;
  String? _selectedDay;
  final _startController = TextEditingController();
  final _endController = TextEditingController();

  final List<String> _years = ['2024/2025', '2023/2024', '2022/2023'];
  final List<String> _subjects = ['Fisika', 'Kimia', 'Matematika', 'Biologi'];
  final List<String> _days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  final List<Map<String, dynamic>> _previewSchedules = [];

  Future<void> _pickTime(TextEditingController controller) async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.main,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.text = picked.format(context);
    }
  }

  void _addSchedulePreview() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedYear == null ||
        _selectedSubject == null ||
        _selectedDay == null ||
        _startController.text.isEmpty ||
        _endController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi semua data terlebih dahulu')),
      );
      return;
    }

    setState(() {
      _previewSchedules.add({
        'name':
            _nameController.text.trim().isEmpty
                ? '-'
                : _nameController.text.trim(),
        'year': _selectedYear,
        'subject': _selectedSubject,
        'day': _selectedDay,
        'start': _startController.text,
        'end': _endController.text,
      });

      _selectedDay = null;
      _startController.clear();
      _endController.clear();
    });
  }

  void _removeSchedulePreview(int index) {
    setState(() {
      _previewSchedules.removeAt(index);
    });
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedYear == null || _selectedSubject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih tahun ajaran dan mata pelajaran')),
      );
      return;
    }

    if (_previewSchedules.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tambahkan minimal 1 jadwal terlebih dahulu'),
        ),
      );
      return;
    }

    final kelasData = {
      'name': _nameController.text.trim(),
      'year': _selectedYear,
      'subject': _selectedSubject,
      'schedules':
          _previewSchedules
              .map(
                (e) => {'day': e['day'], 'start': e['start'], 'end': e['end']},
              )
              .toList(),
    };

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Kelas berhasil disimpan')));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _startController.dispose();
    _endController.dispose();
    super.dispose();
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
                              "Buat Kelas Baru",
                              style: LexendTextStyle.semiBold(
                                18.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "Buat kelas dan pilih mata pelajaran",
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 18.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: AppColors.grey.withOpacity(0.4),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Inputfield(
                            label: 'Nama Kelas',
                            hint: 'Contoh: 11 IPA 1',
                            controller: _nameController,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Nama kelas wajib diisi';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomDropdown<String>(
                            label: 'Tahun Ajaran',
                            hint: 'Pilih Tahun Ajaran',
                            value: _selectedYear,
                            items:
                                _years
                                    .map(
                                      (y) => DropdownMenuItem(
                                        value: y,
                                        child: Text(y),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (v) => setState(() => _selectedYear = v),
                          ),
                          SizedBox(height: 16.h),
                          CustomDropdown<String>(
                            label: 'Mata Pelajaran',
                            hint: 'Pilih Mata Pelajaran',
                            value: _selectedSubject,
                            items:
                                _subjects
                                    .map(
                                      (s) => DropdownMenuItem(
                                        value: s,
                                        child: Text(s),
                                      ),
                                    )
                                    .toList(),
                            onChanged:
                                (v) => setState(() => _selectedSubject = v),
                          ),
                          SizedBox(height: 18.h),
                          Text(
                            "Jadwal Kelas",
                            style: LexendTextStyle.bold(
                              14.sp,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Kamu bisa melihat Kelas yang sudah dibuat dengan cara Simpan Draft.",
                            style: LexendTextStyle.regular(
                              11.sp,
                              color: AppColors.grey,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CustomDropdown<String>(
                            label: 'Hari',
                            hint: 'Pilih Hari',
                            value: _selectedDay,
                            items:
                                _days
                                    .map(
                                      (d) => DropdownMenuItem(
                                        value: d,
                                        child: Text(d),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (v) => setState(() => _selectedDay = v),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Expanded(
                                child: Inputfield(
                                  label: 'Jam Mulai',
                                  hint: '07:30',
                                  controller: _startController,
                                  readOnly: true,
                                  onTap: () => _pickTime(_startController),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Inputfield(
                                  label: 'Jam Selesai',
                                  hint: '09:00',
                                  controller: _endController,
                                  readOnly: true,
                                  onTap: () => _pickTime(_endController),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      children:
                          _previewSchedules.asMap().entries.map((entry) {
                            final index = entry.key;
                            final data = entry.value;
                            return Container(
                              margin: EdgeInsets.only(bottom: 12.h),
                              padding: EdgeInsets.all(14.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: AppColors.grey.withOpacity(0.3),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${data['name']} - ${data['year']}',
                                          style: LexendTextStyle.bold(
                                            13.sp,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        Text(
                                          '${data['subject']}',
                                          style: LexendTextStyle.medium(
                                            12.sp,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          '${data['day']} | ${data['start']} - ${data['end']}',
                                          style: LexendTextStyle.regular(
                                            12.sp,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => _removeSchedulePreview(index),
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                      size: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _addSchedulePreview,
                icon: const Icon(
                  Icons.save_outlined,
                  color: AppColors.black,
                  size: 18,
                ),
                label: Text(
                  "Simpan Draft",
                  style: LexendTextStyle.medium(12.sp, color: AppColors.black),
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
                onPressed: _onSave,
                icon: const Icon(Icons.send, color: AppColors.white, size: 18),
                label: Text(
                  "Publikasikan",
                  style: LexendTextStyle.medium(12.sp, color: AppColors.white),
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
      ),
    );
  }
}
