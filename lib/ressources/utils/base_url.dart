

import 'dart:io';

String genuisPayurl = 'https://pay.genius.ci/api/v1/merchant';

// Configuration pour backend Dockerisé avec support multi-plateforme
String get baseUrlbackend {
  if (Platform.isAndroid) {
    // Pour Android émulateur, 10.0.2.2 pointe vers le localhost de la machine hôte
    return 'http://10.0.2.2:5000/api/';
    return 'http://192.168.30.12:9000/api/v1';
  } else {
    // Pour iOS simulator, web, et autres plateformes
    return 'http://localhost:5000/api/';
  }
}

 String apiKey = 'pk_sandbox_n7XaEDWKmcLbzQAteWpa1MbfIpa0VPTr';
 String apiSecret = 'sk_sandbox_aa0a8d662b96a85719e44d7e250e918f1bf274f66b1fe3849038285e6649c2d3';
