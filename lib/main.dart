import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/splashScreen/splash_screen.dart';


Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();

  const FirebaseOptions firebaseOptions = FirebaseOptions(
    projectId: "projectId",
    appId: "appId",
    messagingSenderId: "messagingSenderId",
    apiKey: "apiKey",
    storageBucket: "foodie-network-f9f95.appspot.com"
  );

   Firebase.initializeApp(
    //name: "name",
    options: firebaseOptions,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodie Network',
      theme: ThemeData(brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(160, 50, 234, 179)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

