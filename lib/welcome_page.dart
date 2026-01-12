import 'package:flutter/material.dart';
import 'complaint.dart';
import 'community_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Column(
        children: [
          // =============================
          // TOP HEADER WITH CENTER ICON
          // =============================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(22, 50, 22, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1A73E8),
                  Color(0xFF6A1B9A),
                ],
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
            ),
            child: Column(
              children: const [
                // CENTER ICON
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.location_city_rounded,
                    size: 34,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 14),

                Text(
                  "CityWatch",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  "Report problems. Improve your city.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // =============================
          // MAIN CONTENT
          // =============================
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "What would you like to do?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // =============================
                  // SUBMIT COMPLAINT TILE
                  // =============================
                  _featureTile(
                    title: "Submit a Complaint",
                    subtitle:
                        "Report issues like road damage, waste dumping, water leakage, and more.",
                    icon: Icons.report_problem_rounded,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1A73E8),
                        Color(0xFF4F8EF7),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SubmitComplaintPage(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  // =============================
                  // COMMUNITY TILE
                  // =============================
                  _featureTile(
                    title: "Community Feed",
                    subtitle:
                        "View nearby complaints and support issues raised by others.",
                    icon: Icons.people_alt_rounded,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6A1B9A),
                        const Color(0xFF8E44AD),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CommunityPage(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  // =============================
                  // INFO STRIP
                  // =============================
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.info_outline,
                          color: Color(0xFF1A73E8),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Your complaints directly reach the responsible department.",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =============================
  // FEATURE TILE
  // =============================
  Widget _featureTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required LinearGradient gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 20,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
