import 'package:equatable/equatable.dart';

import '../data/model/form_status.dart';
import '../data/model/qrcode_model.dart';

class QrCodeState extends Equatable {
  final FormStatus status;
  final String statusText;

  final List<QrCodeModel> products;

  const QrCodeState({
    required this.status,
    required this.products,
    required this.statusText,
  });

  QrCodeState copyWith({
    FormStatus? status,
    String? statusText,
    List<QrCodeModel>? products,
  }) =>
      QrCodeState(
        status: status ?? this.status,
        products: products ?? this.products,
        statusText: statusText ?? this.statusText,
      );

  @override
  List<Object?> get props => [
        status,
        products,
        statusText,
      ];
}
