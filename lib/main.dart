import 'package:events_jo/config/app.dart';
import 'package:events_jo/config/utils/enviroment.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'config/firebase_options.dart';

void main() async {
  try {
    //load env variables
    await Environment.load();

    //Widgetsbinding to be initialized before running app
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    //preserve splash screen
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    //firebase setup
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarContrastEnforced: true,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: GColors.scaffoldBg,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    runApp(EventsJoApp());
  } catch (e) {
    print('API KEY: ${Environment.apiKeyWeb}');
    print(e);
  }
}
