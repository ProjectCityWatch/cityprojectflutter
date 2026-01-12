import 'package:flutter/material.dart';

// Import all screens
import 'welcome_page.dart';
import 'complaint.dart';
import 'my_complaints_page.dart';
import 'community_hub.dart';
import 'profile_page.dart';
import 'notifications_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    const WelcomePage(),
    const SubmitComplaintPage(),
    const MyComplaintsPage(),
    const CommunityHubPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0; // Go back to Home
          });
          return false; // Prevent app exit
        }
        return true; // Exit app from Home
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6FA),

        // =============================
        // GRADIENT APP BAR (HOME ONLY)
        // =============================
        appBar: _currentIndex == 0
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1A73E8),
                        Color(0xFF6A1B9A),
                      ],
                    ),
                  ),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: const Text(
                      "CityWatch",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: Colors.white,
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_none_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NotificationsPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            : null,

        // =============================
        // MAIN CONTENT
        // =============================
        body: pages[_currentIndex],

        // =============================
        // CUSTOM BOTTOM NAV BAR
        // =============================
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF1A73E8),
            unselectedItemColor: Colors.grey.shade500,
            iconSize: 26,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                label: "Submit",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_outlined),
                label: "My Complaints",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.groups_outlined),
                label: "Community",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
