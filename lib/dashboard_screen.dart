import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            // Header with logo and user profile
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFFFF5E0E).withOpacity(0.2),
                    radius: 20,
                    child: const Icon(Icons.person, color: Color(0xFFFF5E0E)),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF4CAF50).withOpacity(0.2),
                    radius: 20,
                    child: const Icon(
                      Icons.notifications,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                ],
              ),
            ),

            // Welcome message
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: TextStyle(
                      fontFamily: 'Railway',
                      fontSize: 16,
                      color: Color(0xFF4D4238),
                    ),
                  ),
                  Text(
                    'User!',
                    style: TextStyle(
                      fontFamily: 'Railway',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4D4238),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // Our Services Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Our Services',
                    style: TextStyle(
                      fontFamily: 'Railway',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4D4238),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryCard(
                          'Apply Season',
                          Icons.card_membership,
                          const Color(0xFFFF5E0E),
                        ),
                        _buildCategoryCard(
                          'Train Timetables',
                          Icons.schedule,
                          const Color(0xFF4CAF50),
                        ),
                        _buildCategoryCard(
                          'Lost & Found',
                          Icons.search,
                          const Color(0xFF2196F3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Featured items
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent News',
                      style: TextStyle(
                        fontFamily: 'Railway',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4D4238),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 1,
                        mainAxisSpacing: 16,
                        children: [
                          _buildNewsCard(
                            'New Express Train',
                            'Delhi to Mumbai',
                            'assets/images/download3.png',
                          ),
                          _buildNewsCard(
                            'Station Upgrade',
                            'Completed at Chennai',
                            'assets/images/download3.png',
                          ),
                          _buildNewsCard(
                            'E-Ticket Update',
                            'New features added',
                            'assets/images/download3.png',
                          ),
                          _buildNewsCard(
                            'Holiday Schedule',
                            'For upcoming festivals',
                            'assets/images/download3.png',
                          ),
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
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        // Handle the tap event
        print('$title category tapped');
        // Categories will be handled by the single navigation bar
      },
      splashColor: color.withOpacity(0.3),
      highlightColor: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Railway',
                color: color,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(String title, String subtitle, String imagePath) {
    return Container(
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8ECC9).withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Center(child: Image.asset(imagePath, height: 60)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Railway',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4D4238),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Railway',
                    color: Color(0xFF4D4238),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
