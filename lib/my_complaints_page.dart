// import 'package:flutter/material.dart';
// import 'complaint_details.dart';

// class MyComplaintsPage extends StatefulWidget {
//   const MyComplaintsPage({super.key});

//   @override
//   State<MyComplaintsPage> createState() => _MyComplaintsPageState();
// }

// class _MyComplaintsPageState extends State<MyComplaintsPage> {
//   final int total = 18;
//   final int pending = 5;
//   final int inProgress = 7;
//   final int resolved = 6;

//   String statusFilter = "All";
//   String categoryFilter = "All";

//   final List<Map<String, String>> complaints = [
//     {
//       "category": "Road Damage",
//       "status": "Pending",
//       "description": "Big pothole near market.",
//       "submitDate": "2025-10-12",
//       "image": "assets/pothole.jpg",
//     },
//     {
//       "category": "Water Leakage",
//       "status": "In Progress",
//       "description": "Leakage on MG Road.",
//       "submitDate": "2025-10-10",
//       "image": "assets/water.jpg",
//     },
//     {
//       "category": "Street Light",
//       "status": "Resolved",
//       "description": "Light not working for 3 days.",
//       "submitDate": "2025-10-05",
//       "image": "assets/light.jpg",
//     },
//   ];

//   Color statusColor(String status) {
//     switch (status) {
//       case "Pending":
//         return Colors.orange;
//       case "In Progress":
//         return Colors.blue;
//       default:
//         return Colors.green;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredList = complaints.where((c) {
//       final matchStatus = statusFilter == "All" || c["status"] == statusFilter;
//       final matchCategory =
//           categoryFilter == "All" || c["category"] == categoryFilter;
//       return matchStatus && matchCategory;
//     }).toList();

//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text("My Complaints"),
//         backgroundColor: const Color(0xFF009DCC),
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),

//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // BIG TOTAL BOX
//             _bigStatCard("Total Complaints", total, Colors.blue[800]!),
//             const SizedBox(height: 15),

//             // 3 SMALL BOXES
//             Row(
//               children: [
//                 Expanded(child: _statCard("Pending", pending, Colors.orange)),
//                 const SizedBox(width: 10),
//                 Expanded(child: _statCard("In Progress", inProgress, Colors.blue)),
//                 const SizedBox(width: 10),
//                 Expanded(child: _statCard("Resolved", resolved, Colors.green)),
//               ],
//             ),

//             const SizedBox(height: 25),

//             // FILTER ROW (FIXED)
//             Row(
//               children: [
//                 // FILTER ICON
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: const Icon(Icons.filter_list,
//                       size: 22, color: Colors.black54),
//                 ),

//                 const SizedBox(width: 8),

//                 // STATUS DROPDOWN (short)
//                 Flexible(
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     decoration: _filterBox(),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         value: statusFilter,
//                         isExpanded: false,
//                         icon: const Icon(Icons.arrow_drop_down),
//                         items: const [
//                           DropdownMenuItem(value: "All", child: Text("Status")),
//                           DropdownMenuItem(value: "Pending", child: Text("Pending")),
//                           DropdownMenuItem(
//                               value: "In Progress", child: Text("In Progress")),
//                           DropdownMenuItem(value: "Resolved", child: Text("Resolved")),
//                         ],
//                         onChanged: (value) =>
//                             setState(() => statusFilter = value!),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 8),

//                 // CATEGORY DROPDOWN (short)
//                 Flexible(
//                   child: SingleChildScrollView(scrollDirection: Axis.horizontal,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       decoration: _filterBox(),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           value: categoryFilter,
//                           isExpanded: false,
//                           icon: const Icon(Icons.arrow_drop_down),
//                           items: const [
//                             DropdownMenuItem(value: "All", child: Text("Category")),
//                             DropdownMenuItem(
//                                 value: "Road Damage", child: Text("Road Damage")),
//                             DropdownMenuItem(
//                                 value: "Water Leakage", child: Text("Water Leakage")),
//                             DropdownMenuItem(
//                                 value: "Street Light", child: Text("Street Light")),
//                           ],
//                           onChanged: (value) =>
//                               setState(() => categoryFilter = value!),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 25),

//             const Text(
//               "Your Complaints",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 15),

//             // COMPLAINT LIST
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: filteredList.length,
//               itemBuilder: (context, index) {
//                 final c = filteredList[index];

//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 15),
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(14),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 5,
//                       )
//                     ],
//                   ),

//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Header row
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             c["category"]!,
//                             style: const TextStyle(
//                                 fontSize: 17, fontWeight: FontWeight.bold),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 6),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: statusColor(c["status"]!).withOpacity(0.15),
//                             ),
//                             child: Text(
//                               c["status"]!,
//                               style: TextStyle(
//                                 color: statusColor(c["status"]!),
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 10),

