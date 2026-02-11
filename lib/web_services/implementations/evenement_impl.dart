import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tickup/models/evenement_model.dart';
import 'package:tickup/ressources/utils/base_url.dart';
import 'package:tickup/web_services/dio_client/api_error_handler.dart';
import 'package:tickup/web_services/dio_client/dio_client.dart';
import 'package:tickup/web_services/services/evenements/evenements_service.dart';



class EvenementImpl extends EvenementService {
  final dioClient = DioClient();

  @override
  Future<List<EvenementModel>> getAllEvenements() async {
    try {
      final response = await dioClient.dio.get(
        "$baseUrl/events");

      print("Response DIO ::::::::::: ${response.data}");
      print("Statut DIO ::::::::::::${response.statusCode}");
      final List<dynamic> data = response.data;
      return data.map((e) => EvenementModel.fromJson(e)).toList();
    } on DioException catch (error) {
      print("Une erreur est survenue ${error.message}");
      throw ApiErrorHandler.handle(error);
    }
  }





  }
