import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_landing_course/core/res/colors.dart';
import 'package:job_landing_course/core/res/fonts.dart';
import 'package:job_landing_course/core/services/injector_container.dart';
import 'package:job_landing_course/core/services/router.dart';
import 'package:job_landing_course/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Education App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColor),
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
        ),
        useMaterial3: true,
        fontFamily: Fonts.poppins,
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
