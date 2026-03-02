
import 'package:tickup/models/user_connected.dart';

class GenuisPayRequest {
  double? amount;
  String? description;
  String? currency;
  UserConnected? customer;
  String? successUrl;

  GenuisPayRequest({
    this.amount,
    this.description ,
    this.currency,
    this.successUrl,
  });

  /// FROM JSON
  factory GenuisPayRequest.fromJson(Map<String, dynamic> json) {
    return GenuisPayRequest(
      amount: json['amount'],
      description: json['description'] ?? '',
      currency: json['currency'] ?? '',
      successUrl: json['successUrl'] ?? '',
    );
  }

  /// TO JSON
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'description': description,
      'successUrl': successUrl,
    };
  }
}
