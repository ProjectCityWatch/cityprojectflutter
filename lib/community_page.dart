
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart';
import 'package:citywatchapp/API/loginAPI.dart';
import 'package:citywatchapp/API/registerAPi.dart';import 'dart:math';
import 'package:geolocator/geolocator.dart';


class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final Color accentColor = const Color(0xFF00B4D8);

  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
bool showMyPosts = false;
bool showNearbyPosts = false;

double? myLat;
double? myLng;
bool locationLoading = false;


Future<void> _getMyLocationIfNeeded() async {
  if (myLat != null && myLng != null) return;

  setState(() => locationLoading = true);

  try {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    myLat = pos.latitude;
    myLng = pos.longitude;
  } finally {
    setState(() => locationLoading = false);
  }
}
double _distance(double lat1, double lon1, double lat2, double lon2) {
  const r = 6371;
  final dLat = (lat2 - lat1) * pi / 180;
  final dLon = (lon2 - lon1) * pi / 180;

  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1 * pi / 180) *
          cos(lat2 * pi / 180) *
          sin(dLon / 2) *
          sin(dLon / 2);

  return r * 2 * atan2(sqrt(a), sqrt(1 - a));
}

  String selectedCategory = "All Categories";

  final List<String> categories = const [
    "All Categories",
    "Road Damage",
    "Waste Dumping",
    "Noise Complaint",
    "Water Leakage",
    "Street Light",
  ];

  List<Map<String, dynamic>> feed = [];
  // ================= LOCAL LIKE CACHE =================
static const String _likedKey = "liked_complaints";
Set<int> _likedIds = {};
// ===================================================
@override
void initState() {
  super.initState();
  _init();
}

Future<void> _init() async {
  await _loadLikedIds();   // ✅ wait
  await _fetchComplaints();
}

Future<void> _loadLikedIds() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> saved = prefs.getStringList(_likedKey) ?? [];
  _likedIds = saved.map(int.parse).toSet();
}

Future<void> _saveLikedIds() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(
    _likedKey,
    _likedIds.map((e) => e.toString()).toList(),
  );
}

  // ================= LOCATION =================
  Future<String> _getLocationFromLatLng(double? lat, double? lng) async {
    if (lat == null || lng == null) return "Unknown location";

    try {
      final response = await Dio().get(
        "https://nominatim.openstreetmap.org/reverse",
        queryParameters: {
          "lat": lat,
          "lon": lng,
          "format": "json",
        },
        options: Options(headers: {"User-Agent": "citywatch-app"}),
      );

      final address = response.data["address"];
      return [
        address?["road"],
        address?["suburb"],
        address?["city"] ?? address?["town"] ?? address?["village"],
      ].where((e) => e != null).join(", ");
    } catch (_) {
      return "Unknown location";
    }
  }

  // ================= FETCH =================
  Future<void> _fetchComplaints() async {
  try {
    final response = await dio.get("$url/view-allcomplaints");print(response.data);
    final List data = response.data ?? [];

    List<Map<String, dynamic>> tempFeed = [];

    for (var item in data) {
      final lat = double.tryParse(item["Latitude"]?.toString() ?? "");
      final lng = double.tryParse(item["Longitude"]?.toString() ?? "");
      final location = await _getLocationFromLatLng(lat, lng);

      final int id = item["id"];
      final int totalLikes =
          int.tryParse(item["total_likes"]?.toString() ?? "0") ?? 0;

      // 🔥 AUTO-FIX: remove invalid local likes
      if (totalLikes == 0 && _likedIds.contains(id)) {
        _likedIds.remove(id);
      }

      tempFeed.add({
        "id": id,
        "username": item["Name"] ?? "Unknown",
        "location": location,
        "Category": item["Category"],
        "Status": item["Status"],
        "description": item["Description"],
        "imageUrl": item["Image"],
        "time": item["SubmitDate"],
        "upvotes": totalLikes,
        "comments": List<Map<String, dynamic>>.from(item["comments"] ?? []), // ✅ REQUIRED FOR NEARBY FILTER
  "Latitude": item["Latitude"],
  "Longitude": item["Longitude"],
      });
    }

    await _saveLikedIds();

    setState(() {
      feed = tempFeed.map((post) {
        final int id = post["id"];
        final int likes = post["upvotes"] ?? 0;

        return {
          ...post,
          // ✅ FINAL SOURCE OF TRUTH
          "is_liked": likes > 0 && _likedIds.contains(id),
        };
      }).toList();
    });
  } catch (e) {
    debugPrint("FETCH ERROR: $e");
  }
}

