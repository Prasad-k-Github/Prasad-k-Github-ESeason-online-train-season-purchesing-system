import 'package:flutter/material.dart';
import 'package:e_season/services/auth_service.dart';
import 'package:e_season/models/auth_models.dart';
import 'package:e_season/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserData? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userData = await AuthService.getUserData();
      setState(() {
        _userData = userData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading profile: ${e.toString()}')),
      );
    }
  }

  Future<void> _handleLogout() async {
    try {
      await AuthService.logout();
      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: ${e.toString()}')),
      );
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFFF5E0E),
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 16),
                _isLoading
                    ? const CircularProgressIndicator()
                    : Column(
                      children: [
                        Text(
                          _userData?.fullName ?? 'User',
                          style: const TextStyle(
                            fontFamily: 'Railway',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4D4238),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _userData?.email ?? 'No email available',
                          style: TextStyle(
                            fontFamily: 'Railway',
                            fontSize: 16,
                            color: const Color(0xFF4D4238).withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                const SizedBox(height: 32),
                _buildProfileSection('Personal Information', [
                  _buildProfileItem(
                    Icons.person,
                    'Name with Initials',
                    _userData?.nameWithInitials ?? 'Not provided',
                  ),
                  _buildProfileItem(
                    Icons.phone,
                    'Phone',
                    _userData?.phone ?? 'Not provided',
                  ),
                  _buildProfileItem(
                    Icons.location_on,
                    'Address',
                    _userData?.address ?? 'Not provided',
                  ),
                ]),
                _buildProfileSection('Travel Information', [
                  _buildProfileItem(
                    Icons.train,
                    'From Station',
                    _userData?.fromStation ?? 'Not provided',
                  ),
                  _buildProfileItem(
                    Icons.train,
                    'To Station',
                    _userData?.toStation ?? 'Not provided',
                  ),
                  _buildProfileItem(
                    Icons.calendar_today,
                    'Travel Date',
                    _userData?.travelDate ?? 'Not provided',
                  ),
                ]),

                // Logout button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _handleLogout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5E0E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontFamily: 'Railway',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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

  Widget _buildProfileSection(String title, List<Widget> items) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Railway',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4D4238),
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFF5E0E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFFFF5E0E), size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Railway',
                  fontSize: 14,
                  color: const Color(0xFF4D4238).withOpacity(0.7),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Railway',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4D4238),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
