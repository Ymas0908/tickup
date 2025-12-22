import 'customer_model.dart';

class Paiement {
  String id;
  String reference;
  double amount;
  String currency;
  String status;
  String customer;
  String created_at;

  Paiement({required this.id, required this.reference, required this.amount, required this.currency, required this.status, required this.customer, required this.created_at});

  factory Paiement.fromJson(Map<String, dynamic> json) {
    return Paiement(
      id: json['id'],
      reference: json['reference'],
      amount: json['amount'],
      currency: json['currency'],
      status: json['status'],
      customer: json['customer'],
      created_at: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'amount': amount,
      'currency': currency,
      'status': status,
      'customer': customer,
      'created_at': created_at,
    };
  }


}





