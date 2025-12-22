import 'package:dio/dio.dart';
import 'package:tickup/models/response/notchpay_response_model.dart';
import 'package:tickup/ressources/utils/base_url.dart';
import 'package:tickup/web_services/dio_client/api_error_handler.dart';
import 'package:tickup/web_services/dio_client/dio_client.dart';
import 'package:tickup/web_services/services/notchpay/notchpay_service.dart';

class NotchPayImpl extends NotchpayService {
  final dioClient = DioClient();
  @override
  Future<NotchPayResponse> initierPaiement(NotchPayRequest request,) async {
    try {
      print(" request: ${request.toJson()}");

      final response = await dioClient.dio.post(
        "$baseUrl/marchands",
        data: request.toJson(),
      );

      print(" Création statut: ${response.statusCode}");
      print(" Response paiement   ::: ${response.data}");
      return NotchPayResponse.fromJson(response.data);
    } on DioException catch (error) {
      print("Une erreur est survenue lors du paiement: ${error.message}");
      throw ApiErrorHandler.handle(error);
    } catch (e) {
      rethrow;
    }
  }
}