import 'package:flutter/material.dart';

// Import sub-pages
import 'community_page.dart';
import 'points_page.dart';
import 'leaderboard_page.dart';
import 'map_dashboard_page.dart'; // <-- Add this when your map page exists

class CommunityHubPage extends StatelessWidget {
  const CommunityHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Text("Community"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // -----------------------------------------
            // MAIN TITLE
            // -----------------------------------------
            const Text(
              "Explore Community",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // -----------------------------------------
            // COMMUNITY FEED BUTTON
            // -----------------------------------------
            _menuCard(
              icon: Icons.public_outlined,
              title: "Community Feed",
              subtitle: "View all public complaints",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CommunityPage()),
                );
              },
            ),

            const SizedBox(height: 15),

            // -----------------------------------------
            // POINTS BUTTON
            // -----------------------------------------
            _menuCard(
              icon: Icons.stars_outlined,
              title: "Your Points",
              subtitle: "Earn points for contributing",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PointsPage()),
                );
              },
            ),

            const SizedBox(height: 15),

            // -----------------------------------------
            // LEADERBOARD BUTTON
            // -----------------------------------------
            _menuCard(
              icon: Icons.leaderboard_outlined,
              title: "Leaderboard",
              subtitle: "Top contributors of the month",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LeaderboardPage()),
                );
              },
            ),

            const SizedBox(height: 15),

            // -----------------------------------------
            // MAP DASHBOARD (NEW SECTION)
            // -----------------------------------------
            _menuCard(
              icon: Icons.map_outlined,
              title: "Map Dashboard",
              subtitle: "View potholes reported near you",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MapDashboardPage()),
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // -----------------------------------------
  // REUSABLE MENU CARD
  // -----------------------------------------
  Widget _menuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),

      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.blue[800],
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
