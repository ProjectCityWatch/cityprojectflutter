import 'package:citywatchapp/API/loginAPI.dart';
import 'package:citywatchapp/API/registerAPi.dart' hide dio;
import 'package:citywatchapp/login.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ------------------------------------------------------
  Future<Map<String, dynamic>> viewProfile(int loginId) async {
    try {
      final response = await dio.get(
        "$url/viewprofile/$loginId",
      );

      return response.data;
    } catch (e) {
      throw Exception("Failed to load profile");
    }
  }

  String userName = "";
  String userEmail = "";
  String userPhone = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final result = await viewProfile(loginid!);

      if (result["status"] == "success" && result["data"].isNotEmpty) {
        final user = result["data"][0];

        setState(() {
          userName = user["Name"] ?? "";
          userEmail = user["Email"] ?? "";
          userPhone = user["PhoneNo"] ?? "";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration cardBox = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.grey.shade300),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 80, 20, 40),
        child: Column(
          children: [
            // =============================
            // PROFILE CARD
            // =============================
            Container(
              padding: const EdgeInsets.all(22),
              decoration: cardBox,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 52,
                    backgroundColor:
                        const Color(0xFF009DCC).withOpacity(0.15),
                    child: const Icon(
                      Icons.person,
                      size: 52,
                      color: Color(0xFF009DCC),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    userEmail,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    userPhone,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF009DCC),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            // =============================
            // SETTINGS CARD
            // =============================
            Container(
              padding: const EdgeInsets.all(18),
              decoration: cardBox,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 16),

                  _settingsItem(
                    icon: Icons.notifications_active_outlined,
                    title: "Notifications",
                    onTap: () {},
                  ),
                  _settingsItem(
                    icon: Icons.shield_outlined,
                    title: "Privacy & Security",
                    onTap: () {},
                  ),
                  _settingsItem(
                    icon: Icons.help_outline,
                    title: "Help & Support",
                    onTap: () {},
                  ),
                  _settingsItem(
                    icon: Icons.feedback_outlined,
                    title: "Feedback",
                    onTap: () {},
                  ),
                  _settingsItem(
                    icon: Icons.info_outline,
                    title: "About",
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            // =============================
            // LOGOUT
            // =============================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "LOGOUT",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================
  Widget _settingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF009DCC)),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
