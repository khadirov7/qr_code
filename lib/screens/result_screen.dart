import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code/screens/show_screen.dart';
import 'package:share_plus/share_plus.dart';
import '../data/model/qrcode_model.dart';
import '../utils/app_colors.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.scannerModel});

  final QrCodeModel scannerModel;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}
class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_333333,
      body: Padding(
        padding: const EdgeInsets.only(left: 46, right: 46, top: 38),
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.c_FDB623,
                    size: 28.sp,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Text(
                  "Result",
                  style: TextStyle(
                    color: AppColors.c_D9D9D9,
                    fontSize: 27.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 19.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.black.withOpacity(.25),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.qr_code_scanner_outlined,
                        size: 50.sp,
                        color: AppColors.white,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        widget.scannerModel.name,
                        style: TextStyle(
                          color: AppColors.c_D9D9D9,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: const Color(0xFF858585),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    widget.scannerModel.qrCode,
                    style: TextStyle(
                      color: AppColors.c_D9D9D9,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowQrCodeScreen(
                                    scannerModel: widget.scannerModel,
                                  )));
                      // Uri uri = Uri.parse(widget.scannerModel.qrCode);
                      // await launchUrl(uri);
                    },
                    child: Text(
                      "Show QR Code",
                      style: TextStyle(
                        color: AppColors.c_FDB623,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 42,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 12.h),
                        backgroundColor: AppColors.c_FDB623,
                      ),
                      onPressed: () async{
    final uri=widget.scannerModel.qrCode;
    final box = context.findRenderObject() as RenderBox?;

    if (uri.isNotEmpty) {
      await Share.shareUri(
        Uri.parse(uri),
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
                      },
                      child: Icon(
                        Icons.share,
                        size: 30.sp,
                        color: AppColors.c_333333,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Share",
                      style: TextStyle(
                        color: AppColors.c_D9D9D9,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 43,
                ),
                Column(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 12.h),
                        backgroundColor: AppColors.c_FDB623,
                      ),
                      onPressed: () {},
                      child: Icon(
                        Icons.copy,
                        size: 30.sp,
                        color: AppColors.c_333333,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Copy",
                      style: TextStyle(
                        color: AppColors.c_D9D9D9,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
