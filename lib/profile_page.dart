import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // ------------------------------------------------------
  // TEMPORARY STATIC USER DATA (replace with backend later)
  // ------------------------------------------------------
  final String userName = "Saranya M K";
  final String userEmail = "saranya@example.com";
  final String userPhone = "+91 98765 43210";
  final String userImage = ""; // leave empty → default avatar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.blue[800],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ------------------------------------------------------
            // PROFILE PHOTO + NAME + EMAIL
            // ------------------------------------------------------
            Center(
              child: Column(
                children: [

                  // ---------------------------
                  // PROFILE PHOTO
                  // ---------------------------
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.blue[800],

                    // If no image → show default icon
                    child: userImage.isEmpty
                        ? const Icon(Icons.person, size: 55, color: Colors.white)
                        : null,
                  ),

                  const SizedBox(height: 15),

                  // USER NAME
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // EMAIL
                  Text(
                    userEmail,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // PHONE
                  Text(
                    userPhone,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ------------------------------------------------------
                  // EDIT PROFILE BUTTON
                  // ------------------------------------------------------
                  ElevatedButton.icon(
                    onPressed: () {
                      // navigate to edit profile page later
                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ------------------------------------------------------
            // SETTINGS TITLE
            // ------------------------------------------------------
            const Text(
              "Settings",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            // ------------------------------------------------------
            // SETTINGS OPTIONS LIST
            // ------------------------------------------------------
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
              icon: Icons.info_outline,
              title: "About",
              onTap: () {},
            ),

            const SizedBox(height: 25),

            // ------------------------------------------------------
            // LOGOUT BUTTON
            // ------------------------------------------------------
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Clear session later & navigate to login
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------
  // SETTINGS TILE WIDGET (Reusable)
  // ------------------------------------------------------
  Widget _settingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: ListTile(
        leading: Icon(icon, color: Colors.blue[800]),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
