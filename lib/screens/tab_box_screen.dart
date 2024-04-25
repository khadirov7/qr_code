import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/qrcode_bloc.dart';
import '../bloc/qrcode_event.dart';
import '../data/model/qrcode_model.dart';
import '../utils/app_colors.dart';
import 'generate_screen.dart';
import 'history_screen.dart';
import 'qr_scanner_screen.dart';

class TabBox1 extends StatefulWidget {
  const TabBox1({super.key});

  @override
  State<TabBox1> createState() => _TabBox1State();
}

class _TabBox1State extends State<TabBox1> {
  List<Widget> _screens = [];
  int _activeIndex = 1;

  @override
  void initState() {
    _screens = [
      const GenerateScreen(),
      const HistoryScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_activeIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newActiveIndex) {
          _activeIndex = newActiveIndex;
          setState(() {});
        },
        currentIndex: _activeIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white10,
        backgroundColor: AppColors.c_333333,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.qr_code_scanner,
              color: AppColors.c_FDB623,
              size: 30,
            ),
            icon: Icon(
              Icons.qr_code_scanner,
              color: AppColors.white,
              size: 30,
            ),
            label: "Generate",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.history,
              color: AppColors.c_FDB623,
              size: 30,
            ),
            icon: Icon(
              Icons.history,
              color: AppColors.white,
              size: 30,
            ),
            label: "History",
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 65.w,
        height: 65.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: AppColors.c_FDB623,
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: AppColors.c_FDB623,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return QrScannerScreen(
                    barcode: (barcode) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(barcode.code.toString()),
                        ),
                      );
                      context.read<ScannerBloc>().add(
                            AddQrCodeEvent(
                              scannerModel: QrCodeModel(
                                name: "Data",
                                qrCode: barcode.code.toString(),
                              ),
                            ),
                          );
                    },
                  );
                },
              ),
            );
          },
          child: Icon(
            Icons.qr_code_scanner_sharp,
            size: 30.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
