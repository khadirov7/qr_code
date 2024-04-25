import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/model/qrcode_model.dart';
import '../services/widget_save_service.dart';
import '../utils/app_colors.dart';

class ShowQrCodeScreen extends StatefulWidget {
  const ShowQrCodeScreen({super.key, required this.scannerModel, this.globalKey});
  final GlobalKey? globalKey;
  final QrCodeModel scannerModel;

  @override
  State<ShowQrCodeScreen> createState() => _ShowQrCodeScreenState();
}

class _ShowQrCodeScreenState extends State<ShowQrCodeScreen> {

 final GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_333333.withOpacity(0.7),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              SizedBox(width: 20.w),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.c_333333,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 22.sp,
                  color: AppColors.c_FDB623,
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                "QR Code",
                style: TextStyle(
                  color: AppColors.c_D9D9D9,
                  fontSize: 27.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 33,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ListTile(
              onTap: () async {
                Uri uri = Uri.parse(widget.scannerModel.qrCode);
                await launchUrl(uri);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r)),
              tileColor: AppColors.c_333333,
              title: Text(
                "Data:",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                widget.scannerModel.qrCode,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 55,
          ),
          RepaintBoundary(
            key: globalKey,
            child: QrImageView(
              backgroundColor: Colors.white,
              data: widget.scannerModel.qrCode,
              version: QrVersions.auto,
              size: 200,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 18.h),
                      backgroundColor: AppColors.c_FDB623,
                    ),
                    onPressed: () {
                      WidgetSaverService.openWidgetAsImage(
                        context: context,
                        widgetKey: globalKey,
                        fileId: widget.scannerModel.qrCode,
                      );
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
                width: 20,
              ),
              Column(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 18.h),
                      backgroundColor: AppColors.c_FDB623,
                    ),
                    onPressed: () {
                      WidgetSaverService.saveWidgetToGallery(
                        context: context,
                        widgetKey: globalKey,
                        fileId: widget.scannerModel.qrCode,
                      );
                    },
                    child: Icon(
                      Icons.save,
                      size: 30.sp,
                      color: AppColors.c_333333,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Save",
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
    );
  }
}
