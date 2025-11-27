import 'package:flutter/material.dart';

class ComplaintDetailsPage extends StatefulWidget {
  final Map<String, String> complaint;

  const ComplaintDetailsPage({super.key, required this.complaint});

  @override
  State<ComplaintDetailsPage> createState() => _ComplaintDetailsPageState();
}

class _ComplaintDetailsPageState extends State<ComplaintDetailsPage> {
  bool isVerified = false;

  Color statusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "In Progress":
        return Colors.blue;
      case "Resolved":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final complaint = widget.complaint;
    final String currentStatus = complaint["status"]!;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Text("Complaint Details"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // CATEGORY
            Text(
              complaint["category"]!,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // STATUS CHIP
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor(currentStatus).withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                currentStatus,
                style: TextStyle(
                  color: statusColor(currentStatus),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // DESCRIPTION
            _sectionTitle("Description"),
            Text(
              complaint["description"]!,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 25),

            // SUBMIT DATE
            _sectionTitle("Submitted On"),
            Text(
              complaint["submitDate"]!,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            _sectionTitle("Timeline"),
            const SizedBox(height: 20),

            // TIMELINE
            _timelineTile(
              title: "Submitted",
              date: complaint["submitDate"]!,
              completed: true,
            ),

            _timelineTile(
              title: "Assigned",
              date: complaint["assignedDate"] ?? "Not assigned yet",
              completed: currentStatus != "Pending",
            ),

            _timelineTile(
              title: "In Progress",
              date: complaint["inProgressDate"] ?? "Not started yet",
              completed: currentStatus == "In Progress" || currentStatus == "Resolved",
            ),

            _timelineTile(
              title: "Resolved",
              date: complaint["resolvedDate"] ?? "Not resolved yet",
              completed: currentStatus == "Resolved",
            ),

            if (complaint["extendedDate"] != null &&
                complaint["extendedDate"]!.isNotEmpty)
              _timelineTile(
                title: "Deadline Extended",
                date: complaint["extendedDate"]!,
                completed: true,
                color: Colors.purple,
              ),

            const SizedBox(height: 40),

            // ------------------------------
            // USER VERIFICATION
            // ------------------------------
            if (currentStatus == "Resolved") _buildVerificationSection(),
          ],
        ),
      ),
    );
  }

  // -----------------------------
  // SECTION TITLE
  // -----------------------------
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // -----------------------------
  // TIMELINE WIDGET
  // -----------------------------
  Widget _timelineTile({
    required String title,
    required String date,
    required bool completed,
    Color color = Colors.green,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // DOT & LINE
        Column(
          children: [
            // DOT
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: completed ? color : Colors.grey[400],
              ),
            ),

            // LINE
            Container(
              width: 3,
              height: 40,
              color: completed ? color : Colors.grey[400],
            ),
          ],
        ),

        const SizedBox(width: 14),

        // TITLE + DATE
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: completed ? FontWeight.bold : FontWeight.w500,
                color: completed ? color : Colors.grey[600],
              ),
            ),

            const SizedBox(height: 4),

            Text(
              date,
              style: TextStyle(
                fontSize: 14,
                color: completed ? color : Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------
  // USER VERIFICATION
  // ---------------------------------------------------
  Widget _buildVerificationSection() {
    if (isVerified) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.green, size: 30),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "Thank you! You confirmed that the issue is resolved.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Verify Resolution"),
        const SizedBox(height: 12),

        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700],
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            setState(() {
              isVerified = true;
            });
          },
          icon: const Icon(Icons.check_circle, color: Colors.white),
          label: const Text(
            "Yes, the issue is resolved",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
