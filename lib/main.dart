import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'widgets/bottom_navigation_bar.dart';
import 'services/auth_service.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Check if user is logged in
  final bool isLoggedIn = await AuthService.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Season',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4A90E2),
        fontFamily: 'Railway',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A90E2)),
        useMaterial3: true,
      ),
      // Use RootScreen as home if logged in, otherwise use WelcomeScreen
      home: isLoggedIn ? const RootScreen() : const WelcomeScreen(),
    );
  }
}
