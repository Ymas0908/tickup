



import 'package:package_info_plus/package_info_plus.dart';

import '../../utils/log_config.dart';

class AppInfoService {
  late final String version;
  late final String build;

  Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    build = packageInfo.buildNumber;

    customLogger.i("APP VERSION :::: $version");
    customLogger.i("APP BUILD :::: $build");
  }
}
