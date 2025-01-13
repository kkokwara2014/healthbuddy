import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_buddy/constants/color.dart';
import 'package:health_buddy/providers/appointment_provider.dart';
import 'package:health_buddy/providers/auth_user_provider.dart';
import 'package:health_buddy/providers/bmi_provider.dart';
import 'package:health_buddy/providers/user_provider.dart';
import 'package:health_buddy/screens/authentication/check_loggedin.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthUserProvider>(
            create: (context) => AuthUserProvider()),
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
        ChangeNotifierProvider<AppointmentProvider>(
            create: (context) => AppointmentProvider()),
        ChangeNotifierProvider<BMIProvider>(create: (context) => BMIProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Health Buddy',
        theme: ThemeData(
          primarySwatch: pkColor,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
          ),
        ),
        home: const CheckLoggedInUser(),
      ),
    );
  }
}
