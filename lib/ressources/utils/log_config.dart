import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final customLogger = Logger(level: kDebugMode ? Level.debug : Level.off);
