import 'package:citywatchapp/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final Dio dio = Dio();
final String url =  "http://192.168.74.86:5000";

Future<void> Loginapi({
  required String Username,
  required String Password,
  required BuildContext context,
}) async {
  try {
    final Response response = await dio.post(
      '$url/GetMyComplaintStatus',
      data: {
        "Username": Username,
        "Password": Password,
      },
      options: Options(
        validateStatus: (status) => true,  // 👈 VERY IMPORTANT
      ),
    );

    print("STATUS: ${response.statusCode}");
    print("DATA: ${response.data}");

    // -------------------------
    // SUCCESS (200)
    // -------------------------
    if (response.statusCode == 200 &&
        response.data["status"] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful")),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
      return;
    }

    // -------------------------
    // INVALID LOGIN (401)
    // -------------------------
    if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.data["message"] ?? "Invalid username or password"),
        ),
      );
      return;
    }

    // -------------------------
    // OTHER ERRORS
    // -------------------------
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Login failed. Please try again.")),
    );

  } catch (e) {
    print("❌ ERROR: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Network error.")),
    );
  }
}
