import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../bloc/qrcode_bloc.dart';
import '../bloc/qrcode_event.dart';
import '../bloc/qrcode_state.dart';
import '../data/model/form_status.dart';
import '../data/model/qrcode_model.dart';
import '../utils/app_colors.dart';
import 'show_screen.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_333333,
      body: BlocBuilder<ScannerBloc, QrCodeState>(
        builder: (context, state) {
          if (state.status == FormStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == FormStatus.error) {
            return Center(
              child: Text(state.statusText),
            );
          }
          final GlobalKey _globalKey = GlobalKey();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 46, right: 31, top: 41),
                child: Row(
                  children: [
                    Text(
                      "History",
                      style: TextStyle(
                        color: AppColors.c_D9D9D9,
                        fontSize: 27.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.menu,
                        size: 30.sp,
                        color: AppColors.c_FDB623,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowQrCodeScreen(
                                scannerModel: QrCodeModel(
                                  name: state.products[index].name,
                                  qrCode: state.products[index].qrCode,
                                ), globalKey: _globalKey,
                              ),
                            ),
                          );
                        },
                        leading: SizedBox(
                          width: 50.w,
                          height: 50.h,
                          child: QrImageView(
                            backgroundColor: Colors.white,
                            data: state.products[index].qrCode,
                            version: QrVersions.auto,
                            size: 80,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            context.read<ScannerBloc>().add(
                                DeleteQrCodeEvent(
                                    scannerId: state.products[index].id!));
                          },
                          icon: Icon(
                            Icons.delete_forever,
                            size: 30.sp,
                            color: AppColors.c_FDB623,
                          ),
                        ),
                        title: Text(
                          state.products[index].qrCode,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        subtitle: Text(
                          state.products[index].name,
                          style: TextStyle(
                            color: AppColors.c_A4A4A4,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
