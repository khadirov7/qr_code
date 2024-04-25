import '../../utils/app_constants.dart';

class QrCodeModel {
  QrCodeModel({this.id, required this.name, required this.qrCode});

  int? id;
  final String name;
  final String qrCode;

  factory QrCodeModel.fromJson(Map<String, dynamic> json) {
    return QrCodeModel(
      id: json["_id"],
      name: json["name"] as String? ?? "",
      qrCode: json["qr_code"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.name: name,
      AppConstants.qrCode: qrCode,
    };
  }

  QrCodeModel copyWith({
    int? id,
    String? name,
    String? qrCode,
  }) =>
      QrCodeModel(
        id: id ?? this.id,
        name: name ?? this.name,
        qrCode: qrCode ?? this.qrCode,
      );
}
