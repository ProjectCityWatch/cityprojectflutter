import 'package:flutter/material.dart';

// COMMUNITY PAGE
// - Trending issues
// - Filters bar (Nearby / Recent + Categories)
// - Full feed with Like, Verify, Comments (bottom sheet)

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final Color accentColor = const Color(0xFF00B4D8);

  // SORT & FILTER STATE
  String selectedSort = "Nearby";
  String selectedCategory = "All Categories";

  final List<String> categories = const [
    "All Categories",
    "Road Damage",
    "Waste Dumping",
    "Noise Complaint",
    "Water Leakage",
    "Street Light",
  ];

  // FEED DATA
  List<Map<String, dynamic>> feed = [
    {
      "username": "Arjun",
      "location": "MG Road",
      "category": "Road Damage",
      "title": "Large Pothole on Main Street",
      "description":
          "Huge pothole causing vehicles to slow down and creating traffic jams.",
      "imageUrl": "https://picsum.photos/400/250?random=1",
      "time": "2 hours ago",
      "minutesAgo": 120,
      "distanceKm": 0.4,
      "upvotes": 88,
      "hasUpvoted": false,
      "supported": false,
      "comments": <String>[
        "This is dangerous!",
        "I travel this route daily."
      ],
    },
    {
      "username": "Sneha",
      "location": "Central Market",
      "category": "Waste Dumping",
      "title": "Garbage Dumped Near Market",
      "description":
          "Garbage bags left outside bins, causing smell and stray animals.",
      "imageUrl": "https://picsum.photos/400/250?random=2",
      "time": "5 hours ago",
      "minutesAgo": 300,
      "distanceKm": 1.2,
      "upvotes": 75,
      "hasUpvoted": false,
      "supported": true,
      "comments": <String>["Needs urgent cleaning."],
    },
    {
      "username": "Rahul",
      "location": "High Rise Blvd",
      "category": "Noise Complaint",
      "title": "Excessive Noise from Construction",
      "description":
          "Construction work continues till late night with loud drilling.",
      "imageUrl": "https://picsum.photos/400/250?random=3",
      "time": "1 day ago",
      "minutesAgo": 1440,
      "distanceKm": 2.5,
      "upvotes": 82,
      "hasUpvoted": false,
      "supported": false,
      "comments": <String>["Couldn't sleep yesterday."],
    },
    {
      "username": "Nisha",
      "location": "Lake View Road",
      "category": "Water Leakage",
      "title": "Underground Water Leakage",
      "description":
          "Continuous leakage causing slippery roads and clean water wastage.",
      "imageUrl": "https://picsum.photos/400/250?random=4",
      "time": "3 hours ago",
      "minutesAgo": 180,
      "distanceKm": 0.9,
      "upvotes": 40,
      "hasUpvoted": false,
      "supported": false,
      "comments": <String>[],
    },
  ];

  // SORTING HELPERS
  List<Map<String, dynamic>> _getTrending() {
    List<Map<String, dynamic>> sorted = [...feed];
    sorted.sort((a, b) => b["upvotes"].compareTo(a["upvotes"]));
    return sorted.take(3).toList();
  }

  List<Map<String, dynamic>> _getFilteredFeed() {
    List<Map<String, dynamic>> filtered = feed.where((post) {
      if (selectedCategory == "All Categories") return true;
      return post["category"] == selectedCategory;
    }).toList();

    if (selectedSort == "Nearby") {
      filtered.sort((a, b) => a["distanceKm"].compareTo(b["distanceKm"]));
    } else {
      filtered.sort((a, b) => a["minutesAgo"].compareTo(b["minutesAgo"]));
    }

    return filtered;
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    final trending = _getTrending();
    final filteredFeed = _getFilteredFeed();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Community",
            style: TextStyle(fontWeight: FontWeight.w600)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Community Feed",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text("Verify, support, and collaborate on civic issues.",
                style: TextStyle(color: Colors.grey[700])),

            const SizedBox(height: 20),

            // ---------------------
            // TRENDING SECTION
            // ---------------------
            Row(
              children: [
                Icon(Icons.trending_up, color: accentColor),
                const SizedBox(width: 6),
                const Text("Trending Issues",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 170,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: trending.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, i) =>
                    _buildTrendingCard(trending[i], i + 1),
              ),
            ),

            const SizedBox(height: 24),

            // ---------------------
            // FILTER BAR (WITH BORDER)
            // ---------------------
            _buildFilterBar(),

            const SizedBox(height: 24),

            // ---------------------
            // FULL FEED LIST
            // ---------------------
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredFeed.length,
              itemBuilder: (context, i) =>
                  _buildPostCard(filteredFeed[i], context),
            ),
          ],
        ),
      ),
    );
  }

  // TRENDING CARD UI
  Widget _buildTrendingCard(Map<String, dynamic> post, int rank) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF003B5C), Color(0xFF00695C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 3),
            color: Colors.black26,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent[400],
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text("#$rank Trending",
                  style: const TextStyle(fontSize: 11)),
            ),
          ),
          const SizedBox(height: 10),
          Text(post["title"],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(post["description"],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(post["category"],
                  style: TextStyle(color: Colors.white.withOpacity(0.9))),
              Row(
                children: [
                  const Icon(Icons.thumb_up, size: 16, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(post["upvotes"].toString(),
                      style: const TextStyle(color: Colors.white)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  // FILTER BAR
  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300), // ⭐ BORDER ADDED
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 2),
            color: Colors.black12,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.filter_alt_outlined, color: accentColor),
          const SizedBox(width: 10),
          const Text("Filters:",
              style: TextStyle(fontWeight: FontWeight.w600)),
          const Spacer(),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedSort,
              items: const [
                DropdownMenuItem(value: "Nearby", child: Text("Nearby")),
                DropdownMenuItem(value: "Recent", child: Text("Recent")),
              ],
              onChanged: (v) => setState(() => selectedSort = v!),
            ),
          ),
          const SizedBox(width: 10),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCategory,
              items: categories
                  .map((c) =>
                      DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(() => selectedCategory = v!),
            ),
          ),
        ],
      ),
    );
  }

  // FEED POST CARD (WITH BORDER ADDED)
  Widget _buildPostCard(Map<String, dynamic> post, BuildContext context) {
    final List<String> comments = post["comments"];

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300), // ⭐ BORDER ADDED
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 3),
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // USER + LOCATION
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: accentColor.withOpacity(0.15),
                  child: const Icon(Icons.person, color: Colors.black87),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post["username"],
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(
                      "${post["location"]} • ${post["time"]}",
                      style:
                          TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
          ),

          // IMAGE
          ClipRRect(
            child: Image.network(
              post["imageUrl"],
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 10),

          // CATEGORY TAG
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                post["category"],
                style: TextStyle(
                    color: accentColor, fontWeight: FontWeight.w600),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // TITLE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              post["title"],
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),

          const SizedBox(height: 4),

          // DESCRIPTION
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              post["description"],
              style: TextStyle(color: Colors.grey[800], fontSize: 14),
            ),
          ),

          const SizedBox(height: 12),

          // ACTION BAR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                // LIKE btn
                InkWell(
                  onTap: () {
                    setState(() {
                      if (post["hasUpvoted"]) {
                        post["upvotes"]--;
                        post["hasUpvoted"] = false;
                      } else {
                        post["upvotes"]++;
                        post["hasUpvoted"] = true;
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        post["hasUpvoted"]
                            ? Icons.thumb_up
                            : Icons.thumb_up_outlined,
                        color: post["hasUpvoted"]
                            ? accentColor
                            : Colors.grey[800],
                      ),
                      const SizedBox(width: 6),
                      Text(post["upvotes"].toString(),
                          style:
                              const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                // VERIFY btn
                InkWell(
                  onTap: () => setState(() {
                    post["supported"] = !post["supported"];
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: post["supported"]
                          ? Colors.green[600]
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      post["supported"]
                          ? "Verified by You"
                          : "Verify / Support",
                      style: TextStyle(
                        color:
                            post["supported"] ? Colors.white : Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                // COMMENTS btn
                InkWell(
                  onTap: () => _openCommentsSheet(post),
                  child: Row(
                    children: [
                      const Icon(Icons.chat_bubble_outline, size: 20),
                      const SizedBox(width: 6),
                      Text("Comments (${comments.length})",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),
        ],
      ),
    );
  }

  // COMMENTS BOTTOM SHEET
  void _openCommentsSheet(Map<String, dynamic> post) {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final List<String> comments = post["comments"];

            void addComment() {
              final text = controller.text.trim();
              if (text.isEmpty) return;

              setState(() => comments.add(text));
              setModalState(() {});
              controller.clear();
            }

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: const [
                          Text("Comments",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const Divider(height: 1),

                    // Comments List
                    Expanded(
                      child: comments.isEmpty
                          ? const Center(
                              child: Text("No comments yet."),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(12),
                              itemCount: comments.length,
                              itemBuilder: (_, i) => Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      radius: 15,
                                      child: Icon(Icons.person, size: 16),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF5F5F5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          comments[i],
                                          style: const TextStyle(
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),

                    // Comment input
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                hintText: "Add a comment...",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: addComment,
                            icon: Icon(Icons.send, color: accentColor),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
