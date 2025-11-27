import 'package:flutter/material.dart';

import 'package:citywatchapp/login.dart';
import 'package:citywatchapp/register.dart';
import 'package:citywatchapp/home.dart';
import 'package:citywatchapp/my_complaints_page.dart';
import 'package:citywatchapp/notifications_page.dart';
import 'package:citywatchapp/profile_page.dart';
import 'package:citywatchapp/community_page.dart';
import 'package:citywatchapp/complaint.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CityWatch App',


      // USE ROUTE SYSTEM
      initialRoute: '/login',

      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) =>  RegisterPage(),
        '/home': (context) => const HomePage(),
        '/mycomplaints': (context) => const MyComplaintsPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/profile': (context) => const ProfilePage(),
        '/community': (context) => const CommunityPage(),
        '/complaint': (context) => const SubmitComplaintPage(),
      },
    );
  }
}
