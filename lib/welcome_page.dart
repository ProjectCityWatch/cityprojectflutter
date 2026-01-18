import 'package:flutter/material.dart';
import 'complaint.dart';
import 'community_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // ----------------------------------------------------
          // CLEAN TOP HERO (no box, no shadows)
          // ----------------------------------------------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 65, bottom: 40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00B4D8), Color(0xFF0077A7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(26),
                bottomRight: Radius.circular(26),
              ),
            ),
            child: const Column(
              children: [
                Icon(Icons.location_city_rounded, size: 80, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  "CityWatch",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 30),

          // ----------------------------------------------------
          // SIMPLE WELCOME TEXT (clean & modern)
          // ----------------------------------------------------
          const Text(
            "Welcome, Citizen!",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: Color(0xFF003B73),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Helping you improve your city.",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 45),

          // ----------------------------------------------------
          // TWO BIG SQUARE BUTTONS (very clean)
          // ----------------------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Row(
              children: [
                // Submit Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SubmitComplaintPage()),
                      );
                    },
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00B4D8),
                        borderRadius: BorderRadius.circular(10), // square edges
                      ),
                      child: const Center(
                        child: Text(
                          "Submit\nComplaint",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                // Community Feed Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CommunityPage()),
                      );
                    },
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF00B4D8),
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Community\nFeed",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF00A0C8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // ----------------------------------------------------
          // SMALL SOFT FOOTNOTE TEXT (no boxes)
          // ----------------------------------------------------
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 26),
            child: Text(
              "Track issues. Support nearby complaints. Stay updated.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black45,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
