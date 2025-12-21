class PaiementProRequest {
  String? merchantId;
  int? amount; /* Montant a payer */
  String? description; /* Description pour le paiement obligatoire */
  String? channel; /* Mode paiement */
  String? countryCurrencyCode; /* Code de la devise: FCFA par défaut */
  String? referenceNumber; /* Référence de la transaction */
  String? customerEmail; /* Email de l'utilisateur */
  String? customerFirstName; /* Nom de l'utilisateur */
  String? customerLastname; /* Prénoms de l'utilisateur */
  String? customerPhoneNumber; /* Contact de l'utilisateur */
  String? notificationURL; /* URL de notification */
  String? returnURL; /* URL de retour après paiement */
  String? returnContext; /* Données présentes dans returnURL */
  String? url; /* Url de paiement */
  String? message; /* Message */
  bool success; /* Initialisation du paiement */

  PaiementProRequest({
    this.merchantId = '',
    this.amount = 0,
    this.description = '',
    this.channel = '',
    this.countryCurrencyCode = '952',
    this.referenceNumber = '',
    this.customerEmail = '',
    this.customerFirstName = '',
    this.customerLastname = '',
    this.customerPhoneNumber = '',
    this.notificationURL = '',
    this.returnURL = '',
    this.returnContext = '',
    this.url = '',
    this.message = '',
    this.success = false,
  });

  /// FROM JSON
  factory PaiementProRequest.fromJson(Map<String, dynamic> json) {
    return PaiementProRequest(
      merchantId: json['merchantId'] ?? '',
      amount: json['amount'] ?? 0,
      description: json['description'] ?? '',
      channel: json['channel'] ?? '',
      countryCurrencyCode: json['countryCurrencyCode'] ?? '952',
      referenceNumber: json['referenceNumber'] ?? '',
      customerEmail: json['customerEmail'] ?? '',
      customerFirstName: json['customerFirstName'] ?? '',
      customerLastname: json['customerLastname'] ?? '',
      customerPhoneNumber: json['customerPhoneNumber'] ?? '',
      notificationURL: json['notificationURL'] ?? '',
      returnURL: json['returnURL'] ?? '',
      returnContext: json['returnContext'] ?? '',
      url: json['url'] ?? '',
      message: json['message'] ?? '',
      success: json['success'] ?? false,
    );
  }

  /// TO JSON
  Map<String, dynamic> toJson() {
    return {
      'merchantId': merchantId,
      'amount': amount,
      'description': description,
      'channel': channel,
      'countryCurrencyCode': countryCurrencyCode,
      'referenceNumber': referenceNumber,
      'customerEmail': customerEmail,
      'customerFirstName': customerFirstName,
      'customerLastname': customerLastname,
      'customerPhoneNumber': customerPhoneNumber,
      'notificationURL': notificationURL,
      'returnURL': returnURL,
      'returnContext': returnContext,
      'url': url,
      'message': message,
      'success': success,
    };
  }
}
