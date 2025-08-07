import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sekolah/common/lexendtextstyle.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoPageTimer;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/images/get_started_1.png',
      'text':
          'Otomatisasi ujian dan pengelolaan kelas kini menjadi lebih mudah. Satu aplikasi, semua kebutuhan guru dan siswa terpenuhi.',
    },
    {
      'image': 'assets/images/get_started_2.png',
      'text':
          'Buat pertanyaan, nilai otomatis, periksa kehadiran, dan analisis pembelajaran semuanya dari satu aplikasi. Lebih cepat, lebih cerdas.',
    },
    {
      'image': 'assets/images/get_started_3.png',
      'text':
          'Ujian cerdas, analisis AI, dan fitur inklusif untuk semua tingkat. Saatnya belajar dengan cara baru.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoPageTimer?.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    _autoPageTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_currentPage < _pages.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _goToPage(_currentPage + 1);
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 40.h),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(height: 70.h),
                        Image.asset(
                          _pages[index]['image']!,
                          height: 300.h,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 40.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            _pages[index]['text']!,
                            textAlign: TextAlign.center,
                            style: LexendTextStyle.light(
                              14.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (index) =>
                            _buildIndicator(isActive: index == _currentPage),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          side: const BorderSide(color: Colors.black),
                        ),
                        elevation: 3,
                      ),
                      child: Text(
                        'Next',
                        style: LexendTextStyle.medium(
                          12.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      height: 35.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(
                            size: 12.sp,
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: _prevPage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator({bool isActive = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      height: 8.h,
      width: isActive ? 24.w : 8.w,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[400],
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}
