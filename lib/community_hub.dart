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
      body: Stack(
        children: [
          // =============================
          // GRADIENT HEADER
          // =============================
          Container(
            height: MediaQuery.of(context).size.height * 0.38,
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
          ),

          // =============================
          // CONTENT
          // =============================
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 100, 22, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =============================
                // PAGE TITLE
                // =============================
                const Text(
                  "Community",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.6,
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

                const SizedBox(height: 30),

                // =============================
                // MENU CARD CONTAINER
                // =============================
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 30,
                        offset: const Offset(0, 18),
                      ),
                    ],
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
                                builder: (_) => const CommunityPage()),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      _menuCard(
                        icon: Icons.stars_outlined,
                        title: "Your Points",
                        subtitle: "Earn points for contributing",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PointsPage()),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      _menuCard(
                        icon: Icons.leaderboard_outlined,
                        title: "Leaderboard",
                        subtitle: "Top contributors of the month",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LeaderboardPage()),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      _menuCard(
                        icon: Icons.map_outlined,
                        title: "Map Dashboard",
                        subtitle: "View potholes reported near you",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MapDashboardPage()),
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
  // PREMIUM MENU CARD
  // =============================
  Widget _menuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            // ICON
            Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1A73E8),
                    Color(0xFF6A1B9A),
                  ],
                ),
              ),
              child: Icon(icon, color: Colors.white),
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
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

            const Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
