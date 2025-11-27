import 'package:flutter/material.dart';
import 'complaint.dart';
import 'community_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // ----------------------------------------------------
                // SMALLER HERO (reduced height)
                // ----------------------------------------------------
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 28),
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
                      Icon(Icons.location_city_rounded, size: 60, color: Colors.white),
                      SizedBox(height: 8),
                      Text(
                        "CityWatch",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // ----------------------------------------------------
                // WELCOME TEXT
                // ----------------------------------------------------
                const Text(
                  "Welcome, Citizen!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF003B73),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Helping you improve your city.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 32),

                // ----------------------------------------------------
                // ACTION BUTTONS (smaller height)
                // ----------------------------------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const SubmitComplaintPage()));
                          },
                          child: Container(
                            height: 100, // REDUCED
                            decoration: BoxDecoration(
                              color: const Color(0xFF00B4D8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Submit\nComplaint",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 18),

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const CommunityPage()));
                          },
                          child: Container(
                            height: 100, // REDUCED
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
                                  fontSize: 16,
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

                const SizedBox(height: 30),

                // ----------------------------------------------------
                // FOOTNOTE TEXT
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
          ),
        ),
      ),
    );
  }
}
