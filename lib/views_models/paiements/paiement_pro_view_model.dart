import 'package:flutter/cupertino.dart';
import 'package:tickup/models/Request/genuis_pay_request.dart';
import 'package:tickup/models/enum/Payement_methode.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/request/paiement_pro_request.dart';
import '../../web_services/services/paiements/paiement_service.dart';

class PaiementViewModel extends ChangeNotifier {
  final PaiementService paiementService;

  PaiementViewModel({required this.paiementService,});

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
      print(response);

      // 1. Vérification de la réponse
      if (response.success == true && response.data != null) {
        final checkoutUrl = response.data?.checkoutUrl ??
            response.data?.paymentUrl;

        if (checkoutUrl != null && checkoutUrl.isNotEmpty) {
          print('URL de paiement: $checkoutUrl');

          // 2. Lancement de l'URL
          final uri = Uri.parse(checkoutUrl);
          await launchUrl(
            uri,
            mode: LaunchMode.platformDefault, // Ouvre dans le navigateur
          );
          // if (await canLaunchUrl(uri)) {
          //   await launchUrl(
          //     uri,
          //     // mode: LaunchMode.externalApplication, // Ouvre dans le navigateur
          //   );
          // } else {
          //   print('Impossible de lancer l\'URL: $checkoutUrl');
          //   // Option: Afficher un message d'erreur à l'utilisateur
          // }
        } else {
          print('URL de paiement non trouvée dans la réponse');
        }
      } else {
        // print('Échec de l\'API: ${response['message'] ?? 'Raison inconnue'}');
      }
    } catch (error) {
      print('Erreur lors du paiement: $error');
      // Gérer l'erreur (afficher un SnackBar, etc.)
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }}
