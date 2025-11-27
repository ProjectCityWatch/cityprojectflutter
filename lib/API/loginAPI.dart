import 'package:citywatchapp/API/registerAPi.dart';
import 'package:citywatchapp/home.dart';   
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final Dio dio = Dio();

Future<void> Loginapi({
  required String Username,
  required String Password,
  required BuildContext context,
}) async {
  try {
    Response response = await dio.post(
      '$url/UserLogin',
      data: {
        "Username": Username,
        "Password": Password,
      },
    );

    if (response.statusCode == 200) {
      // Login success — navigate
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid Username or Password')),
      );
    }
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login Failed')),
    );
  }
}
