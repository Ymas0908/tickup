import 'package:flutter/cupertino.dart';
import 'package:tickup/models/Request/genuis_pay_request.dart';
import 'package:tickup/models/enum/Payement_methode.dart';
import 'package:tickup/ressources/utils/log_config.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../web_services/services/paiements/paiement_service.dart';

class PaiementViewModel extends ChangeNotifier {
  final PaiementService paiementService;

  PaiementViewModel({required this.paiementService,});

  final TextEditingController amountController = TextEditingController();
  bool isLoading = false;
  String paymentUrl = '';
  String errorMessage = '';
  PayementMethode? selectedMethode;
  List<PayementMethode> paymentMethodes = [
    PayementMethode.wave,

  ];


  Future<void> initPaiement() async {
    isLoading = true;
    notifyListeners();

    try {
      final request = GenuisPayRequest(
        amount: 2000,
        description: 'Test Genuis Pay',
        currency: 'XOF',
      );

      final response = await paiementService.initierPaiement(request);
      customLogger.i(response.data?.toString());

      // 1. Vérification de la réponse
      if (response.success == true && response.data != null) {
        final checkoutUrl = response.data?.checkoutUrl ?? response.data?.paymentUrl;
        if (checkoutUrl != null && checkoutUrl.isNotEmpty) {
          customLogger.i('URL de paiement: $checkoutUrl');
          // 2. Lancement de l'URL
          final uri = Uri.parse(checkoutUrl);
          await launchUrl(uri, mode: LaunchMode.platformDefault, // Ouvre dans le navigateur
          );
        }
      }
    } catch (error) {
      customLogger.e('Erreur lors du paiement: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }}
