import 'package:e_season/dashboard_screen.dart';
import 'package:e_season/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoginButtonPressed = false;
  bool _isSignupButtonPressed = false;
  bool _isGoogleButtonPressed = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          child: Column(
            children: [
              // Back button and logo
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF4D4238),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                    Container(
                      width: 50,
                      height: 50,
                      child: Image.asset(
                        'assets/images/download3.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Tab bar for Login/Signup
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: const Color(0xFFFF5E0E), // Vibrant orange
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF5E0E).withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xFF4D4238),
                  labelStyle: const TextStyle(
                    fontFamily: 'Railway',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontFamily: 'Railway',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  tabs: const [Tab(text: 'Login'), Tab(text: 'Sign Up')],
                ),
              ),

              const SizedBox(height: 30),

              // Tab content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Login Tab
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            // Email field
                            TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontFamily: 'Railway',
                                  color: const Color(
                                    0xFF4D4238,
                                  ).withOpacity(0.7),
                                ),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Color(0xFF4D4238),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Password field
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  fontFamily: 'Railway',
                                  color: const Color(
                                    0xFF4D4238,
                                  ).withOpacity(0.7),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Color(0xFF4D4238),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Forgot password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Forgot password logic
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontFamily: 'Railway',
                                    color: Color(0xFF4D4238),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Login button
                            GestureDetector(
                              onTapDown: (_) {
                                setState(() {
                                  _isLoginButtonPressed = true;
                                });
                              },
                              onTapUp: (_) {
                                setState(() {
                                  _isLoginButtonPressed = false;
                                });
                                // Navigate to RootScreen instead of DashboardScreen
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RootScreen(),
                                  ),
                                );
                              },
                              onTapCancel: () {
                                setState(() {
                                  _isLoginButtonPressed = false;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                transform:
                                    _isLoginButtonPressed
                                        ? Matrix4.translationValues(0, 2, 0)
                                        : Matrix4.translationValues(0, 0, 0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4CAF50), // Green
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF4CAF50,
                                      ).withOpacity(
                                        _isLoginButtonPressed ? 0.3 : 0.6,
                                      ),
                                      spreadRadius:
                                          _isLoginButtonPressed ? 1 : 3,
                                      blurRadius:
                                          _isLoginButtonPressed ? 3 : 10,
                                      offset: Offset(
                                        0,
                                        _isLoginButtonPressed ? 2 : 5,
                                      ),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontFamily: 'Railway',
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),

                    // Sign Up Tab
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            // Name field
                            TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                hintText: 'Full Name',
                                hintStyle: TextStyle(
                                  fontFamily: 'Railway',
                                  color: const Color(
                                    0xFF4D4238,
                                  ).withOpacity(0.7),
                                ),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Color(0xFF4D4238),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Email field
                            TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontFamily: 'Railway',
                                  color: const Color(
                                    0xFF4D4238,
                                  ).withOpacity(0.7),
                                ),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Color(0xFF4D4238),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Password field
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  fontFamily: 'Railway',
                                  color: const Color(
                                    0xFF4D4238,
                                  ).withOpacity(0.7),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Color(0xFF4D4238),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Confirm Password field
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                  fontFamily: 'Railway',
                                  color: const Color(
                                    0xFF4D4238,
                                  ).withOpacity(0.7),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Color(0xFF4D4238),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Sign Up button
                            GestureDetector(
                              onTapDown: (_) {
                                setState(() {
                                  _isSignupButtonPressed = true;
                                });
                              },
                              onTapUp: (_) {
                                setState(() {
                                  _isSignupButtonPressed = false;
                                });
                                // Sign up logic
                              },
                              onTapCancel: () {
                                setState(() {
                                  _isSignupButtonPressed = false;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                transform:
                                    _isSignupButtonPressed
                                        ? Matrix4.translationValues(0, 2, 0)
                                        : Matrix4.translationValues(0, 0, 0),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFFF5E0E,
                                  ), // Vibrant orange
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFFFF5E0E,
                                      ).withOpacity(
                                        _isSignupButtonPressed ? 0.3 : 0.6,
                                      ),
                                      spreadRadius:
                                          _isSignupButtonPressed ? 1 : 3,
                                      blurRadius:
                                          _isSignupButtonPressed ? 3 : 10,
                                      offset: Offset(
                                        0,
                                        _isSignupButtonPressed ? 2 : 5,
                                      ),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontFamily: 'Railway',
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
