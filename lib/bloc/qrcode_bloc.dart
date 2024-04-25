import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code/bloc/qrcode_event.dart';
import 'package:qr_code/bloc/qrcode_state.dart';
import '../data/local/local_database.dart';
import '../data/model/form_status.dart';

class ScannerBloc extends Bloc<QrCodeEvent, QrCodeState> {
  ScannerBloc()
      : super(
          const QrCodeState(
            status: FormStatus.pure,
            products: [],
            statusText: "",
          ),
        ) {
    on<LoadQrCodeEvent>(loadQrCodes);
    on<AddQrCodeEvent>(insertQrCode);
    on<DeleteQrCodeEvent>(deleteQrCode);
  }

  Future<void> loadQrCodes(LoadQrCodeEvent event, emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    emit(
      state.copyWith(
          status: FormStatus.success,
          products: await LocalDatabase.getAllQrCodes()),
    );
  }

  Future<void> insertQrCode(AddQrCodeEvent event, emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    emit(
      state.copyWith(status: FormStatus.success, products: [
        ...state.products,
        await LocalDatabase.insertQrCode(event.scannerModel)
      ]),
    );
  }

  Future<void> deleteQrCode(DeleteQrCodeEvent event, emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    await LocalDatabase.deleterQrCodeId(event.scannerId);
    add(LoadQrCodeEvent());
    emit(state.copyWith(status: FormStatus.success));
  }
}
