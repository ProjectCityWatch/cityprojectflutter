// import 'package:citywatchapp/API/loginAPI.dart';
// import 'package:citywatchapp/API/registerAPi.dart' hide dio;
// import 'package:flutter/material.dart';

// class PointsPage extends StatefulWidget {
//   const PointsPage({super.key});

//   @override
//   State<PointsPage> createState() => _PointsPageState();
// }

// class _PointsPageState extends State<PointsPage> {
//   // ------------------------------------
//   final int totalPoints = 300;

//   final int userRank = 102;

//   final int badgesEarned = 2;

//  Future<Map<String, dynamic>> viewPoints() async {
//     try {
//       final response = await dio.get(
//         "$url/UserPointsAPI/$loginid",
//       );

//       print("##############${response.data}");

//       return response.data;
//     } catch (e) {
//       throw Exception("Failed to load profile");
//     }
//   }

//   // Which badges this user has earned
//   final List<String> earnedBadgeTitles = const [
//     "First Report",
//     "First Problem Resolve",
//   ];

//   // AVAILABLE BADGES
//   final List<Map<String, String>> badges = const [
//     {
//       "title": "First Report",
//       "subtitle": "Earned for submitting your very first complaint.",
//       "points": "+200 pts",
//     },
//     {
//       "title": "First Problem Resolve",
//       "subtitle": "Awarded when your reported issue gets resolved.",
//       "points": "+200 pts",
//     },
//     {
//       "title": "Pothole Pro",
//       "subtitle": "Recognized for reporting multiple road damage issues.",
//       "points": "+200 pts",
//     },
//     {
//       "title": "Clean City Champ",
//       "subtitle": "For actively reporting cleanliness and waste issues.",
//       "points": "+200 pts",
//     },
//     {
//       "title": "Water Watcher",
//       "subtitle": "Awarded for reporting water leakage or wastage.",
//       "points": "+200 pts",
//     },
//     {
//       "title": "Streetlight Saver",
//       "subtitle": "Earned by reporting faulty or broken streetlights.",
//       "points": "+200 pts",
//     },
//     {
//       "title": "Local Hero",
//       "subtitle": "For making a strong positive impact in your locality.",
//       "points": "+500 pts",
//     },
//   ];@override
//   void initState() {
//     viewPoints();
//     super.initState();
//   }

//   // CLARIFIED RECENT ACTIVITIES
//   final List<Map<String, String>> activities = const [
//     {
//       "title": "Complaint Reported",
//       "points": "+50",
//       "time": "Today",
//     },
//     {
//       "title": "Someone liked your post",
//       "points": "+10",
//       "time": "Yesterday",
//     },
//     {
//       "title": "Someone commented on your post",
//       "points": "+20",
//       "time": "2 days ago",
//     },
//   ];

//   // Accent color used in the app
//   Color get accentColor => const Color(0xFF00B4D8);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black87,
//         centerTitle: true,
//         title: const Text(
//           "Your Points",
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 4),
//             Text(
//               "Compete with fellow citizens and earn rewards for making your city better.",
//               style: TextStyle(
//                 color: Colors.grey[700],
//                 fontSize: 14,
//               ),
//             ),

//             const SizedBox(height: 20),

//             _buildSectionTitle("Your Points Details"),
//             const SizedBox(height: 12),

//             Wrap(
//               spacing: 12,
//               runSpacing: 12,
//               children: [
//                 _buildSummaryCard(
//                   context,
//                   icon: Icons.star_border_rounded,
//                   value: "$totalPoints",
//                   label: "Total Points",
//                 ),
//                 _buildSummaryCard(
//                   context,
//                   icon: Icons.trending_up_rounded,
//                   value: "#$userRank",
//                   label: "Your Rank",
//                 ),
//                 _buildSummaryCard(
//                   context,
//                   icon: Icons.emoji_events_outlined,
//                   value: "$badgesEarned",
//                   label: "Badges Earned",
//                 ),
//               ],
//             ),

//             const SizedBox(height: 28),

//             _buildSectionTitle("Available Badges"),
//             const SizedBox(height: 12),

//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: badges.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 0.9,
//               ),
//               itemBuilder: (context, index) {
//                 final badge = badges[index];
//                 final title = badge["title"] ?? "";
//                 final isEarned = earnedBadgeTitles.contains(title);

//                 return Container(
//                   padding: const EdgeInsets.all(14),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF7F7F7),
//                     borderRadius: BorderRadius.circular(18),
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 6,
//                         offset: const Offset(0, 2),
//                         color: Colors.black.withOpacity(0.04),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: CircleAvatar(
//                           radius: 26,
//                           backgroundColor: isEarned
//                               ? accentColor.withOpacity(0.12)
//                               : Colors.black.withOpacity(0.05),
//                           child: Icon(
//                             isEarned
//                                 ? Icons.verified_rounded
//                                 : Icons.lock_outline_rounded,
//                             size: 26,
//                             color:
//                                 isEarned ? accentColor : Colors.grey[500],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         title,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Expanded(
//                         child: Text(
//                           badge["subtitle"] ?? "",
//                           maxLines: 3,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 12,
//                             height: 1.3,
//                             color: Colors.grey[700],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         badge["points"] ?? "",
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.green[700],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),

