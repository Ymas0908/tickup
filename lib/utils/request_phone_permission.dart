import 'package:permission_handler/permission_handler.dart';

Future<void> requestPhonePermission() async {
  var phoneResultStatus = await Permission.phone.status;
  var cameraResultStatus = await Permission.camera.request();
  if (!phoneResultStatus.isGranted) {
    await Permission.phone.request();
  }

  if (!cameraResultStatus.isGranted) {
    await Permission.camera.request();
  }
}
Future<bool> checkCallPermission() async {
  if (await Permission.phone.request().isGranted) {
    return true;
  }
  return false;
}