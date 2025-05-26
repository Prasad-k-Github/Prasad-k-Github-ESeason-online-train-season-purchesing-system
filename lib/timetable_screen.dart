import 'package:flutter/material.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Text(
                      'Train Timetables',
                      style: TextStyle(
                        fontFamily: 'Railway',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4D4238),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Color(0xFF4D4238),
                      ),
                      onPressed: () {
                        // Handle search
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildTimetableCard(
                      'Delhi Express',
                      'Delhi → Mumbai',
                      '09:00 AM',
                      '10:30 PM',
                      'On Time',
                    ),
                    _buildTimetableCard(
                      'Chennai Mail',
                      'Chennai → Bangalore',
                      '10:30 AM',
                      '04:45 PM',
                      'Delayed',
                    ),
                    _buildTimetableCard(
                      'Kolkata Express',
                      'Kolkata → Delhi',
                      '11:15 AM',
                      '03:30 AM',
                      'On Time',
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

  Widget _buildTimetableCard(String trainName, String route, String departure, String arrival, String status) {
    final bool isDelayed = status == 'Delayed';
    
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  trainName,
                  style: const TextStyle(
                    fontFamily: 'Railway',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4D4238),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDelayed ? const Color(0xFFFF5E0E).withOpacity(0.1) : const Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontFamily: 'Railway',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isDelayed ? const Color(0xFFFF5E0E) : const Color(0xFF4CAF50),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              route,
              style: TextStyle(
                fontFamily: 'Railway',
                fontSize: 14,
                color: const Color(0xFF4D4238).withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimeInfo('Departure', departure),
                _buildTimeInfo('Arrival', arrival),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeInfo(String label, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Railway',
            fontSize: 12,
            color: const Color(0xFF4D4238).withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: const TextStyle(
            fontFamily: 'Railway',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4D4238),
          ),
        ),
      ],
    );
  }
}