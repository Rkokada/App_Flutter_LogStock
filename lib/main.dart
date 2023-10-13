import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:logstock/firebase_options.dart';
import 'package:logstock/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:logstock/src/utils/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterNativeSplash.remove();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 300),
      home: SplashScreen(),
      // home: Scaffold(
      //   body: Center(
      //     child: CircularProgressIndicator(),
      //   ),
      // ),
    );
  }
}
