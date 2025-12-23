import 'package:dio/dio.dart';
import 'package:tickup/models/Request/genuis_pay_request.dart';
import 'package:tickup/models/response/genuis_pay_response.dart';
import 'package:tickup/ressources/utils/base_url.dart';
import 'package:tickup/web_services/dio_client/dio_client.dart';

import '../../models/request/paiement_pro_request.dart';
import '../../models/response/paiement_pro_response.dart';
import '../services/paiements/paiement_service.dart';

class PaiementImpl implements PaiementService {
  final dioClient = DioClient();

  @override


  @override
  Future<GenuisPayResponse> initierPaiement(GenuisPayRequest request) async {
    try {
      print("Initiating payment with request: ${request.toJson()}");
      final response = await dioClient.dio.post(
        baseUrl + '/payments',
        data: request.toJson(),
        options: Options(
          headers: {
            'X-API-Key': apiKey,
            'X-API-Secret': apiSecret,
            'Content-Type': 'application/json',
          },
        ),
      );
      print("Payment initiation response: ${response.statusCode}");
      return GenuisPayResponse.fromJson(response.data);
    } on DioException catch (e) {
      return GenuisPayResponse(
        success: false,
        data: e.response != null
            ? Data.fromJson(e.response!.data)
            : null,
      );
    }
  }}