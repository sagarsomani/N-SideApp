import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HallAvailabilityScreen extends StatelessWidget {
  const HallAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Hall Availability",
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
            stream: FirebaseFirestore.instance.collection('halls').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "No hall data found.",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                );
              }

              final halls = snapshot.data!.docs;

              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: halls.length,
                itemBuilder: (context, index) {
                  final hall = halls[index];
                  final name = hall['name'] ?? 'Unnamed Hall';
                  final capacity = hall['capacity'] ?? 'Unknown Capacity';
                  final isAvailable = hall['isAvailable'] ?? false;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1CB5E0), Color(0xFF000046)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: const CircleAvatar(
                        backgroundColor: Colors.white24,
                        child: Icon(Icons.meeting_room, color: Colors.white),
                      ),
                      title: Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        "Capacity: $capacity",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Icon(
                        isAvailable ? Icons.check_circle : Icons.cancel,
                        color: isAvailable
                            ? Colors.lightGreenAccent
                            : Colors.redAccent,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
