import 'package:tickup/models/evenement_model.dart';

abstract class EvenementService {
Future<List<EvenementModel>> getAllEvenements();
}