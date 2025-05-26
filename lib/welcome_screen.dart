import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8ECC9), // Light cream/pale yellow
              Color(0xFFE4D547), // Bright yellow
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Train logo without white background
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/images/download3.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 40),
                // Welcome text
                const Text(
                  'Welcome to E-Season',
                  style: TextStyle(
                    fontFamily: 'Railway',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4D4238), // Dark brown/gray
                  ),
                ),
                const SizedBox(height: 16),
                // Subtitle
                Text(
                  'Your seasonal companion',
                  style: TextStyle(
                    fontFamily: 'Railway',
                    fontSize: 18,
                    color: const Color(0xFF4D4238).withOpacity(0.8), // Dark brown/gray with opacity
                  ),
                ),
                const SizedBox(height: 60),
                // Animated Get Started button with shadow
                GestureDetector(
                  onTapDown: (_) {
                    setState(() {
                      _isPressed = true;
                    });
                    _animationController.forward();
                  },
                  onTapUp: (_) {
                    setState(() {
                      _isPressed = false;
                    });
                    _animationController.reverse();
                    // Navigation to LoginScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  onTapCancel: () {
                    setState(() {
                      _isPressed = false;
                    });
                    _animationController.reverse();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    transform: _isPressed 
                        ? Matrix4.translationValues(0, 2, 0)
                        : Matrix4.translationValues(0, 0, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50), // Green
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4CAF50).withOpacity(_isPressed ? 0.3 : 0.6),
                          spreadRadius: _isPressed ? 1 : 3,
                          blurRadius: _isPressed ? 3 : 10,
                          offset: Offset(0, _isPressed ? 2 : 5),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontFamily: 'Railway',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