//             const SizedBox(height: 28),

//             _buildSectionTitle("Recent Activities"),
//             const SizedBox(height: 12),

//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: activities.length,
//               itemBuilder: (context, index) {
//                 final item = activities[index];
//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 10),
//                   padding: const EdgeInsets.all(14),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF7F7F7),
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 6,
//                         offset: const Offset(0, 2),
//                         color: Colors.black.withOpacity(0.04),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: accentColor.withOpacity(0.1),
//                         ),
//                         child: Icon(
//                           Icons.bolt_rounded,
//                           size: 20,
//                           color: accentColor,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               item["title"] ?? "",
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               item["time"] ?? "",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey[700],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         item["points"] ?? "",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green[700],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   Widget _buildSummaryCard(
//     BuildContext context, {
//     required IconData icon,
//     required String value,
//     required String label,
//   }) {
//     final width = MediaQuery.of(context).size.width;
//     final cardWidth = (width - 16 * 2 - 12 * 2) / 3;

//     return SizedBox(
//       width: cardWidth < 120 ? 140 : cardWidth,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Color(0xFF0B1623),
//               Color(0xFF002B3D),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           children: [
//             Icon(icon, size: 26, color: accentColor),
//             const SizedBox(height: 10),
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 24,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 13,
//                 color: Colors.white.withOpacity(0.7),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:citywatchapp/API/loginAPI.dart';
// import 'package:citywatchapp/API/registerAPi.dart' hide dio;
// import 'package:flutter/material.dart';

// class PointsPage extends StatefulWidget {
//   const PointsPage({super.key});

//   @override
//   State<PointsPage> createState() => _PointsPageState();
// }

// class _PointsPageState extends State<PointsPage> {
//   // -----------------------------
//   // DYNAMIC STATE (FROM BACKEND)
//   // -----------------------------
//   int totalPoints = 0;
//   int userRank = 0;
//   int badgesEarned = 0;

//   List<dynamic> badges = [];
//   List<dynamic> activities = [];bool showAllActivities = false;
// List<dynamic> get visibleActivities {
//   if (showAllActivities) return activities;
//   return activities.take(3).toList();
// }


//   // Accent color used in the app
//   Color get accentColor => const Color(0xFF00B4D8);

//   // -----------------------------
//   // API CALL
//   // -----------------------------
//   Future<void> viewPoints() async {
//     try {
//       final response = await dio.get(
//         "$url/UserPointsAPI/$loginid",
//       );

//       final data = response.data;

//       setState(() {
//         totalPoints = data["summary"]["total_points"];
//         userRank = data["summary"]["user_rank"];
//         badgesEarned = data["summary"]["badges_earned"];

//         badges = data["badges"];
//         activities = data["activities"];
//       });

//     } catch (e) {
//       print("Failed to load points: $e");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     viewPoints();
//   }

//   // -----------------------------
//   // DATE FORMATTER
//   // -----------------------------
//   String _formatTime(String date) {
//     final dt = DateTime.parse(date);
//     return "${dt.day}/${dt.month}/${dt.year}";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black87,
//         centerTitle: true,
//         title: const Text(
//           "Your Points",
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 4),
//             Text(
//               "Compete with fellow citizens and earn rewards for making your city better.",
//               style: TextStyle(
//                 color: Colors.grey[700],
//                 fontSize: 14,
//               ),
//             ),

//             const SizedBox(height: 20),

//             _buildSectionTitle("Your Points Details"),
//             const SizedBox(height: 12),

//             Wrap(
//               spacing: 12,
//               runSpacing: 12,
//               children: [
//                 _buildSummaryCard(
//                   context,
//                   icon: Icons.star_border_rounded,
//                   value: "$totalPoints",
//                   label: "Total Points",
//                 ),
//                 _buildSummaryCard(
//                   context,
//                   icon: Icons.trending_up_rounded,
//                   value: "#$userRank",
//                   label: "Your Rank",
//                 ),
//                 _buildSummaryCard(
//                   context,
//                   icon: Icons.emoji_events_outlined,
//                   value: "$badgesEarned",
//                   label: "Badges Earned",
//                 ),
//               ],
//             ),

//             const SizedBox(height: 28),

//             _buildSectionTitle("Available Badges"),
//             const SizedBox(height: 12),

