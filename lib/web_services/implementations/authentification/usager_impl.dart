

import 'package:dio/dio.dart';
import 'package:tickup/models/Request/usager_request.dart';
import 'package:tickup/ressources/utils/log_config.dart';
import 'package:tickup/web_services/dio_client/api_error_handler.dart';
import 'package:tickup/web_services/dio_client/dio_client.dart';
import 'package:tickup/web_services/services/merchant_services.dart';

class UsagerImpl implements UsagerService {
  final dioClient = DioClient();

  @override
  Future<UsagerRequest> saveUsager(UsagerRequest usagerRequest) async {
    try {
      print(" request: ${usagerRequest.toJson()}");

      final response = await dioClient.dio.post(
        "/usagers/usager",
        data: usagerRequest.toJson(),
      );

      customLogger.i(" Response enrollment merchant  ::: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UsagerRequest.fromJson(response.data);
      } else {
        customLogger.i(" Erreur lors de la création du usager  ::: ${response.statusCode}");
        throw Exception('Erreur lors de la création du usager: ${response.statusCode}');

      }
    } on DioException catch (error) {
      throw ApiErrorHandler.handle(error);
    } catch (e) {
      rethrow;
    }
  }
}