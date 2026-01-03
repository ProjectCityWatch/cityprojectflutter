import 'package:flutter/material.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  // ------------------------------------
  // STATIC TEMP DATA
  // ------------------------------------
  final int totalPoints = 300;
  final int userRank = 102;
  final int badgesEarned = 2;

  // Which badges this user has earned
  final List<String> earnedBadgeTitles = const [
    "First Report",
    "First Problem Resolve",
  ];

  // AVAILABLE BADGES
  final List<Map<String, String>> badges = const [
    {
      "title": "First Report",
      "subtitle": "Earned for submitting your very first complaint.",
      "points": "+200 pts",
    },
    {
      "title": "First Problem Resolve",
      "subtitle": "Awarded when your reported issue gets resolved.",
      "points": "+200 pts",
    },
    {
      "title": "Pothole Pro",
      "subtitle": "Recognized for reporting multiple road damage issues.",
      "points": "+200 pts",
    },
    {
      "title": "Clean City Champ",
      "subtitle": "For actively reporting cleanliness and waste issues.",
      "points": "+200 pts",
    },
    {
      "title": "Water Watcher",
      "subtitle": "Awarded for reporting water leakage or wastage.",
      "points": "+200 pts",
    },
    {
      "title": "Streetlight Saver",
      "subtitle": "Earned by reporting faulty or broken streetlights.",
      "points": "+200 pts",
    },
    {
      "title": "Local Hero",
      "subtitle": "For making a strong positive impact in your locality.",
      "points": "+500 pts",
    },
  ];

  // CLARIFIED RECENT ACTIVITIES
  final List<Map<String, String>> activities = const [
    {
      "title": "Complaint Reported",
      "points": "+50",
      "time": "Today",
    },
    {
      "title": "Someone liked your post",
      "points": "+10",
      "time": "Yesterday",
    },
    {
      "title": "Someone commented on your post",
      "points": "+20",
      "time": "2 days ago",
    },
  ];

  // Accent color used in the app
  Color get accentColor => const Color(0xFF00B4D8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        centerTitle: true,
        title: const Text(
          "Your Points",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              "Compete with fellow citizens and earn rewards for making your city better.",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 20),

            _buildSectionTitle("Your Points Details"),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildSummaryCard(
                  context,
                  icon: Icons.star_border_rounded,
                  value: "$totalPoints",
                  label: "Total Points",
                ),
                _buildSummaryCard(
                  context,
                  icon: Icons.trending_up_rounded,
                  value: "#$userRank",
                  label: "Your Rank",
                ),
                _buildSummaryCard(
                  context,
                  icon: Icons.emoji_events_outlined,
                  value: "$badgesEarned",
                  label: "Badges Earned",
                ),
              ],
            ),

            const SizedBox(height: 28),

            _buildSectionTitle("Available Badges"),
            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: badges.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final badge = badges[index];
                final title = badge["title"] ?? "";
                final isEarned = earnedBadgeTitles.contains(title);

                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                        color: Colors.black.withOpacity(0.04),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: isEarned
                              ? accentColor.withOpacity(0.12)
                              : Colors.black.withOpacity(0.05),
                          child: Icon(
                            isEarned
                                ? Icons.verified_rounded
                                : Icons.lock_outline_rounded,
                            size: 26,
                            color:
                                isEarned ? accentColor : Colors.grey[500],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Text(
                          badge["subtitle"] ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.3,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        badge["points"] ?? "",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 28),

            _buildSectionTitle("Recent Activities"),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final item = activities[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                        color: Colors.black.withOpacity(0.04),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: accentColor.withOpacity(0.1),
                        ),
                        child: Icon(
                          Icons.bolt_rounded,
                          size: 20,
                          color: accentColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"] ?? "",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item["time"] ?? "",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item["points"] ?? "",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = (width - 16 * 2 - 12 * 2) / 3;

    return SizedBox(
      width: cardWidth < 120 ? 140 : cardWidth,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0B1623),
              Color(0xFF002B3D),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(icon, size: 26, color: accentColor),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
