

import 'package:tickup/models/Request/usager_request.dart';

abstract class UsagerService {
  Future<UsagerRequest> saveUsager(UsagerRequest usagerRequest);

}