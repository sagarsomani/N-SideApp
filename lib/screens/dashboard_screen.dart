import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final modules = [
      {
        'title': 'Lecture Schedule',
        'icon': Icons.schedule,
        'route': '/lecture_schedule',
        'color1': const Color(0xFF1CB5E0),
        'color2': const Color(0xFF000046),
      },
      {
        'title': 'Available Lecturers',
        'icon': Icons.person_search,
        'route': '/lecturers',
        'color1': Colors.indigo,
        'color2': Colors.indigoAccent,
      },
      {
        'title': 'Hall Availability',
        'icon': Icons.meeting_room,
        'route': '/hall_availability',
        'color1': const Color(0xFF11998E),
        'color2': const Color(0xFF38EF7D),
      },
      {
        'title': 'AR Navigation',
        'icon': Icons.navigation,
        'route': '/ar_navigation',
        'color1': const Color(0xFFFF416C),
        'color2': const Color(0xFFFF4B2B),
      },
      // Logout button added as a module
      {
        'title': 'Logout',
        'icon': Icons.logout,
        'route': '/logout',
        'color1': const Color(0xFFFF5F6D),
        'color2': const Color(0xFFFFC371),
      },
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "N-Side App Dashboard",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome 👋",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Explore your university tools below:",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: GridView.builder(
                    itemCount: modules.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1.1,
                        ),
                    itemBuilder: (context, index) {
                      final module = modules[index];
                      return _buildDashboardCard(
                        context,
                        title: module['title'] as String,
                        icon: module['icon'] as IconData,
                        color1: module['color1'] as Color,
                        color2: module['color2'] as Color,
                        route: module['route'] as String,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color1,
    required Color color2,
    required String route,
  }) {
    return GestureDetector(
      onTap: () {
        if (route == '/logout') {
          // Add your logout logic here
          // For example, FirebaseAuth.instance.signOut()
          // Then navigate to login screen
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color1.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
