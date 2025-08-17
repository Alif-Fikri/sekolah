import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/appbar.dart';
import 'package:sekolah/common/colors.dart';
import 'package:sekolah/common/lexend_textstyle.dart';
import 'package:sekolah/common/inputfield.dart';

class RekapAbsensiPage extends StatefulWidget {
  const RekapAbsensiPage({super.key});

  @override
  State<RekapAbsensiPage> createState() => _RekapAbsensiPageState();
}

class _RekapAbsensiPageState extends State<RekapAbsensiPage> {
  String _selectedClass = '12 IPA 1';
  String _selectedSubject = 'Fisika';
  String _rangeOption = 'harian';
  String _selectedMonth = 'Agustus';
  String _selectedYear = '2025';
  DateTime? _customStart;
  DateTime? _customEnd;
  final ScrollController _tableScrollController = ScrollController();

  @override
  void dispose() {
    _tableScrollController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
      ),
      builder: (ctx) {
        String localClass = _selectedClass;
        String localSubject = _selectedSubject;
        String localRange = _rangeOption;
        String localMonth = _selectedMonth;
        String localYear = _selectedYear;
        DateTime? localStart = _customStart;
        DateTime? localEnd = _customEnd;
        return StatefulBuilder(
          builder: (context, setLocalState) {
            Future<void> pickStart() async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: localStart ?? DateTime.now(),
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
              if (picked != null) setLocalState(() => localStart = picked);
            }

            Future<void> pickEnd() async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: localEnd ?? DateTime.now(),
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
              if (picked != null) setLocalState(() => localEnd = picked);
            }

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20.w,
                right: 20.w,
                top: 12.h,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Icon(
                          Icons.filter_list,
                          size: 18.sp,
                          color: AppColors.black,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Filter Rekap',
                          style: LexendTextStyle.medium(
                            14.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Pilih kriteria untuk menampilkan data rekap absensi',
                      style: LexendTextStyle.light(
                        10.sp,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    CustomDropdown<String>(
                      label: 'Pilih Kelas',
                      hint: 'Pilih Kelas',
                      value: localClass,
                      items:
                          ['12 IPA 1', '12 IPA 2', '11 IPA 1']
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                      onChanged:
                          (v) =>
                              setLocalState(() => localClass = v ?? localClass),
                    ),
                    SizedBox(height: 12.h),
                    CustomDropdown<String>(
                      label: 'Pilih Mata Pelajaran',
                      hint: 'Pilih Mata Pelajaran',
                      value: localSubject,
                      items:
                          ['Fisika', 'Kimia', 'Matematika']
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                      onChanged:
                          (v) => setLocalState(
                            () => localSubject = v ?? localSubject,
                          ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Rentang Waktu',
                      style: LexendTextStyle.medium(
                        12.sp,
                        color: AppColors.black,
                      ),
                    ),
                    RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: VisualDensity(vertical: -4),
                      value: 'harian',
                      groupValue: localRange,
                      title: Text(
                        'Harian',
                        style: LexendTextStyle.regular(
                          12.sp,
                          color: AppColors.black,
                        ),
                      ),
                      onChanged: (v) => setLocalState(() => localRange = v!),
                    ),
                    RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: VisualDensity(vertical: -4),
                      value: 'mingguan',
                      groupValue: localRange,
                      title: Text(
                        'Mingguan (7 hari terakhir)',
                        style: LexendTextStyle.regular(
                          12.sp,
                          color: AppColors.black,
                        ),
                      ),
                      onChanged: (v) => setLocalState(() => localRange = v!),
                    ),
                    RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: VisualDensity(vertical: -4),
                      value: 'bulanan',
                      groupValue: localRange,
                      title: Text(
                        'Bulanan',
                        style: LexendTextStyle.regular(
                          12.sp,
                          color: AppColors.black,
                        ),
                      ),
                      onChanged: (v) => setLocalState(() => localRange = v!),
                    ),
                    if (localRange == 'bulanan') ...[
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomDropdown<String>(
                              label: 'Bulan',
                              hint: 'Bulan',
                              value: localMonth,
                              items:
                                  [
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
                                      ]
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                              onChanged:
                                  (v) => setLocalState(
                                    () => localMonth = v ?? localMonth,
                                  ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          SizedBox(
                            width: 110.w,
                            child: CustomDropdown<String>(
                              label: 'Tahun',
                              hint: 'Tahun',
                              value: localYear,
                              items:
                                  ['2023', '2024', '2025']
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                              onChanged:
                                  (v) => setLocalState(
                                    () => localYear = v ?? localYear,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: VisualDensity(vertical: -4),
                      value: 'custom',
                      groupValue: localRange,
                      title: Text(
                        'Custom',
                        style: LexendTextStyle.regular(
                          12.sp,
                          color: AppColors.black,
                        ),
                      ),
                      onChanged: (v) => setLocalState(() => localRange = v!),
                    ),
                    if (localRange == 'custom') ...[
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: pickStart,
                              child: AbsorbPointer(
                                child: Inputfield(
                                  label: 'Pilih Tanggal Awal',
                                  hint:
                                      localStart != null
                                          ? localStart
                                              .toString()
                                              .split(' ')
                                              .first
                                          : 'Pilih Tanggal Awal',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: pickEnd,
                              child: AbsorbPointer(
                                child: Inputfield(
                                  label: 'Pilih Tanggal Akhir',
                                  hint:
                                      localEnd != null
                                          ? localEnd.toString().split(' ').first
                                          : 'Pilih Tanggal Akhir',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedClass = localClass;
                            _selectedSubject = localSubject;
                            _rangeOption = localRange;
                            _selectedMonth = localMonth;
                            _selectedYear = localYear;
                            _customStart = localStart;
                            _customEnd = localEnd;
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.main,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Terapkan Filter',
                          style: LexendTextStyle.medium(
                            14.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: AppColors.main),
          SizedBox(width: 8.w),
          Text('$label: ', style: LexendTextStyle.medium(12.sp)),
          Expanded(child: Text(value, style: LexendTextStyle.regular(12.sp))),
        ],
      ),
    );
  }

  Widget _tableHeader(String text) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Text(
        text,
        style: LexendTextStyle.semiBold(12.sp, color: AppColors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _tableCell(String text, {bool isPercentage = false}) {
    final int? value = int.tryParse(text);
    Color cellColor = Colors.transparent;
    Color textColor = AppColors.black;

    if (value != null && isPercentage) {
      if (value >= 85) {
        cellColor = const Color(0xFF9AFFA6);
      } else if (value >= 65) {
        cellColor = const Color(0xFFFDBB39);
      } else {
        cellColor = const Color(0xFFFF0000);
      }
    }

    return Container(
      color: cellColor,
      padding: EdgeInsets.all(8.w),
      child: Text(
        text,
        style: LexendTextStyle.regular(11.sp, color: textColor),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTable() {
    final data = [
      ['1', 'Siti Aminah', '18', '1', '0', '95%'],
      ['2', 'Budi Santoso', '19', '0', '0', '100%'],
      ['3', 'Andi Prasetyo', '16', '1', '2', '84%'],
      ['4', 'Dewi Kartika', '17', '2', '0', '89%'],
      ['5', 'Rini Susanti', '15', '0', '4', '79%'],
      ['6', 'Ahmad Hidayat', '19', '0', '0', '100%'],
      ['7', 'Dewi Kartika', '18', '1', '0', '95%'],
      ['8', 'Dewi Kartika', '17', '1', '1', '89%'],
      ['9', 'Dewi Kartika', '18', '0', '1', '95%'],
    ];

    return Table(
      border: TableBorder.all(color: AppColors.grey.withOpacity(0.4)),
      defaultColumnWidth: FixedColumnWidth(80.w),
      columnWidths: {1: FixedColumnWidth(140.w)},
      children: [
        TableRow(
          decoration: BoxDecoration(color: AppColors.black),
          children: [
            _tableHeader('No'),
            _tableHeader('Nama Siswa'),
            _tableHeader('Hadir'),
            _tableHeader('Izin'),
            _tableHeader('Alfa'),
            _tableHeader('Kehadiran'),
          ],
        ),
        for (var r in data)
          TableRow(
            children: [
              _tableCell(r[0]),
              _tableCell(r[1]),
              _tableCell(r[2]),
              _tableCell(r[3]),
              _tableCell(r[4]),
              _tableCell(r[5], isPercentage: true),
            ],
          ),
      ],
    );
  }

  Widget _buildLegend() {
    final items = [
      {
        'label': 'Sangat Baik (≥85% / ≥85)',
        'color': const Color(0xFF9AFFA6).withOpacity(0.8),
      },
      {
        'label': 'Baik (≥75% / ≥75)',
        'color': const Color(0xFFFDBB39).withOpacity(0.8),
      },
      {
        'label': 'Cukup (≥65% / ≥65)',
        'color': const Color(0xFFB2C7FF).withOpacity(0.8),
      },
      {
        'label': 'Kurang (<65% / <65)',
        'color': const Color(0xFFFF0000).withOpacity(0.8),
      },
    ];

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.grey.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Keterangan Warna:', style: LexendTextStyle.regular(11.sp)),
          SizedBox(height: 8.h),
          LayoutBuilder(
            builder: (context, constraints) {
              final double itemWidth = (constraints.maxWidth - 12.w) / 2;
              return Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children:
                    items.map((it) {
                      return SizedBox(
                        width: itemWidth,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 16.w,
                              height: 16.w,
                              decoration: BoxDecoration(
                                color: it['color'] as Color,
                                borderRadius: BorderRadius.circular(4.r),
                                border: Border.all(
                                  color: AppColors.grey.withOpacity(0.4),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Flexible(
                              child: Text(
                                it['label'] as String,
                                style: LexendTextStyle.regular(11.sp),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              );
            },
          ),
        ],
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
                    vertical: 16.h,
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
                              'Rekap Absensi',
                              textAlign: TextAlign.center,
                              style: LexendTextStyle.semiBold(
                                16.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Export data absensi ke format CSV sesuai filter',
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
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _showFilterBottomSheet,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.filter_list,
                                  size: 16.sp,
                                  color: Colors.black54,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Filter',
                                  style: LexendTextStyle.regular(12.sp),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.main.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    _selectedClass,
                                    style: LexendTextStyle.medium(
                                      11.sp,
                                      color: AppColors.main,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    _selectedSubject,
                                    style: LexendTextStyle.medium(
                                      11.sp,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black54,
                                ),
                              ],
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
                      color: AppColors.grey.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.grey.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoRow(Icons.group, 'Kelas', _selectedClass),
                        _infoRow(
                          Icons.menu_book,
                          'Mata Pelajaran',
                          _selectedSubject,
                        ),
                        _infoRow(
                          Icons.calendar_month_outlined,
                          'Periode',
                          _rangeOption == 'custom'
                              ? '${_customStart?.toString().split(' ').first ?? '-'} - ${_customEnd?.toString().split(' ').first ?? '-'}'
                              : _rangeOption == 'bulanan'
                              ? '$_selectedMonth $_selectedYear'
                              : (_rangeOption == 'mingguan'
                                  ? '7 hari terakhir'
                                  : 'Harian'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    height: 320.h,
                    child: Scrollbar(
                      controller: _tableScrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: _tableScrollController,
                        scrollDirection: Axis.horizontal,
                        child: _buildTable(),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildLegend(),
                  SizedBox(height: 20.h),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.file_download,
                        color: AppColors.white,
                        size: 18.sp,
                      ),
                      label: Text(
                        'Export ke CSV',
                        style: LexendTextStyle.medium(
                          11.sp,
                          color: AppColors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.main,
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 24.w,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Center(
                    child: Text(
                      'File CSV akan berisi ringkasan absensi sesuai filter yang dipilih',
                      style: LexendTextStyle.light(
                        11.sp,
                        color: AppColors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
