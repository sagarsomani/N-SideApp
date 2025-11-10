import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LectureScheduleScreen extends StatelessWidget {
  const LectureScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lecture Schedule",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('lectures')
                .orderBy('time')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "No lectures available yet.",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                );
              }

              final lectures = snapshot.data!.docs;

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: lectures.length,
                itemBuilder: (context, index) {
                  var lecture = lectures[index].data() as Map<String, dynamic>;
                  return _buildLectureCard(lecture);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLectureCard(Map<String, dynamic> lecture) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1CB5E0), Color(0xFF000046)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lecture['subject'] ?? "Unknown Subject",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _infoRow(Icons.person, lecture['teacher']),
            _infoRow(Icons.access_time, lecture['time']),
            _infoRow(Icons.location_on, lecture['room']),
            _infoRow(Icons.calendar_today, lecture['day']),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String? text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 18),
          const SizedBox(width: 8),
          Text(
            text ?? "-",
            style: const TextStyle(color: Colors.white70, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
