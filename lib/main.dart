import 'package:events_jo/config/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config/firebase_options.dart';

void main() async {
  //load env variables
  await dotenv.load(fileName: '.env');

  //Widgetsbinding to be initialized before running app
  WidgetsFlutterBinding.ensureInitialized();

  //firebase setup
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}
