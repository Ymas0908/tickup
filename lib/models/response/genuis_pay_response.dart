class GenuisPayResponse {
  bool? success;
  Data? data;

  GenuisPayResponse({this.success, this.data});

  GenuisPayResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? reference;
  int? amount;
  String? currency;
  String? status;
  String? checkoutUrl;
  String? paymentUrl;
  String? environment;
  String? expiresAt;

  Data(
      {this.id,
        this.reference,
        this.amount,
        this.currency,
        this.status,
        this.checkoutUrl,
        this.paymentUrl,
        this.environment,
        this.expiresAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    checkoutUrl = json['checkout_url'];
    paymentUrl = json['payment_url'];
    environment = json['environment'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['status'] = this.status;
    data['checkout_url'] = this.checkoutUrl;
    data['payment_url'] = this.paymentUrl;
    data['environment'] = this.environment;
    data['expires_at'] = this.expiresAt;
    return data;
  }
}