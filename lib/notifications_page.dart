// import 'package:flutter/material.dart';

// class NotificationsPage extends StatefulWidget {
//   const NotificationsPage({super.key});

//   @override
//   State<NotificationsPage> createState() => _NotificationsPageState();
// }

// class _NotificationsPageState extends State<NotificationsPage> {
//   // ----------------------------------------------------
//   // TEMPORARY STATIC DATA (NOW MUTABLE)
//   // ----------------------------------------------------
//   List<Map<String, dynamic>> notifications = [
//     {
//       "type": "acknowledgement",
//       "title": "Complaint Acknowledged",
//       "message": "Your complaint #C1234 about road damage has been received.",
//       "time": "5 min ago",
//       "isRead": false,
//     },
//     {
//       "type": "status_change",
//       "title": "Status Updated to In Progress",
//       "message": "Complaint #C1234 is now being worked on by the Road Dept.",
//       "time": "2 hours ago",
//       "isRead": false,
//     },
//     {
//       "type": "deadline_extension",
//       "title": "Deadline Extended",
//       "message":
//           "Authority requested more time. New deadline for complaint #C1234 is 28 Nov 2025.",
//       "time": "Yesterday",
//       "isRead": true,
//     },
//     {
//       "type": "resolved",
//       "title": "Complaint Resolved",
//       "message": "Your complaint #C1200 (Street light issue) is marked resolved.",
//       "time": "2 days ago",
//       "isRead": true,
//     },
//   ];

//   // ----------------------------------------------------
//   // ICON + COLOR HELPERS
//   // ----------------------------------------------------
//   IconData _iconForType(String type) {
//     switch (type) {
//       case "acknowledgement":
//         return Icons.mark_email_read_outlined;
//       case "status_change":
//         return Icons.sync_alt_outlined;
//       case "deadline_extension":
//         return Icons.schedule_outlined;
//       case "resolved":
//         return Icons.check_circle_outline;
//       default:
//         return Icons.notifications_none_outlined;
//     }
//   }

//   Color _colorForType(String type) {
//     switch (type) {
//       case "acknowledgement":
//         return Colors.blue;
//       case "status_change":
//         return Colors.orange;
//       case "deadline_extension":
//         return Colors.purple;
//       case "resolved":
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }

//   // ----------------------------------------------------
//   // MARK ALL AS READ
//   // ----------------------------------------------------
//   void _markAllAsRead() {
//     setState(() {
//       for (var n in notifications) {
//         n["isRead"] = true;
//       }
//     });
//   }

//   // ----------------------------------------------------
//   // MARK SINGLE NOTIFICATION AS READ
//   // ----------------------------------------------------
//   void _markOneAsRead(int index) {
//     setState(() {
//       notifications[index]["isRead"] = true;
//     });
//   }

//   // ----------------------------------------------------
//   // REUSABLE NOTIFICATION CARD
//   // ----------------------------------------------------
//   Widget _notificationCard(Map<String, dynamic> item, int index) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: item["isRead"] ? Colors.white : Colors.blue[50],
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: _colorForType(item["type"]).withOpacity(0.15),
//           child: Icon(
//             _iconForType(item["type"]),
//             color: _colorForType(item["type"]),
//           ),
//         ),
//         title: Text(
//           item["title"],
//           style: TextStyle(
//             fontWeight: item["isRead"] ? FontWeight.w500 : FontWeight.bold,
//             fontSize: 15,
//           ),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 4),
//             Text(
//               item["message"],
//               style: TextStyle(
//                 color: Colors.grey[700],
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               item["time"],
//               style: TextStyle(
//                 color: Colors.grey[500],
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//         trailing: item["isRead"]
//             ? null
//             : Container(
//                 width: 10,
//                 height: 10,
//                 decoration: const BoxDecoration(
//                   color: Colors.red,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//         onTap: () {
//           _markOneAsRead(index);
//           // Later: open complaint details screen here
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final unread = <Map<String, dynamic>>[];
//     final read = <Map<String, dynamic>>[];

//     for (var i = 0; i < notifications.length; i++) {
//       if (notifications[i]["isRead"] == false) {
//         unread.add({...notifications[i], "index": i});
//       } else {
//         read.add({...notifications[i], "index": i});
//       }
//     }

//     final bool hasUnread = unread.isNotEmpty;

//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text("Notifications"),
//         backgroundColor: Colors.blue[800],
//         elevation: 0,
//         actions: [
//           if (hasUnread)
//             TextButton(
//               onPressed: _markAllAsRead,
//               child: const Text(
//                 "Mark all as read",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//         ],
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ------------------------------
//             // UNREAD SECTION
//             // ------------------------------
//             if (unread.isNotEmpty)
//               const Padding(
//                 padding: EdgeInsets.only(bottom: 10, left: 5),
//                 child: Text(
//                   "Unread",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),

//             ...unread.map((n) {
//               final idx = n["index"] as int;
//               return _notificationCard(notifications[idx], idx);
//             }),

//             const SizedBox(height: 25),

//             // ------------------------------
//             // READ SECTION
//             // ------------------------------
//             if (read.isNotEmpty)
//               const Padding(
//                 padding: EdgeInsets.only(bottom: 10, left: 5),
//                 child: Text(
//                   "Read",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),

