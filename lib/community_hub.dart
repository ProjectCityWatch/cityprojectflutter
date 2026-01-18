import 'package:flutter/material.dart';

// Import sub-pages
import 'community_page.dart';
import 'points_page.dart';
import 'leaderboard_page.dart';
import 'map_dashboard_page.dart';

class CommunityHubPage extends StatelessWidget {
  const CommunityHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // =============================
          // SOLID HEADER (THEME COLOR)
          // =============================
          Container(
            height: MediaQuery.of(context).size.height * 0.32,
            decoration: const BoxDecoration(
              color: Color(0xFF009DCC),
            ),
          ),

          // =============================
          // CONTENT
          // =============================
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 90, 20, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =============================
                // PAGE TITLE
                // =============================
                const Text(
                  "Community",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Explore, contribute & lead change",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 26),

                // =============================
                // MENU CARD CONTAINER
                // =============================
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      _menuCard(
                        icon: Icons.public_outlined,
                        title: "Community Feed",
                        subtitle: "View all public complaints",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CommunityPage(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 14),

                      _menuCard(
                        icon: Icons.stars_outlined,
                        title: "Your Points",
                        subtitle: "Earn points for contributing",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PointsPage(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 14),

                      _menuCard(
                        icon: Icons.leaderboard_outlined,
                        title: "Leaderboard",
                        subtitle: "Top contributors of the month",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LeaderboardPage(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 14),

                      _menuCard(
                        icon: Icons.map_outlined,
                        title: "Map Dashboard",
                        subtitle: "View potholes reported near you",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MapDashboardPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =============================
  // MENU CARD (THEME CONSISTENT)
  // =============================
  Widget _menuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            // ICON
            Container(
              height: 44,
              width: 44,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF009DCC),
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),

            const SizedBox(width: 14),

            // TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
