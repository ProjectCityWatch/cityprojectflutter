import 'package:citywatchapp/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final Dio dio = Dio();
final String url = "http://192.168.177.86:5000";

Future<void> Registerapi({
  required String Name,
  required String Phone,
  required String Email,
  required String Password,
  required BuildContext context,
}) async {
  try {
    Response response = await dio.post(
      '$url/User',
      data: {
        "Name": Name,
        "PhoneNo": Phone,
        "Email": Email,
        "Password": Password,
        "Username": Email, // you use Email as username
      },
    );

    // --------------------------
    // SUCCESS
    // --------------------------
    if (response.statusCode == 201 &&
        response.data["status"] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Successful")),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );

      return;
    }

    // --------------------------
    // ERROR HANDLING (400 BAD REQUEST)
    // --------------------------
    if (response.statusCode == 400) {
      String message = "Registration failed";

      final errors = response.data["errors"];

      if (errors != null) {
        if (errors["Email"] != null) {
          message = errors["Email"][0]; // "Email already registered"
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

      return;
    }

    // --------------------------
    // ANY OTHER ERROR
    // --------------------------
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Something went wrong")),
    );

  } catch (e) {
    print("❌ Error: $e");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Server error. Try again later")),
    );
  }
}
