import 'package:tickup/models/notchpay_response_model.dart';

abstract class NotchpayService {
  Future<NotchPayRequest> initierPaiement(NotchPayRequest notchPay);
}