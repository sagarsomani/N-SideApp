import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvailableLecturersScreen extends StatelessWidget {
  const AvailableLecturersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Available Lecturers",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
                .where('isAvailable', isEqualTo: true)
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
                    "No lecturers available right now.",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                );
              }

              final lecturers = snapshot.data!.docs;

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: lecturers.length,
                itemBuilder: (context, index) {
                  var lecture = lecturers[index].data() as Map<String, dynamic>;
                  return _buildLectureCard(lecture);
                },
              );
            },
          ),
        ),
      ),
    );
  }
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
            lecture['subject'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _infoRow(Icons.person, lecture['name']),
          _infoRow(Icons.access_time, lecture['time']),
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