Future<void> _postLike(Map<String, dynamic> post) async {
  final bool currentlyLiked = post["is_liked"] ?? false;

  setState(() {
    feed = feed.map((p) {
      if (p["id"] == post["id"]) {
        final int currentLikes = p["upvotes"] ?? 0;

        if (currentlyLiked) {
          _likedIds.remove(post["id"]);
          return {
            ...p,
            "upvotes": currentLikes > 0 ? currentLikes - 1 : 0,
            "is_liked": false, // ⚪ GREY
          };
        } else {
          _likedIds.add(post["id"]);
          return {
            ...p,
            "upvotes": currentLikes + 1,
            "is_liked": true, // 🔵 BLUE
          };
        }
      }
      return p;
    }).toList();
  });

  _saveLikedIds();

  try {
    await dio.post(
      "$url/ComplaintLikeAPI/$loginid",
      data: {"ComplaintId": post["id"]},
    );
  } catch (e) {
    debugPrint("LIKE ERROR: $e");
  }
}

  // ================= COMMENT =================
  Future<void> _postComment(int id, String comment) async {
    try {
      await dio.post(
        "$url/ComplaintCommentAPI/$loginid",
        data: {"comp_id": id, "comment": comment},
      );
    } catch (e) {
      debugPrint("COMMENT ERROR: $e");
    }
  }

  // ================= HELPERS =================
  List<Map<String, dynamic>> _getTrending() {
    List<Map<String, dynamic>> sorted = [...feed];
    sorted.sort((a, b) {
      final int upA = a["upvotes"] ?? 0;
      final int upB = b["upvotes"] ?? 0;
      return upB.compareTo(upA);
    });
    return sorted.take(3).toList();
  }

  List<Map<String, dynamic>> _getFilteredFeed() {
    return feed.where((post) {
      if (selectedCategory == "All Categories") return true;
      return post["Category"] == selectedCategory;
    }).toList();
  }
List<Map<String, dynamic>> _getFinalFeed() {
  List<Map<String, dynamic>> base = _getFilteredFeed();

  // MY POSTS
  if (showMyPosts) {
    base = base.where((post) {
      return post["username"] == "Anoop Kumar"; // replace later with user id
    }).toList();
  }

  // NEARBY POSTS (5 km)
  if (showNearbyPosts) {
    if (myLat == null || myLng == null) return [];

    base = base.where((post) {
      final lat = double.tryParse(post["Latitude"]?.toString() ?? "");
      final lng = double.tryParse(post["Longitude"]?.toString() ?? "");
      if (lat == null || lng == null) return false;

      return _distance(myLat!, myLng!, lat, lng) <= 5;
    }).toList();
  }

  return base;
}

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange;
      case "assigned":
        return Colors.blue;
      case "resolved":
        return Colors.green;
      case "rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final trending = _getTrending();
final filteredFeed = _getFinalFeed();

    return Scaffold(
      appBar: AppBar(title: const Text("Community")),
      body: feed.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Community Feed",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    "Trending Issues",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 160,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: trending.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 12),
                      itemBuilder: (_, i) =>
                          _buildTrendingCard(trending[i]),
                    ),
                  ),

                  const SizedBox(height: 20),
                  _buildFilterBar(),
                  const SizedBox(height: 20),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredFeed.length,
                    itemBuilder: (_, i) =>
                        _buildPostCard(filteredFeed[i]),
                  ),
                ],
              ),
            ),
    );
  }

  // ================= POST CARD =================
  Widget _buildPostCard(Map<String, dynamic> post) {
    final comments =
        List<Map<String, dynamic>>.from(post["comments"] ?? []);

    final bool liked = post["is_liked"] ?? false;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(post["username"]),
            subtitle: Text(post["location"]),
          ),
          Image.network(
            url + post["imageUrl"],
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Category : ${post["Category"]}",style: TextStyle(fontSize: 15),),
                 Chip(
              label: Text(post["Status"]),
              backgroundColor:
                  _getStatusColor(post["Status"]).withOpacity(0.15),
            ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(post["description"]),
          ),
         
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                InkWell(
                  onTap: () => _postLike(post),
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: liked ? accentColor : Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        (post["upvotes"] ?? 0).toString(),
                        style: TextStyle(
                          color: liked ? accentColor : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => _openCommentsSheet(post),
                  child: Text("Comments (${comments.length})"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= COMMENTS =================
  void _openCommentsSheet(Map<String, dynamic> post) {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: post["comments"].length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(post["comments"][i]["CommentText"]),
                  subtitle: Text(post["comments"][i]["user_name"]),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration:
                        const InputDecoration(hintText: "Add comment"),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final text = controller.text.trim();
                    if (text.isEmpty) return;

                    setState(() {
                      post["comments"].add({
                        "CommentText": text,
                        "user_name": "You",
                        "CreatedAt": DateTime.now().toIso8601String(),
                      });
                    });

                    _postComment(post["id"], text);
                    controller.clear();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= FILTER BAR =================
  Widget _buildFilterBar() {
  return Column(
    children: [
      // ================= CATEGORY FILTER =================
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedCategory,
            isExpanded: true,
            items: categories
                .map(
                  (c) => DropdownMenuItem(
                    value: c,
                    child: Text(c),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() => selectedCategory = v!),
          ),
        ),
      ),

      const SizedBox(height: 12),

      // ================= FEED TYPE DROPDOWN =================
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: showNearbyPosts ? "Nearby Posts" : "All Posts",
            isExpanded: true,
            items: const [
              DropdownMenuItem(
                value: "All Posts",
                child: Text("All Posts"),
              ),
              DropdownMenuItem(
                value: "Nearby Posts",
                child: Text("Nearby Posts"),
              ),
            ],
            onChanged: (v) async {
              if (v == "Nearby Posts") {
                setState(() => showNearbyPosts = true);
                await _getMyLocationIfNeeded();
              } else {
                setState(() => showNearbyPosts = false);
              }
            },
          ),
        ),
      ),

      // ================= LOCATION LOADING =================
      if (locationLoading)
        const Padding(
          padding: EdgeInsets.all(12),
          child: CircularProgressIndicator(),
        ),
    ],
  );
}


  // ================= TRENDING CARD =================
  Widget _buildTrendingCard(Map<String, dynamic> post) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF003B5C), Color(0xFF00695C)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post["Category"],
              style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 8),
          Text(
            post["description"],
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
