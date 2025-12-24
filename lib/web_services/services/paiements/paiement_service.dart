import 'package:tickup/models/Request/genuis_pay_request.dart';
import 'package:tickup/models/response/genuis_pay_response.dart';


abstract class PaiementService {
  Future<GenuisPayResponse> initierPaiement(GenuisPayRequest request);

}