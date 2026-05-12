import 'package:base_app_clean_arch/bootstrap.dart';
import 'package:base_app_clean_arch/core/environment/environment_enum.dart';
import 'package:base_app_clean_arch/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Bootstrap.initializeApp(environment: EnvironmentEnum.production);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(const MyApp());
  });
}
