import 'package:flutter/material.dart';
import 'package:tidyo/Core/Theme/AppTokens.dart';
import 'package:tidyo/Features/Shell/Presentation/Screens/AppShell.dart';

class TidyoApp extends StatelessWidget {
  const TidyoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tidyo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: Tk.font,
        scaffoldBackgroundColor: Tk.bgBottom,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Tk.teal,
          primary: Tk.green,
          secondary: Tk.teal,
        ),
      ),
      home: const AppShell(),
    );
  }
}
