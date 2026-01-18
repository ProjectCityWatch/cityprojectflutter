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
            _currentIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],

        // =============================
        // APP BAR (HOME ONLY)
        // =============================
        appBar: _currentIndex == 0
            ? AppBar(
                elevation: 0,
                backgroundColor: const Color(0xFF009DCC),
                title: const Text(
                  "CityWatch",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
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
              )
            : null,

        // =============================
        // MAIN CONTENT
        // =============================
        body: pages[_currentIndex],

        // =============================
        // BOTTOM NAVIGATION BAR
        // =============================
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF009DCC),
            unselectedItemColor: Colors.grey.shade500,
            iconSize: 26,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
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
