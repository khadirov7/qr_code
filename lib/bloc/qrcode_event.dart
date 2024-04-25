import 'package:equatable/equatable.dart';

import '../data/model/qrcode_model.dart';

abstract class QrCodeEvent extends Equatable {}

class AddQrCodeEvent extends QrCodeEvent {
  final QrCodeModel scannerModel;

  AddQrCodeEvent({required this.scannerModel});

  @override
  List<Object?> get props => [scannerModel];
}

class DeleteQrCodeEvent extends QrCodeEvent {
  final int scannerId;

  DeleteQrCodeEvent({required this.scannerId});

  @override
  List<Object?> get props => [scannerId];
}

class UpdateScannerEvent extends QrCodeEvent {
  final QrCodeModel scannerModel;

  UpdateScannerEvent({required this.scannerModel});

  @override
  List<Object?> get props => [scannerModel];
}

class DeleteAllScannerEvent extends QrCodeEvent {
  @override
  List<Object?> get props => [];
}

class LoadQrCodeEvent extends QrCodeEvent {
  @override
  List<Object?> get props => [];
}
