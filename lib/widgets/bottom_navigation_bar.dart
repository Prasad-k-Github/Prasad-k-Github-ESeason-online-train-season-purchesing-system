import 'package:flutter/material.dart';
import 'package:e_season/dashboard_screen.dart';
import 'package:e_season/season_screen.dart';
import 'package:e_season/timetable_screen.dart';
import 'package:e_season/profile_screen.dart';
import 'package:e_season/chatbot_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _screens = [
    const DashboardScreen(),
    const SeasonScreen(),
    const SizedBox(), // Empty widget for center button
    const TimetableScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) { // Center button (Chatbot)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChatbotScreen()),
      );
      return;
    }
    
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 15, spreadRadius: 1, offset: const Offset(0, -3))],
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFF8E1), Colors.white, Color(0xFFFFF8E1)],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: onTap,
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFFFF5E0E),
            unselectedItemColor: const Color(0xFF4D4238).withOpacity(0.5),
            selectedLabelStyle: const TextStyle(
              fontFamily: 'Railway',
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Railway',
              fontSize: 10,
            ),
            items: [
              _buildNavItem(Icons.home_outlined, 'Home', 0),
              _buildNavItem(Icons.calendar_today_outlined, 'Seasons', 1),
              _buildEmptyNavItem(2),
              _buildNavItem(Icons.article_outlined, 'Timetables', 3),
              _buildNavItem(Icons.person_outline, 'Profile', 4),
            ],
          ),
        ),
        // Chatbot button
        GestureDetector(
          onTap: () {
            // Handle chatbot tap
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFFF5E0E),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: const Color(0xFFFF5E0E).withOpacity(0.3), spreadRadius: 2, blurRadius: 8, offset: const Offset(0, 3))],
            ),
            child: const Icon(Icons.smart_toy_outlined, color: Colors.white, size: 28),
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = selectedIndex == index;
    
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF5E0E).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border(
            top: BorderSide(
              color: isSelected ? const Color(0xFFFF5E0E) : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Icon(
          icon,
          color: isSelected ? const Color(0xFFFF5E0E) : const Color(0xFF4D4238).withOpacity(0.5),
        ),
      ),
      label: label,
    );
  }

  BottomNavigationBarItem _buildEmptyNavItem(int i) {
    return const BottomNavigationBarItem(
      icon: SizedBox(height: 24),
      label: '',
    );
  }
}