//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: badges.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 0.9,
//               ),
//               itemBuilder: (context, index) {
//                 final badge = badges[index];
//                 final isEarned = badge["is_earned"] == true;

//                 return Container(
//                   padding: const EdgeInsets.all(14),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF7F7F7),
//                     borderRadius: BorderRadius.circular(18),
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 6,
//                         offset: const Offset(0, 2),
//                         color: Colors.black.withOpacity(0.04),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: CircleAvatar(
//                           radius: 26,
//                           backgroundColor: isEarned
//                               ? accentColor.withOpacity(0.12)
//                               : Colors.black.withOpacity(0.05),
//                           child: Icon(
//                             isEarned
//                                 ? Icons.verified_rounded
//                                 : Icons.lock_outline_rounded,
//                             size: 26,
//                             color:
//                                 isEarned ? accentColor : Colors.grey[500],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         badge["title"],
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Expanded(
//                         child: Text(
//                           badge["subtitle"],
//                           maxLines: 3,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 12,
//                             height: 1.3,
//                             color: Colors.grey[700],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         "+${badge["points"]} pts",
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.green[700],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),

//             const SizedBox(height: 28),

//             _buildSectionTitle("Recent Activities"),
//             const SizedBox(height: 12),

//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: visibleActivities.length,
// itemBuilder: (context, index) {
//   final item = visibleActivities[index];

//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 10),
//                   padding: const EdgeInsets.all(14),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF7F7F7),
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 6,
//                         offset: const Offset(0, 2),
//                         color: Colors.black.withOpacity(0.04),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: accentColor.withOpacity(0.1),
//                         ),
//                         child: Icon(
//                           Icons.bolt_rounded,
//                           size: 20,
//                           color: accentColor,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               item["title"]??"no title",
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               _formatTime(item["created_at"]??"no date"),
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey[700],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         "+${item["points"]??"nom points"}",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green[700],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // -----------------------------
//   // UI HELPERS (UNCHANGED)
//   // -----------------------------
//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   Widget _buildSummaryCard(
//     BuildContext context, {
//     required IconData icon,
//     required String value,
//     required String label,
//   }) {
//     final width = MediaQuery.of(context).size.width;
//     final cardWidth = (width - 16 * 2 - 12 * 2) / 3;

//     return SizedBox(
//       width: cardWidth < 120 ? 140 : cardWidth,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Color(0xFF0B1623),
//               Color(0xFF002B3D),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           children: [
//             Icon(icon, size: 26, color: accentColor),
//             const SizedBox(height: 10),
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 24,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 13,
//                 color: Colors.white.withOpacity(0.7),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:citywatchapp/API/loginAPI.dart';
import 'package:citywatchapp/API/registerAPi.dart' hide dio;
import 'package:flutter/material.dart';

class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  // -----------------------------
  // DYNAMIC STATE (FROM BACKEND)
  // -----------------------------
  int totalPoints = 0;
  int userRank = 0;
  int badgesEarned = 0;

  List<dynamic> badges = [];
  List<dynamic> activities = [];

  // 🔥 ADDITION
  bool showAllActivities = false;

  // Accent color used in the app
  Color get accentColor => const Color(0xFF00B4D8);

  // -----------------------------
  // API CALL
  // -----------------------------
  Future<void> viewPoints() async {
    try {
      final response = await dio.get(
        "$url/UserPointsAPI/$loginid",
      );

      final data = response.data;

      setState(() {
        totalPoints = data["summary"]["total_points"];
        userRank = data["summary"]["user_rank"];
        badgesEarned = data["summary"]["badges_earned"];

        badges = data["badges"];
        activities = data["activities"];
      });
    } catch (e) {
      print("Failed to load points: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    viewPoints();
  }

  // -----------------------------
  // DATE FORMATTER
  // -----------------------------
  String _formatTime(String date) {
    final dt = DateTime.parse(date);
    return "${dt.day}/${dt.month}/${dt.year}";
  }

  // 🔥 ADDITION
  List<dynamic> get visibleActivities {
    if (showAllActivities) return activities;
    return activities.take(3).toList();
  }

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
                final isEarned = badge["is_earned"] == true;

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
                        badge["title"],
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
                          badge["subtitle"],
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
                        "+${badge["points"]} pts",
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

            // 🔥 UPDATED HEADER WITH VIEW ALL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle("Recent Activities"),
                if (activities.length > 3)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showAllActivities = !showAllActivities;
                      });
                    },
                    child: Text(
                      showAllActivities ? "Show Less" : "View All",
                      style: TextStyle(
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: visibleActivities.length,
              itemBuilder: (context, index) {
                final item = visibleActivities[index];

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
                              item["title"] ?? "No title",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatTime(item["created_at"]),
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
                        "+${item["points"]}",
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

  // -----------------------------
  // UI HELPERS (UNCHANGED)
  // -----------------------------
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
