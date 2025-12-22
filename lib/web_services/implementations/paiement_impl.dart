import 'package:dio/dio.dart';
import 'package:tickup/web_services/dio_client/dio_client.dart';

import '../../models/request/paiement_pro_request.dart';
import '../../models/response/paiement_pro_response.dart';
import '../services/paiements/paiement_service.dart';

class PaiementImpl implements PaiementService {
  final dioClient = DioClient();

  @override
  Future<PaiementProResponse> initPaiementPro(PaiementProRequest request) async {
    try {
      final response = await dioClient.dio.post(
        'https://sandbox.paiementpro.net/webservice/onlinepayment/init/curl-init.php',
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      return PaiementProResponse.fromJson(response.data);
    } on DioException catch (e) {
      return PaiementProResponse(
        success: false,
        message: e.message,
      );
    }
  }}