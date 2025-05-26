import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontFamily: 'Railway',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4D4238),
                  ),
                ),
                Text(
                  'john.doe@example.com',
                  style: TextStyle(
                    fontFamily: 'Railway',
                    fontSize: 16,
                    color: const Color(0xFF4D4238).withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 32),
                _buildProfileSection(
                  'Personal Information',
                  [
                    _buildProfileItem(Icons.phone, 'Phone', '+1 234 567 890'),
                    _buildProfileItem(Icons.location_on, 'Address', '123 Railway Street, City'),
                    _buildProfileItem(Icons.calendar_today, 'Date of Birth', '01/01/1990'),
                  ],
                ),
                _buildProfileSection(
                  'Travel History',
                  [
                    _buildProfileItem(Icons.train, 'Recent Trips', '15 trips this year'),
                    _buildProfileItem(Icons.card_membership, 'Season Pass', 'Valid until Dec 2023'),
                    _buildProfileItem(Icons.star, 'Loyalty Points', '2500 points'),
                  ],
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
            child: Icon(
              icon,
              color: const Color(0xFFFF5E0E),
              size: 24,
            ),
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