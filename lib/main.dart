import 'package:flutter/material.dart';

Future<void> main() async
{

  WidgetsFlutterBinding.ensureInitialized();
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
      home: Scaffold(),
    );
  }
}

