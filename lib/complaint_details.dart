import 'package:citywatchapp/API/registerAPi.dart';
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
  bool showFullDescription = false;

  List<Map<String, dynamic>> timeline = [];

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

  String formatDate(String date) {
    return DateFormat("dd MMM yyyy, hh:mm a")
        .format(DateTime.parse(date).toLocal());
  }

  // ===============================
  // STATUS COLORS (AS REQUESTED)
  // ===============================
  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case "resolved":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "assigned":
        return Colors.purple;
      case "in progress":
        return Colors.blue;
      case "date fixed":
        return Colors.red;
      case "extended":
        return Colors.grey;
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
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Complaint Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2575FC), Color(0xFF6A11CB)],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          // ===============================
          // CATEGORY + STATUS (CENTERED)
          // ===============================
          Center(
            child: Column(
              children: [
                Text(
                  latest["Category"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor(latest["Status"]).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    latest["Status"],
                    style: TextStyle(
                      color: statusColor(latest["Status"]),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ===============================
          // DESCRIPTION (SHORTENED)
          // ===============================
          _sectionTitle("Description"),
          Text(
            latest["Description"],
            maxLines: showFullDescription ? null : 3,
            overflow: showFullDescription
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                showFullDescription = !showFullDescription;
              });
            },
            child: Text(showFullDescription ? "Show less" : "Read more"),
          ),

          const SizedBox(height: 16),

          // ===============================
          // SUBMITTED DATE
          // ===============================
          _sectionTitle("Submitted On"),
          Text(formatDate(latest["SubmitDate"])),

          const SizedBox(height: 20),

          // ===============================
          // IMAGE (SHORTER)
          // ===============================
          if (latest["Image"] != null && latest["Image"].toString().isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Complaint Image"),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    "$url${latest["Image"]}",
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        height: 120,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (_, __, ___) {
                      return Container(
                        height: 120,
                        color: Colors.grey.shade300,
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image,
                            size: 40, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ],
            ),

          const SizedBox(height: 28),

          // ===============================
          // TIMELINE (NO GAPS)
          // ===============================
          _sectionTitle("Timeline"),
          const SizedBox(height: 12),

          Column(
            children: List.generate(timeline.length, (index) {
              final t = timeline[index];
              final isLast = index == timeline.length - 1;

              return _timelineTile(
                title: t["Status"],
                date: formatDate(t["Date"]),
                color: statusColor(t["Status"]),
                showLine: !isLast,
              );
            }),
          ),

          const SizedBox(height: 20),

          _buildVerificationSection(latest["Status"]),
        ]),
      ),
    );
  }

  // ===============================
  // TIMELINE TILE (TIGHT, CONNECTED)
  // ===============================
  Widget _timelineTile({
    required String title,
    required String date,
    required Color color,
    required bool showLine,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration:
                  BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            if (showLine)
              Container(
                width: 3,
                height: 36, // 🔥 no gap
                color: color.withOpacity(0.5),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  date,
                  style:
                      TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // ===============================
  // VERIFY SECTION (UNCHANGED)
  // ===============================
  Widget _buildVerificationSection(String currentStatus) {
    if (currentStatus != "Resolved") return const SizedBox();

    if (isVerified) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.green, size: 26),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "Thank you! You confirmed that the issue is resolved.",
                style: TextStyle(
                  fontSize: 15,
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
        const SizedBox(height: 10),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700],
            padding: const EdgeInsets.symmetric(vertical: 12),
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
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
