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

// ===============================
// DIO INSTANCE
// ===============================
final Dio dio = Dio();

// ===============================
// DIO GET API – FETCH MY COMPLAINTS
// ===============================
Future<List<Map<String, String>>> fetchMyComplaints() async {
  try {
    final response = await dio.get("$url/send-complaint/$loginid");
print(response.data);
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
  // ===============================
  // COUNTS
  // ===============================
  int total = 0;
  int pending = 0;
  int assigned = 0;
  int inProgress = 0;
  int resolved = 0;

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

          pending = complaint
              .where((c) => c["Status"]!.toLowerCase() == "pending")
              .length;

          assigned = complaint
              .where((c) => c["Status"]!.toLowerCase() == "assigned")
              .length;

          inProgress = complaint
              .where((c) => c["Status"]!.toLowerCase() == "in progress")
              .length;

          resolved = complaint
              .where((c) => c["Status"]!.toLowerCase() == "resolved")
              .length;
        });
      }
    });
  }

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange;
      case "assigned":
        return Colors.purple;
      case "in progress":
        return Colors.blue;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = complaint.where((c) {
      final matchStatus =
          statusFilter == "All" || c["Status"] == statusFilter;
      final matchCategory =
          categoryFilter == "All" || c["Category"] == categoryFilter;
      return matchStatus && matchCategory;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Complaints"),
        backgroundColor: const Color(0xFF009DCC),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          // ===============================
          // TOP STATS
          // ===============================
          Row(
            children: [
              Expanded(
                child: _bigStatCard(
                    "Total Complaints", total, Colors.blue[800]!),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _bigStatCard(
                    "Resolved", resolved, Colors.green),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // ===============================
          // SMALL STATS (ORDER CHANGED)
          // ===============================
          Row(children: [
            Expanded(child: _statCard("Pending", pending, Colors.orange)),
            const SizedBox(width: 10),
            Expanded(child: _statCard("Assigned", assigned, Colors.purple)),
            const SizedBox(width: 10),
            Expanded(child: _statCard("In Progress", inProgress, Colors.blue)),
          ]),

          const SizedBox(height: 25),

          const Text(
            "Your Complaints",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

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
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              c["Category"]!,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: statusColor(c["Status"]!)
                                    .withOpacity(0.15),
                              ),
                              child: Text(
                                c["Status"]!,
                                style: TextStyle(
                                  color:
                                      statusColor(c["Status"]!),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                      const SizedBox(height: 10),
                      Text(
                        c["Description"]!,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Submitted: ${c["SubmitDate"]}",
                        style:
                            TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ComplaintDetailsPage(
                                  complaintid:
                                      c['id'].toString(),
                                ),
                              ),
                            );
                          },
                          child:
                              const Text("View Details →"),
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

  // ===============================
  // UI HELPERS
  // ===============================
  Widget _bigStatCard(String title, int count, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10),
        ],
      ),
      child: Column(children: [
        Text(title,
            style: TextStyle(
                color: color, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(
          "$count",
          style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: color),
        ),
      ]),
    );
  }

  Widget _statCard(String title, int count, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5),
        ],
      ),
      child: Column(children: [
        Text(title,
            style: TextStyle(
                color: color, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(
          "$count",
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: color),
        ),
      ]),
    );
  }
}
