// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
//
// import '../model/instrument_qr_code_data.dart';
//
//
//
// class QrCodeCryptoHelper {
//   //Clef de chiffrement
//   static final Key _key =
//       Key.fromUtf8('my32lengthsupersecretnooneknows1'); // 16 chars
//   static final IV _iv = IV.fromLength(16);
//   static final Encrypter _encrypter = Encrypter(AES(_key));
//
//   //Méthode de chiffrement
//   static String chiffrerQrCode(InstrumentQrCodeData data) {
//     print('chiffrerQrCode vi ::::::::::::::::${_iv.base64}');
//     final plainText = jsonEncode(data.toJson());
//     final encrypted = _encrypter.encrypt(plainText, iv: _iv);
//     return encrypted.base64;
//   }
//
//   //Méthode de déchiffrement
//   static InstrumentQrCodeData? dechiffrerQrCode(String base64Data) {
//     try {
//       print("qr code data ::::::::::::::::${base64Data}");
//       print("dechiffrerQrCode vi ::::::::::::::::${_iv.base64}");
//       final decrypted = _encrypter.decrypt64(base64Data, iv: _iv);
//       final jsonData = jsonDecode(decrypted);
//       return InstrumentQrCodeData.fromJson(jsonData);
//     } catch (e) {
//       print("Erreur de déchiffrement: $e");
//       throw Exception("Erreur de déchiffrement: $e");
//     }
//   }
// }
