import 'package:flutter/material.dart';
import 'models/service.dart';
import 'screens/detail_screen.dart';
import 'screens/order_screen.dart';
import 'widgets/nav_shell.dart';

void main() => runApp(const SobatBeresApp());

class SobatBeresApp extends StatelessWidget {
  const SobatBeresApp({super.key});

  static const _primary = Color(0xFF2563EB);
  static const _secondary = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SobatBeres',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primary,
          primary: _primary,
          secondary: _secondary,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: _primary,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      home: const NavShell(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/detail':
            return MaterialPageRoute(
              builder: (_) => DetailScreen(service: settings.arguments as ServiceModel),
            );
          case '/order':
            return MaterialPageRoute(
              builder: (_) => OrderScreen(service: settings.arguments as ServiceModel?),
            );
          default:
            return null;
        }
      },
    );
  }
}
