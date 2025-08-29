import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/appbar.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/lexend_textstyle.dart';
import 'manajemen_tabs.dart';
import 'manual_tab.dart';

class ManajemenSiswaPage extends StatefulWidget {
  const ManajemenSiswaPage({super.key});

  @override
  State<ManajemenSiswaPage> createState() => _ManajemenSiswaPageState();
}

class _ManajemenSiswaPageState extends State<ManajemenSiswaPage> {
  String _selectedClass = '12 IPA 2';
  String _selectedSubject = 'Fisika';
  final List<String> _classes = [
    '10 IPA 1',
    '11 IPA 1',
    '12 IPA 1',
    '12 IPA 2',
  ];
  final List<String> _subjects = ['Fisika', 'Kimia', 'Matematika', 'Biologi'];

  int _selectedTab = 0;

  final List<Map<String, String>> _students = [
    {'id': '1', 'name': 'Ahmad Rizki Pratama', 'sub': 'Fisika, 12 IPA 1'},
    {'id': '2', 'name': 'Budi Santoso', 'sub': ''},
    {'id': '3', 'name': 'Maya Indira Sari', 'sub': ''},
    {'id': '4', 'name': 'Siti Nurhaliza', 'sub': 'Fisika, 12 IPA 1'},
    {'id': '5', 'name': 'Doni Pratama', 'sub': 'Fisika, 12 IPA 1'},
    {'id': '6', 'name': 'Lisa Permata', 'sub': ''},
    {'id': '7', 'name': 'Rina Pratiwi', 'sub': ''},
    {'id': '8', 'name': 'Dika Saputra', 'sub': ''},
    {'id': '9', 'name': 'Rizky Firmansyah', 'sub': ''},
  ];

  final Map<String, bool> _selected = {};
  final GlobalKey<ManualTabState> _manualKey = GlobalKey<ManualTabState>();

  @override
  void initState() {
    super.initState();
    for (final s in _students) {
      _selected[s['id']!] = false;
    }
  }

  int get selectedCount => _selected.values.where((v) => v).length;

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  Widget _studentTile(Map<String, String> s) {
    final id = s['id']!;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.grey.withOpacity(0.35)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: ListTile(
        horizontalTitleGap: 8.w,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        leading: Checkbox(
          activeColor: Colors.transparent,
          checkColor: AppColors.black,
          value: _selected[id],
          onChanged: (v) => setState(() => _selected[id] = v ?? false),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: AppColors.main,
              child: Text(
                _initials(s['name']!),
                style: LexendTextStyle.semiBold(12.sp, color: Colors.white),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s['name']!,
                    style: LexendTextStyle.semiBold(
                      13.sp,
                      color: AppColors.black,
                    ),
                  ),
                  if ((s['sub'] ?? '').isNotEmpty)
                    Text(
                      s['sub']!,
                      style: LexendTextStyle.regular(
                        11.sp,
                        color: AppColors.grey,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            if ((s['sub'] ?? '').isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F7EA),
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(color: const Color(0xFFBDE8C6)),
                ),
                child: Text(
                  'Terdaftar',
                  style: LexendTextStyle.medium(
                    11.sp,
                    color: const Color(0xFF2E8B3A),
                  ),
                ),
              ),
          ],
        ),
        onTap: () => setState(() => _selected[id] = !_selected[id]!),
      ),
    );
  }

  Widget _daftarContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.group, color: AppColors.main, size: 18.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Daftar Siswa',
                style: LexendTextStyle.semiBold(13.sp, color: AppColors.black),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Text(
                  'Pilih siswa untuk didaftarkan ke kelas/mapel.',
                  style: LexendTextStyle.light(11.sp, color: AppColors.grey),
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: selectedCount > 0 ? () {} : null,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.main,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.white, size: 16.sp),
                        SizedBox(width: 6.w),
                        Text(
                          'Edit',
                          style: LexendTextStyle.regular(
                            11.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: selectedCount > 0 ? () {} : null,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.badgehigh,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Hapus',
                          style: LexendTextStyle.regular(
                            11.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ..._students.map(_studentTile),
      ],
    );
  }

  Widget _placeholder(String t) {
    return Center(
      child: Text(
        t,
        style: LexendTextStyle.regular(12.sp, color: AppColors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double headerHeight = MediaQuery.of(context).size.height * 0.18;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Stack(
            children: [
              CustomPaint(
                painter: CustomBackgroundPainter(),
                size: Size(MediaQuery.of(context).size.width, headerHeight),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(6.w),
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
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Manajemen Siswa',
                                  style: LexendTextStyle.semiBold(
                                    18.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  'Kelola data siswa dan pendaftaran kelas',
                                  style: LexendTextStyle.light(
                                    12.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: DropdownButtonFormField<String>(
                                dropdownColor: AppColors.white,
                                isExpanded: true,
                                value: _selectedClass,
                                items:
                                    _classes
                                        .map(
                                          (c) => DropdownMenuItem(
                                            value: c,
                                            child: Text(
                                              c,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                onChanged:
                                    (v) => setState(
                                      () =>
                                          _selectedClass = v ?? _selectedClass,
                                    ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 8.h,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.class_,
                                    color: AppColors.text2,
                                    size: 18.sp,
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 36.w,
                                    minHeight: 36.h,
                                  ),
                                ),
                                style: LexendTextStyle.regular(
                                  12.sp,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: DropdownButtonFormField<String>(
                                dropdownColor: AppColors.white,
                                isExpanded: true,
                                value: _selectedSubject,
                                items:
                                    _subjects
                                        .map(
                                          (s) => DropdownMenuItem(
                                            value: s,
                                            child: Text(
                                              s,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                onChanged:
                                    (v) => setState(
                                      () =>
                                          _selectedSubject =
                                              v ?? _selectedSubject,
                                    ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 8.h,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.menu_book,
                                    color: AppColors.text2,
                                    size: 18.sp,
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 36.w,
                                    minHeight: 36.h,
                                  ),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: ManajemenTabs(
              selectedIndex: _selectedTab,
              onTap: (i) => setState(() => _selectedTab = i),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
              child: SingleChildScrollView(
                child:
                    _selectedTab == 0
                        ? _daftarContent()
                        : _selectedTab == 1
                        ? ManualTab(
                          key: _manualKey,
                          selectedClass: _selectedClass,
                          selectedSubject: _selectedSubject,
                          onSubmit: (map) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Siswa ${map['name']} berhasil ditambahkan',
                                ),
                              ),
                            );
                          },
                        )
                        : _selectedTab == 2
                        ? _placeholder('Download template CSV di sini')
                        : _placeholder('Upload CSV / file di sini'),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
              top: BorderSide(color: AppColors.grey.withOpacity(0.16)),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child:
              _selectedTab == 1
                  ? SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _manualKey.currentState?.submit();
                      },
                      icon: Icon(
                        Icons.person_add,
                        size: 18.sp,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Tambah Siswa',
                        style: LexendTextStyle.medium(
                          12.sp,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.main,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  )
                  : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.group, color: AppColors.main, size: 18.sp),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              '$selectedCount siswa dipilih',
                              style: LexendTextStyle.regular(13.sp),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (selectedCount == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Pilih siswa terlebih dahulu'),
                                ),
                              );
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '$selectedCount siswa ditambahkan ke $_selectedClass',
                                ),
                              ),
                            );
                            setState(() {
                              for (final k in _selected.keys) {
                                if (_selected[k] == true) _selected[k] = false;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.person_add,
                            size: 18.sp,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Tambah Siswa ke Kelas',
                            style: LexendTextStyle.medium(
                              12.sp,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.main,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
