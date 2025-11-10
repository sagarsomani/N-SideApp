import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:n_side_app/screens/ar_navigation_screen.dart';
import 'package:n_side_app/screens/auth/login_screen.dart';
import 'package:n_side_app/screens/auth/register_screen.dart';
import 'package:n_side_app/screens/available_lecturers_screen.dart';
import 'package:n_side_app/screens/dashboard_screen.dart';
import 'package:n_side_app/screens/hall_availability_screen.dart';
import 'package:n_side_app/screens/lecture_schedule_screen.dart';
import 'package:n_side_app/screens/onboarding_screen.dart';
import 'package:n_side_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const NSideApp());
}

class NSideApp extends StatelessWidget {
  const NSideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'N-Side App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/lecture_schedule': (context) => const LectureScheduleScreen(),
        '/lecturers': (context) => const AvailableLecturersScreen(),
        '/hall_availability': (context) => const HallAvailabilityScreen(),
        '/ar_navigation': (context) => const NavigationMapScreen(),

        // '/available_lecturers': (context) => const PlaceholderScreen(title: 'Available Lecturers'),
        // '/hall_availability': (context) => const PlaceholderScreen(title: 'Hall Availability'),
        // '/ar_navigation': (context) => const PlaceholderScreen(title: 'AR Navigation'),
      },
    );
  }
}
