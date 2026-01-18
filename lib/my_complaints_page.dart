import 'dart:core';

import 'package:citywatchapp/API/registerAPi.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:citywatchapp/API/loginAPI.dart';
import 'complaint_details.dart';

class MyComplaintsPage extends StatefulWidget {
  const MyComplaintsPage({super.key});

  @override
  State<MyComplaintsPage> createState() => _MyComplaintsPageState();
}

final Dio dio = Dio();

Future<List<Map<String, String>>> fetchMyComplaints() async {
  try {
    final response = await dio.get("$url/send-complaint/$loginid");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return List<Map<String, String>>.from(
        response.data.map((e) => {
              "id": e["id"].toString(),
              "Category": e["Category"].toString(),
              "Description": e["Description"].toString(),
              "Priority": e["Priority"].toString(),
              "Image": e["Image"].toString(),
              "Latitude": e["Latitude"].toString(),
              "Longitude": e["Longitude"].toString(),
              "Status": e["Status"].toString(),
              "SubmitDate": e["SubmitDate"].toString(),
            }),
      );
    }
  } catch (e) {
    debugPrint("Dio GET error: $e");
  }
  return [];
}

class _MyComplaintsPageState extends State<MyComplaintsPage> {
  int total = 0;
  int pending = 0;
  int assigned = 0;
  int inProgress = 0;
  int resolved = 0;
  int datefixed = 0;
  int extended = 0;

  String statusFilter = "All";
  String categoryFilter = "All";

  List<Map<String, String>> complaint = [];

  @override
  void initState() {
    super.initState();

    fetchMyComplaints().then((apiData) {
      if (apiData.isNotEmpty) {
        setState(() {
          complaint = apiData;

          total = complaint.length;
          pending =
              complaint.where((c) => c["Status"]!.toLowerCase() == "pending").length;
          assigned =
              complaint.where((c) => c["Status"]!.toLowerCase() == "assigned").length;
          inProgress =
              complaint.where((c) => c["Status"]!.toLowerCase() == "in progress").length;
          resolved =
              complaint.where((c) => c["Status"]!.toLowerCase() == "resolved").length;
          datefixed =
              complaint.where((c) => c["Status"]!.toLowerCase() == "date fixed").length;
          extended =
              complaint.where((c) => c["Status"]!.toLowerCase() == "extended").length;
        });
      }
    });
  }

  // ===============================
  // STATUS COLORS (UNCHANGED)
  // ===============================
  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange;
      case "assigned":
        return Colors.purple;
      case "in progress":
        return Colors.blue;
      case "date fixed":
        return Colors.red;
      case "extended":
        return Colors.yellow.shade700;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = complaint.where((c) {
      final matchStatus =
          statusFilter == "All" ||
          c["Status"]!.toLowerCase() == statusFilter.toLowerCase();

      final matchCategory =
          categoryFilter == "All" || c["Category"] == categoryFilter;

      return matchStatus && matchCategory;
    }).toList();

    BoxDecoration cardBox = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade300),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF009DCC),
        centerTitle: true,
        title: const Text(
          "My Complaints",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ===============================
          // TOP STATS
          // ===============================
          Row(
            children: [
              Expanded(child: _bigStatCard("Total", total)),
              const SizedBox(width: 12),
              Expanded(child: _bigStatCard("Resolved", resolved)),
            ],
          ),

          const SizedBox(height: 16),

          Row(children: [
            Expanded(child: _statCard("Pending", pending, Colors.orange)),
            const SizedBox(width: 10),
            Expanded(child: _statCard("Assigned", assigned, Colors.purple)),
            const SizedBox(width: 10),
            Expanded(child: _statCard("In Progress", inProgress, Colors.blue)),
          ]),

          const SizedBox(height: 10),

          Row(children: [
            Expanded(child: _statCard("Date Fixed", datefixed, Colors.red)),
            const SizedBox(width: 10),
            Expanded(child: _statCard("Extended", extended, Colors.yellow.shade700)),
          ]),

          const SizedBox(height: 24),

          // ===============================
          // FILTER PANEL
          // ===============================
          Container(
            padding: const EdgeInsets.all(14),
            decoration: cardBox,
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: statusFilter,
                    decoration: InputDecoration(
                      labelText: "Status",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    items: const [
                      "All",
                      "Pending",
                      "Assigned",
                      "In Progress",
                      "Resolved",
                      "Date Fixed",
                      "Extended",
                    ]
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (value) => setState(() => statusFilter = value!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: categoryFilter,
                    decoration: InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    items: [
                      "All",
                      ...complaint.map((c) => c["Category"]!).toSet(),
                    ]
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (value) => setState(() => categoryFilter = value!),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Text(
            "Your Complaints (${filteredList.length})",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 16),

          // ===============================
          // COMPLAINT LIST
          // ===============================
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final c = filteredList[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: cardBox,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        c["Category"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: statusColor(c["Status"]!).withOpacity(0.15),
                        ),
                        child: Text(
                          c["Status"]!,
                          style: TextStyle(
                            color: statusColor(c["Status"]!),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    c["Description"]!,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Submitted: ${c["SubmitDate"]}",
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF009DCC)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ComplaintDetailsPage(
                              complaintid: c['id'].toString(),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "View Details",
                        style: TextStyle(
                          color: Color(0xFF009DCC),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ]),
              );
            },
          ),
        ]),
      ),
    );
  }

  Widget _bigStatCard(String title, int count) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF009DCC),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(children: [
        Text(title, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        Text(
          "$count",
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ]),
    );
  }

  Widget _statCard(String title, int count, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(children: [
        Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Text(
          "$count",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
