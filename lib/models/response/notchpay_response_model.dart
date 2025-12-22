import 'package:tickup/models/paiement.dart';

import '../customer_model.dart';

class NotchPayResponse {
  String status;
  String message;
  int code;
  Paiement paiement;
  String authorization_url;

  NotchPayResponse({required this.status, required this.message, required this.code, required this.paiement, required this.authorization_url});

  factory NotchPayResponse.fromJson(Map<String, dynamic> json) {
    return NotchPayResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      paiement: Paiement.fromJson(json['paiement']),
      authorization_url: json['authorization_url'],
    );
  }
}




