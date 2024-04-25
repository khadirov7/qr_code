import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../data/model/qrcode_model.dart';
import '../utils/app_colors.dart';
import 'result_screen.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({Key? key, required this.barcode}) : super(key: key);
  final ValueChanged<Barcode> barcode;

  @override
  State<StatefulWidget> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            "QR Code Scanner",
            style: TextStyle(color: AppColors.black),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
              )),
        ),
        body: Stack(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: QRView(
                key: qrKey,
                onQRViewCreated: (controller) {
                  setState(
                    () {
                      this.controller = controller;
                    },
                  );
                  controller.scannedDataStream.listen(
                    (scanData) {
                      controller.pauseCamera();
                      widget.barcode.call(scanData);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            scannerModel: QrCodeModel(
                              id: 0,
                              name: "Data",
                              qrCode: scanData.code!,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                overlay: QrScannerOverlayShape(
                  borderColor: AppColors.white,
                  borderRadius: 16,
                  borderLength: 50,
                  borderWidth: 20,
                  cutOutSize: 300,
                ),
                onPermissionSet: (ctrl, p) {
                  log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
                  if (!p) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('no Permission')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
