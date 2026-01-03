import 'package:flutter/material.dart';
import 'package:citywatchapp/complaint.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  Color get accentColor => const Color(0xFF00B4D8);

  final int userRank = 102;
  final int userPoints = 300;

  final List<Map<String, dynamic>> leaders = const [
    {"name": "Sarah Johnson", "points": 1250, "rank": 1, "reported": 45, "resolved": 38},
    {"name": "Michael Chen", "points": 1180, "rank": 2, "reported": 42, "resolved": 35},
    {"name": "Emily Rodriguez", "points": 1050, "rank": 3, "reported": 38, "resolved": 32},
    {"name": "David Kim", "points": 920, "rank": 4, "reported": 35, "resolved": 28},
    {"name": "Lisa Anderson", "points": 850, "rank": 5, "reported": 32, "resolved": 25},
    {"name": "James Wilson", "points": 780, "rank": 6, "reported": 28, "resolved": 22},
    {"name": "Maria Garcia", "points": 720, "rank": 7, "reported": 26, "resolved": 20},
    {"name": "Arjun Mehta", "points": 690, "rank": 8, "reported": 24, "resolved": 19},
    {"name": "Sneha Nair", "points": 660, "rank": 9, "reported": 23, "resolved": 18},
    {"name": "Rahul Sharma", "points": 640, "rank": 10, "reported": 22, "resolved": 17},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        centerTitle: true,
        title: const Text("Leaderboard", style: TextStyle(fontWeight: FontWeight.w600)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Top Contributors"),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: leaders.length,
              itemBuilder: (context, index) =>
                  _buildLeaderTile(context, leaders[index], index),
            ),

            const SizedBox(height: 20),
            _yourRankCard(context),

            const SizedBox(height: 30),
            _sectionTitle("How to Earn Points"),
            const SizedBox(height: 12),
            _buildHowToEarnPointsCard(),

            const SizedBox(height: 30),
            _buildClimbLeaderboardCard(context),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) => Text(
        text,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      );

  Widget _buildLeaderTile(BuildContext context, Map<String, dynamic> item, int index) {
    final rank = item["rank"];
    final name = item["name"];
    final points = item["points"];
    final reported = item["reported"];
    final resolved = item["resolved"];

    Gradient? gradient;
    Color? bgColor;

    if (index == 0) {
      gradient = const LinearGradient(colors: [Color(0xFFFFD54F), Color(0xFFF9A825)]);
    } else if (index == 1) {
      gradient = const LinearGradient(colors: [Color(0xFFB0BEC5), Color(0xFF78909C)]);
    } else if (index == 2) {
      gradient = const LinearGradient(colors: [Color(0xFFFFB74D), Color(0xFFF57C00)]);
    } else {
      bgColor = const Color(0xFFF7F7F7);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      decoration: BoxDecoration(
        gradient: gradient,
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (index < 3) ? Colors.transparent : Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 3),
            color: Colors.black.withOpacity(0.10),
          ),
        ],
      ),

      child: Row(
        children: [
          _rankIcon(rank, index),
          const SizedBox(width: 14),

          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.black.withOpacity(0.06),
            child: Text(name[0], style: const TextStyle(color: Colors.black87)),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: (index < 3) ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$reported reported • $resolved resolved",
                  style: TextStyle(
                    fontSize: 12,
                    color: (index < 3) ? Colors.white70 : Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$points",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: (index < 3) ? Colors.white : Colors.black87,
                ),
              ),
              Text(
                "points",
                style: TextStyle(
                  fontSize: 12,
                  color: (index < 3) ? Colors.white70 : Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rankIcon(int rank, int index) {
    if (index == 0) return const Icon(Icons.emoji_events, color: Colors.amber, size: 28);
    if (index == 1) return Icon(Icons.emoji_events, color: Colors.grey.shade300, size: 24);
    if (index == 2) return Icon(Icons.emoji_events, color: Colors.brown, size: 24);

    return Text(
      "#$rank",
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }

  Widget _yourRankCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F8FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accentColor.withOpacity(0.5)),
      ),

      child: Row(
        children: [
          Icon(Icons.person_pin_circle, color: accentColor, size: 32),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Your Current Rank",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text(
                  "You are at #102 with 300 points.",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text("View Progress",
                style: TextStyle(color: Colors.white, fontSize: 12)),
          )
        ],
      ),
    );
  }

  // ⭐ UPDATED — HOW TO EARN POINTS VALUES ONLY
  Widget _buildHowToEarnPointsCard() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),

        child: Column(
          children: [
            const Text("How to Earn Points",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _earnItem(Icons.edit_note, "Report an Issue", "+50 pts"),
                _earnItem(Icons.check_circle, "Issue Resolved", "+100 pts"),
                _earnItem(Icons.thumb_up_alt, "Vote Received", "+10 pts"),
                _earnItem(Icons.emoji_events, "Earn a Badge", "+200 pts"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _earnItem(IconData icon, String title, String pts) {
    return Column(
      children: [
        Icon(icon, size: 30, color: accentColor),
        const SizedBox(height: 8),
        Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          pts,
          style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildClimbLeaderboardCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF00B4D8)),
      ),

      child: Column(
        children: [
          const Text(
            "Climb the Leaderboard!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "Report more issues, engage with your community, and earn badges to reach the top.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SubmitComplaintPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)),
            ),
            child: const Text("Report an Issue Now",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
