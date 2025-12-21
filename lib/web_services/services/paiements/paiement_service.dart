import '../../../models/request/paiement_pro_request.dart';
import '../../../models/response/paiement_pro_response.dart';

abstract class PaiementService {
  Future<PaiementProResponse> initPaiementPro(PaiementProRequest request);
}