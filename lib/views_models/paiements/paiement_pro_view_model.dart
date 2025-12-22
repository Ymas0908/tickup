import 'package:flutter/cupertino.dart';

import '../../models/request/paiement_pro_request.dart';
import '../../web_services/services/paiements/paiement_service.dart';

class PaiementViewModel extends ChangeNotifier {
  final PaiementService paiementService;

  PaiementViewModel({required this.paiementService,});

  bool isLoading = false;
  String paymentUrl = '';
  String errorMessage = '';

  Future<void> initPaiement() async {
    isLoading = true;
    notifyListeners();

    final request = PaiementProRequest(
      merchantId: 'PP-F324',
      amount: 1000,
      description: 'Api flutter',
      channel: 'WAVECI',
      referenceNumber: '0123456789',
      customerEmail: 'test@gmail.com',
      customerFirstName: 'Ishola',
      customerLastname: 'Lamine',
      customerPhoneNumber: '0123456789',
    );

    final response = await paiementService.initPaiementPro(request);
      print(response);
    if (response.success && response.url != null) {
      paymentUrl = response.url!;
      errorMessage = '';
    } else {
      paymentUrl = '';
      errorMessage = response.message ?? 'Erreur inconnue';
    }

    isLoading = false;
    notifyListeners();
  }
}
