import 'package:e_season/dashboard_screen.dart';
import 'package:e_season/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class SeasonScreen extends StatefulWidget {
  const SeasonScreen({super.key});

  @override
  State<SeasonScreen> createState() => _SeasonScreenState();
}

class _SeasonScreenState extends State<SeasonScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 0) { // Home tab
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button and title
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
                    const Expanded(
                      child: Text(
                        'Seasons',
                        style: TextStyle(
                          fontFamily: 'Railway',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4D4238),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the header
                  ],
                ),
              ),
              
              // Apply Season Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _buildApplySeasonButton(),
              ),
              
              const SizedBox(height: 24),
              
              // Previous Seasons
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Previous Seasons',
                        style: TextStyle(
                          fontFamily: 'Railway',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4D4238),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView(
                          children: [
                            _buildPreviousSeasonCard('Summer Season 2023', 'Valid: May - Aug 2023', 'Expired'),
                            _buildPreviousSeasonCard('Winter Season 2022', 'Valid: Nov - Feb 2022', 'Expired'),
                            _buildPreviousSeasonCard('Monsoon Season 2022', 'Valid: Jun - Sep 2022', 'Expired'),
                            _buildPreviousSeasonCard('Spring Season 2022', 'Valid: Mar - May 2022', 'Expired'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
  
  Widget _buildApplySeasonButton() {
    return GestureDetector(
      onTap: () {
        // Handle apply season tap
        print('Apply for new season tapped');
        // You can add navigation or other actions here
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFFF5E0E),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF5E0E).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 12),
            Text(
              'Apply for New Season',
              style: TextStyle(
                fontFamily: 'Railway',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPreviousSeasonCard(String title, String validity, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFF8ECC9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(
                  Icons.calendar_today,
                  color: Color(0xFFFF5E0E),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Railway',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF4D4238),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    validity,
                    style: const TextStyle(
                      fontFamily: 'Railway',
                      fontSize: 14,
                      color: Color(0xFF4D4238),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF4D4238).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: const TextStyle(
                  fontFamily: 'Railway',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4D4238),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}