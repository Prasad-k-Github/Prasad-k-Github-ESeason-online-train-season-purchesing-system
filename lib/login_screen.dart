import 'package:e_season/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:e_season/services/auth_service.dart';
import 'package:e_season/models/auth_models.dart';

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

  // Text controllers to get user input
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();
  final TextEditingController _signupEmailController = TextEditingController();
  final TextEditingController _signupPasswordController =
      TextEditingController();

  // Additional controllers for signup form
  final TextEditingController _nameWithInitialsController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _fromStationController = TextEditingController();
  final TextEditingController _toStationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Loading state
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    _nameWithInitialsController.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _fromStationController.dispose();
    _toStationController.dispose();
    _dateController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Date picker method
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  // Handle login logic
  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // In a real app, you would make an API call here
      // For now, we'll simulate a successful login
      final String email = _loginEmailController.text.trim();
      final String password = _loginPasswordController.text;

      if (email.isEmpty || password.isEmpty) {
        setState(() {
          _errorMessage = 'Please fill in all fields';
          _isLoading = false;
        });
        return;
      }

      // Simulate token from API
      const String mockToken = 'mock_auth_token';
      // Create user data
      final userData = UserData(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        fullName: 'Default User', // Update with actual name when available
      );

      // Save auth data to local storage
      await AuthService.saveAuthData(mockToken, userData);

      // Navigate to home screen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RootScreen()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Login failed: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Handle signup logic
  Future<void> _handleSignup() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Get all form data
      final String nameWithInitials = _nameWithInitialsController.text.trim();
      final String fullName = _fullNameController.text.trim();
      final String address = _addressController.text.trim();
      final String phoneNumber = _phoneNumberController.text.trim();
      final String email = _signupEmailController.text.trim();
      final String fromStation = _fromStationController.text.trim();
      final String toStation = _toStationController.text.trim();
      final String date = _dateController.text.trim();
      final String password = _signupPasswordController.text;
      final String confirmPassword = _confirmPasswordController.text;

      // Validation
      if (email.isEmpty || password.isEmpty) {
        setState(() {
          _errorMessage = 'Email and password are required';
          _isLoading = false;
        });
        return;
      }

      if (password != confirmPassword) {
        setState(() {
          _errorMessage = 'Passwords do not match';
          _isLoading = false;
        });
        return;
      }

      if (password.length < 6) {
        setState(() {
          _errorMessage = 'Password must be at least 6 characters';
          _isLoading = false;
        });
        return;
      }

      // Simulate token from API
      const String mockToken = 'mock_auth_token';
      // Create user data
      final userData = UserData(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        fullName: fullName.isNotEmpty ? fullName : nameWithInitials,
      );

      // Save auth data to local storage
      await AuthService.saveAuthData(mockToken, userData);

      // Navigate to home screen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RootScreen()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Signup failed: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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

              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const SizedBox(height: 10),

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
                              controller: _loginEmailController,
                              keyboardType: TextInputType.emailAddress,
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
                              controller: _loginPasswordController,
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
                            _isLoading
                                ? const CircularProgressIndicator(
                                  color: Color(0xFF4CAF50),
                                )
                                : GestureDetector(
                                  onTapDown: (_) {
                                    setState(() {
                                      _isLoginButtonPressed = true;
                                    });
                                  },
                                  onTapUp: (_) async {
                                    setState(() {
                                      _isLoginButtonPressed = false;
                                    });
                                    await _handleLogin();
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
                                            : Matrix4.translationValues(
                                              0,
                                              0,
                                              0,
                                            ),
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
                            // Name with initials
                            TextField(
                              controller: _nameWithInitialsController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                hintText: 'Name with Initials',
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
                            // Full name
                            TextField(
                              controller: _fullNameController,
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
                                  Icons.person_outline,
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
                            // Address
                            TextField(
                              controller: _addressController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                hintText: 'Address',
                                hintStyle: TextStyle(
                                  fontFamily: 'Railway',
                                  color: const Color(
                                    0xFF4D4238,
                                  ).withOpacity(0.7),
                                ),
                                prefixIcon: const Icon(
                                  Icons.home,
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
                            // Phone number
                            TextField(
                              controller: _phoneNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(
                                  fontFamily: 'Railway',
                                  color: const Color(
                                    0xFF4D4238,
                                  ).withOpacity(0.7),
                                ),
                                prefixIcon: const Icon(
                                  Icons.phone,
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
                            // Email
                            TextField(
                              controller: _signupEmailController,
                              keyboardType: TextInputType.emailAddress,
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
                            // From station
                            TextField(
                              controller: _fromStationController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                hintText: 'From Station',
                                hintStyle: TextStyle(
                                  fontFamily: 'Railway',
                                  color: const Color(
                                    0xFF4D4238,
                                  ).withOpacity(0.7),
                                ),
                                prefixIcon: const Icon(
                                  Icons.train,
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
                            // To station
                            TextField(
                              controller: _toStationController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                hintText: 'To Station',
                                hintStyle: TextStyle(
                                  fontFamily: 'Railway',
                                  color: const Color(
                                    0xFF4D4238,
                                  ).withOpacity(0.7),
                                ),
                                prefixIcon: const Icon(
                                  Icons.location_on,
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
                            // Date picker
                            GestureDetector(
                              onTap: _pickDate,
                              child: AbsorbPointer(
                                child: TextField(
                                  controller: _dateController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.7),
                                    hintText: 'Date',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Railway',
                                      color: const Color(
                                        0xFF4D4238,
                                      ).withOpacity(0.7),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.calendar_today,
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
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Create password
                            TextField(
                              controller: _signupPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                hintText: 'Create Password',
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
                            // Confirm password
                            TextField(
                              controller: _confirmPasswordController,
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
                                  Icons.lock_outline,
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
                            _isLoading
                                ? const CircularProgressIndicator(
                                  color: Color(0xFFFF5E0E),
                                )
                                : GestureDetector(
                                  onTapDown: (_) {
                                    setState(() {
                                      _isSignupButtonPressed = true;
                                    });
                                  },
                                  onTapUp: (_) async {
                                    setState(() {
                                      _isSignupButtonPressed = false;
                                    });
                                    await _handleSignup();
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
                                            : Matrix4.translationValues(
                                              0,
                                              0,
                                              0,
                                            ),
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
