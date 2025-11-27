import 'package:citywatchapp/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final Dio dio = Dio();
final String url = "http://192.168.1.70:5000";
Future<void> Registerapi({
  required String Name,
  required String Phone,
  required String Email,
  required String Password,
  required BuildContext context,
}) async {

  print("🔍 DEBUG: Sending POST request to: $url/User");
  print("🔍 DATA: $Name | $Phone | $Email");

  try {
    Response response = await dio.post(
      '$url/User',
      data: {
        "Name": Name,
        "PhoneNo": Phone,
        "Email": Email,
        "Password": Password,
        "Username": Email,
      },
    );

    print("✅ API HIT SUCCESSFULLY → Status: ${response.statusCode}");
    print("📩 RESPONSE DATA: ${response.data}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      print("❌ Server returned error: ${response.statusCode}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Failed')),
      );
    }

  } catch (e) {
    print("❌ ERROR while sending request: $e");
  }
}
