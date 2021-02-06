import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hookie_twitter/src/app.dart';
import 'package:hookie_twitter/src/appstate_container.dart';

import 'package:hookie_twitter/src/service_locator.dart';
import 'package:hookie_twitter/src/utils/loader.dart';
import 'package:logger/logger.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();

  MpesaFlutterPlugin.setConsumerKey('tGJZu0o3ThmmxUuopGVMlo6K5wGHPfJT');
  MpesaFlutterPlugin.setConsumerSecret('75WatKc0iaB6Fus0');

  // Setup Service Provider
  setupServiceLocator();

  // Setup logger, only show warning and higher in release mode.
  if (kReleaseMode) {
    Logger.level = Level.warning;
  } else {
    Logger.level = Level.debug;
  }
  // runApp(MyApp());

  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]).then(
    (_) {
      configLoading();
      runApp(
        StateContainer(
          child: new App(),
        ),
      );
    },
  );
}