//                       Text(
//                         c["description"]!,
//                         style: TextStyle(fontSize: 15, color: Colors.grey[700]),
//                       ),

//                       const SizedBox(height: 10),

//                       Text(
//                         "Submitted: ${c["submitDate"]}",
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),

//                       const SizedBox(height: 10),

//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) =>
//                                     ComplaintDetailsPage(),
//                               ),
//                             );
//                           },
//                           child: const Text("View Details →"),
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

//   // BIG TOTAL CARD
//   Widget _bigStatCard(String title, int count, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 10,
//           )
//         ],
//       ),

//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,

//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               color: color,
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),

//           const SizedBox(height: 10),

//           Text(
//             "$count",
//             style: TextStyle(
//               fontSize: 42,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // SMALL STAT CARD
//   Widget _statCard(String title, int count, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 5,
//           )
//         ],
//       ),
//       child: Column(
//         children: [
//           Text(title,
//               style: TextStyle(color: color, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 8),
//           Text(
//             "$count",
//             style: TextStyle(
//                 fontSize: 26, fontWeight: FontWeight.bold, color: color),
//           ),
//         ],
//       ),
//     );
//   }

//   // FILTER BOX STYLE
//   BoxDecoration _filterBox() {
//     return BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(12),
//       border: Border.all(color: Colors.grey.shade300),
//     );
//   }
// }
import 'dart:core';

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
  // COUNTS (DYNAMIC)
  // ===============================
  int total = 0;
  int pending = 0;
  int inProgress = 0;
  int resolved = 0;

  String statusFilter = "All";
  String categoryFilter = "All";

  // ===============================
  // COMPLAINT LIST FROM API
  // ===============================
  List<Map<String, String>> complaint = [];

  // ===============================
  // CALL API ON PAGE LOAD
  // ===============================
  @override
  void initState() {
    super.initState();

    fetchMyComplaints().then((apiData) {
      if (apiData.isNotEmpty) {
        setState(() {
          complaint = apiData;

          // ===============================
          // CALCULATE COUNTS BY STATUS
          // ===============================
          total = complaint.length;

          pending = complaint
              .where((c) => c["Status"]!.toLowerCase() == "pending")
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
          _bigStatCard("Total Complaints", total, Colors.blue[800]!),
          const SizedBox(height: 15),

          Row(children: [
            Expanded(child: _statCard("Pending", pending, Colors.orange)),
            const SizedBox(width: 10),
            Expanded(
              child: _statCard("In Progress", inProgress, Colors.blue),
            ),
            const SizedBox(width: 10),
            Expanded(child: _statCard("Resolved", resolved, Colors.green)),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  color: statusColor(c["Status"]!),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                      const SizedBox(height: 10),
                      Text(
                        c["Description"]!,
                        style: TextStyle(
                            fontSize: 15, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Submitted: ${c["SubmitDate"]}",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ComplaintDetailsPage(complaintid: c['id'].toString(),),
                              ),
                            );
                          },
                          child: const Text("View Details →"),
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
  // UI HELPERS (UNCHANGED)
  // ===============================
  Widget _bigStatCard(String title, int count, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10),
        ],
      ),
      child: Column(children: [
        Text(title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(
          "$count",
          style: TextStyle(
              fontSize: 42, fontWeight: FontWeight.bold, color: color),
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
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
        ],
      ),
      child: Column(children: [
        Text(title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(
          "$count",
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold, color: color),
        ),
      ]),
    );
  }
}
