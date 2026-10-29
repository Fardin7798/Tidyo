import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tidyo/Config/Injection/InjectionContainer.dart';
import 'package:tidyo/Features/Dashboard/Presentation/Providers/DashboardProvider.dart';
import 'package:tidyo/Features/JunkScanner/Presentation/Providers/JunkScannerProvider.dart';
import 'package:tidyo/Features/StorageAnalyzer/Presentation/Providers/StorageAnalyzerProvider.dart';
import 'package:tidyo/Features/DeepClean/Presentation/Providers/DeepCleanProvider.dart';
import 'package:tidyo/Features/AppCache/Presentation/Providers/AppCacheProvider.dart';
import 'package:tidyo/Features/ResidualFiles/Presentation/Providers/ResidualFilesProvider.dart';
import 'package:tidyo/Features/LogsTemp/Presentation/Providers/LogsTempProvider.dart';
import 'package:tidyo/Features/Settings/Presentation/Providers/SettingsProvider.dart';
import 'package:tidyo/Core/Theme/AppTokens.dart';
import 'package:tidyo/Core/Widgets/ErrorBoundary.dart';
import 'package:tidyo/Features/Shell/Presentation/Screens/AppShell.dart';

class TidyoApp extends StatelessWidget {
  const TidyoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<DashboardProvider>()),
        ChangeNotifierProvider(create: (_) => sl<JunkScannerProvider>()),
        ChangeNotifierProvider(create: (_) => sl<StorageAnalyzerProvider>()),
        ChangeNotifierProvider(create: (_) => sl<DeepCleanProvider>()),
        ChangeNotifierProvider(create: (_) => sl<AppCacheProvider>()),
        ChangeNotifierProvider(create: (_) => sl<ResidualFilesProvider>()),
        ChangeNotifierProvider(create: (_) => sl<LogsTempProvider>()),
        ChangeNotifierProvider(create: (_) => sl<SettingsProvider>()),
      ],
      child: MaterialApp(
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
      builder: (context, child) => ErrorBoundary(child: child!),
      home: const AppShell(),
      ),
    );
  }
}