//             ...read.map((n) {
//               final idx = n["index"] as int;
//               return _notificationCard(notifications[idx], idx);
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:citywatchapp/API/loginAPI.dart';
import 'package:citywatchapp/API/registerAPi.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // ----------------------------------------------------
  // NOTIFICATION DATA (FROM API)
  // ----------------------------------------------------
  List<Map<String, dynamic>> notifications = [];

  // ----------------------------------------------------
  // INIT
  // ----------------------------------------------------
  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  // ----------------------------------------------------
  // FETCH NOTIFICATIONS USING DIO
  // ----------------------------------------------------
  Future<void> fetchNotifications() async {
    try {
      // 🔴 replace with actual login id

      final response = await Dio().get(
        "$url/api/notifications/$loginid",
      );

      if (response.statusCode == 200) {
        print(response);
        final List data = response.data["data"];

        setState(() {
          notifications = data.map((n) {
            return {
              "type": _mapStatusToType(n["status"] ?? '') ,
              "title": "Complaint #${n["comp_id"] ?? ''}",
              "message": n["Description"] ?? '',
              "time": _formatDate(n["Date"] ?? ''),
              "status": n["status"] ?? '',
              "isRead": false,
            };
          }).toList();
        });
      }
    } catch (e) {
      print("Notification API error: $e");
    }
  }

  // ----------------------------------------------------
  // STATUS → TYPE
  // ----------------------------------------------------
  String _mapStatusToType(String status) {
    switch (status.toLowerCase()) {
      case "resolved":
        return "resolved";
      case "in progress":
        return "status_change";
      case "pending":
        return "acknowledgement";
      default:
        return "status_change";
    }
  }

  // ----------------------------------------------------
  // DATE FORMAT
  // ----------------------------------------------------
  String _formatDate(String date) {
    final d = DateTime.parse(date);
    final diff = DateTime.now().difference(d);

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hours ago";
    } else {
      return "${diff.inDays} days ago";
    }
  }

  // ----------------------------------------------------
  // ICON + COLOR HELPERS
  // ----------------------------------------------------
  IconData _iconForType(String type) {
    switch (type) {
      case "acknowledgement":
        return Icons.mark_email_read_outlined;
      case "status_change":
        return Icons.sync_alt_outlined;
      case "deadline_extension":
        return Icons.schedule_outlined;
      case "resolved":
        return Icons.check_circle_outline;
      default:
        return Icons.notifications_none_outlined;
    }
  }

  Color _colorForType(String type) {
    switch (type) {
      case "acknowledgement":
        return Colors.blue;
      case "status_change":
        return Colors.orange;
      case "deadline_extension":
        return Colors.purple;
      case "Resolved":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  // ----------------------------------------------------
  // MARK ALL AS READ
  // ----------------------------------------------------
  void _markAllAsRead() {
    setState(() {
      for (var n in notifications) {
        n["isRead"] = true;
      }
    });
  }

  // ----------------------------------------------------
  // MARK SINGLE AS READ
  // ----------------------------------------------------
  void _markOneAsRead(int index) {
    setState(() {
      notifications[index]["isRead"] = true;
    });
  }

  // ----------------------------------------------------
  // NOTIFICATION CARD
  // ----------------------------------------------------
  Widget _notificationCard(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: item["isRead"] ? Colors.white : Colors.blue[50],
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _colorForType(item["type"]).withOpacity(0.15),
          child: Icon(
            _iconForType(item["type"]),
            color: _colorForType(item["type"]),
          ),
        ),
        title: Text(
          item["title"],
          style: TextStyle(
            fontWeight: item["isRead"] ? FontWeight.w500 : FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              item["message"],
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 6),
            Text(
              item["time"],
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
            Text(
              item["status"],
              style: TextStyle(color: item["status"]=='Resolved'?Colors.green:Colors.grey[500], fontSize: 12),
            ),
          ],
        ),
        trailing: item["isRead"]
            ? null
            : Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
        onTap: () {
          _markOneAsRead(index);
        },
      ),
    );
  }

  // ----------------------------------------------------
  // UI
  // ----------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final unread = <Map<String, dynamic>>[];
    final read = <Map<String, dynamic>>[];

    for (var i = 0; i < notifications.length; i++) {
      if (notifications[i]["isRead"] == false) {
        unread.add({...notifications[i], "index": i});
      } else {
        read.add({...notifications[i], "index": i});
      }
    }

    final bool hasUnread = unread.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        actions: [
          if (hasUnread)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                "Mark all as read",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (unread.isNotEmpty)
              const Padding(
                padding: EdgeInsets.only(bottom: 10, left: 5),
                child: Text(
                  "Unread",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ...unread.map((n) {
              final idx = n["index"] as int;
              return _notificationCard(notifications[idx], idx);
            }),
            const SizedBox(height: 25),
            if (read.isNotEmpty)
              const Padding(
                padding: EdgeInsets.only(bottom: 10, left: 5),
                child: Text(
                  "Read",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ...read.map((n) {
              final idx = n["index"] as int;
              return _notificationCard(notifications[idx], idx);
            }),
          ],
        ),
      ),
    );
  }
}
