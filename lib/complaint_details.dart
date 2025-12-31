import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:citywatchapp/API/loginAPI.dart';
import 'package:intl/intl.dart';

class ComplaintDetailsPage extends StatefulWidget {
  final String complaintid;


  const ComplaintDetailsPage({super.key, required this.complaintid});

  @override
  State<ComplaintDetailsPage> createState() => _ComplaintDetailsPageState();
}

class _ComplaintDetailsPageState extends State<ComplaintDetailsPage> {
  final Dio dio = Dio();
bool isVerified = false;

  // ===============================
  // TIMELINE DATA FROM API
  // ===============================
  List<Map<String, dynamic>> timeline = [];

  // ===============================
  // LOAD TIMELINE API
  // ===============================
  Future<void> fetchTimeline() async {
    try {
      final response =
          await dio.get("$url/view-timeline/${widget.complaintid}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          timeline = List<Map<String, dynamic>>.from(response.data);
        });
      }
    } catch (e) {
      debugPrint("Timeline API error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTimeline();
  }

  // ===============================
  // DATE FORMAT
  // ===============================
  String formatDate(String date) {
    return DateFormat("dd MMM yyyy, hh:mm a")
        .format(DateTime.parse(date).toLocal());
  }

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case "requested":
        return Colors.grey;
      case "assigned":
        return Colors.orange;
      case "in progress":
        return Colors.blue;
      case "resolved":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timeline.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final latest = timeline.last;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Complaint Details"),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          // CATEGORY
          Text(
            latest["Category"],
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          // STATUS CHIP
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor(latest["Status"]).withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              latest["Status"],
              style: TextStyle(
                color: statusColor(latest["Status"]),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // DESCRIPTION
          _sectionTitle("Description"),
          Text(latest["Description"], style: const TextStyle(fontSize: 16)),

          const SizedBox(height: 25),

          // SUBMITTED DATE
          _sectionTitle("Submitted On"),
          Text(formatDate(latest["SubmitDate"])),

          const SizedBox(height: 30),
const SizedBox(height: 25),

// ===============================
// COMPLAINT IMAGE
// ===============================
if (latest["Image"] != null && latest["Image"].toString().isNotEmpty)
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionTitle("Complaint Image"),
      const SizedBox(height: 10),

      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          "$url${latest["Image"]}", // base url + image path
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 220,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 220,
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Icon(
                Icons.broken_image,
                size: 50,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    ],
  ),
      const SizedBox(height: 10),

          _sectionTitle("Timeline"),
          const SizedBox(height: 20),

          // ===============================
          // DYNAMIC TIMELINE
          // ===============================
          Column(
            children: timeline.map((t) {
              return _timelineTile(
                title: t["Status"],
                date: formatDate(t["Date"]),
                color: statusColor(t["Status"]),
              );
            }).toList(),
          ),
_buildVerificationSection(latest["Status"]),

        ]),
      ),
    );
  }

  // ===============================
  // TIMELINE TILE
  // ===============================
  Widget _timelineTile({
    required String title,
    required String date,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration:
                  BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            Container(width: 3, height: 40, color: color),
          ],
        ),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color)),
          const SizedBox(height: 4),
          Text(date,
              style:
                  TextStyle(fontSize: 14, color: Colors.grey.shade600)),
        ]),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Text(text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }Widget _buildVerificationSection(String currentStatus) {
  // ❌ Do not show if status is NOT Resolved
  if (currentStatus != "Resolved") {
    return const SizedBox();
  }

  // ✅ After verification
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

  // 🟢 Show verify button ONLY for Resolved status
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
