import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class SubmitComplaintPage extends StatefulWidget {
  const SubmitComplaintPage({super.key});

  @override
  State<SubmitComplaintPage> createState() => _SubmitComplaintPageState();
}

class _SubmitComplaintPageState extends State<SubmitComplaintPage> {
  final TextEditingController _descriptionController = TextEditingController();

  String? selectedCategory;
  String? selectedPriority;

  File? selectedImage;

  double? latitude;
  double? longitude;
  String? address;

  bool anonymous = false;

  // ---------------------- IMAGE PICKING ----------------------
  Future pickImage() async {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt, size: 35),
                    onPressed: () async {
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.camera);
                      if (pickedFile != null) {
                        setState(() => selectedImage = File(pickedFile.path));
                      }
                      Navigator.pop(context);
                    },
                  ),
                  const Text("Camera")
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo, size: 35),
                    onPressed: () async {
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() => selectedImage = File(pickedFile.path));
                      }
                      Navigator.pop(context);
                    },
                  ),
                  const Text("Gallery")
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------------- LOCATION PERMISSION ----------------------
  Future<bool> _checkLocationPermission() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enable location service.")),
      );
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission denied.")),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enable location permissions in settings.")),
      );
      return false;
    }

    return true;
  }

  // ---------------------- PICK LOCATION ----------------------
  Future pickLocation() async {
    bool allowed = await _checkLocationPermission();
    if (!allowed) return;

    Position pos =
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    latitude = pos.latitude;
    longitude = pos.longitude;

    List<Placemark> marks = await placemarkFromCoordinates(latitude!, longitude!);
    Placemark p = marks.first;

    setState(() {
      address = "${p.street}, ${p.locality}, ${p.administrativeArea}";
    });
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration commonBox = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.grey.shade300),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Submit Complaint"),
        backgroundColor: const Color(0xFF009DCC),
      ),
      backgroundColor: Colors.grey[100],

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------------- DESCRIPTION ----------------------
            const Text("Description",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: commonBox,
              child: TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Explain the issue clearly..."),
              ),
            ),

            const SizedBox(height: 25),

            // ---------------------- CATEGORY ----------------------
            const Text("Category",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: commonBox,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory,
                  hint: const Text("Select category"),
                  items: const [
                    DropdownMenuItem(value: "Road", child: Text("Road Damage")),
                    DropdownMenuItem(value: "Water", child: Text("Water Leakage")),
                    DropdownMenuItem(value: "Waste", child: Text("Waste Dumping")),
                    DropdownMenuItem(
                        value: "Lighting", child: Text("Street Light Issue")),
                  ],
                  onChanged: (v) => setState(() => selectedCategory = v),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ---------------------- PRIORITY ----------------------
            const Text("Priority",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: commonBox,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedPriority,
                  hint: const Text("Select priority"),
                  items: const [
                    DropdownMenuItem(value: "High", child: Text("High")),
                    DropdownMenuItem(value: "Medium", child: Text("Medium")),
                    DropdownMenuItem(value: "Low", child: Text("Low")),
                  ],
                  onChanged: (v) => setState(() => selectedPriority = v),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ---------------------- IMAGE ----------------------
            const Text("Attach Image",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 150,
                decoration: commonBox,
                child: selectedImage == null
                    ? const Center(
                        child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.camera_alt_outlined, size: 40),
                          SizedBox(height: 8),
                          Text("Tap to upload image"),
                        ],
                      ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.file(selectedImage!,
                            width: double.infinity, fit: BoxFit.cover),
                      ),
              ),
            ),

            const SizedBox(height: 25),

            // ---------------------- LOCATION ----------------------
            const Text("Location",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            // ⭐ FIXED BUTTON PADDING ⭐
            ElevatedButton.icon(
              onPressed: pickLocation,
              icon: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(Icons.location_on_outlined, size: 20),
              ),
              label: const Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Text("Pick Location",
                    style: TextStyle(fontSize: 16)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009DCC),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.zero,
                elevation: 1,
              ),
            ),

            if (address != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: commonBox,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("📍 $address",
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 8),
                    Text("Latitude: $latitude",
                        style: const TextStyle(color: Colors.grey)),
                    Text("Longitude: $longitude",
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 25),

            // ---------------------- ANONYMOUS ----------------------
            Container(
              padding: const EdgeInsets.all(14),
              decoration: commonBox,
              child: Row(
                children: [
                  const Icon(Icons.person_off_outlined, size: 32),
                  const SizedBox(width: 12),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Submit Anonymously",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        SizedBox(height: 4),
                        Text("Your identity will be hidden.",
                            style: TextStyle(fontSize: 13, color: Colors.grey)),
                      ],
                    ),
                  ),

                  Switch(
                    value: anonymous,
                    onChanged: (value) =>
                        setState(() => anonymous = value),
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ---------------------- SUBMIT + CANCEL ----------------------
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF009DCC),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text("Submit",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF009DCC)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text("Cancel",
                        style: TextStyle(fontSize: 16, color: Color(0xFF009DCC))),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
