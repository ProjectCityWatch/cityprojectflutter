import 'dart:io';
import 'package:citywatchapp/API/loginAPI.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';



Future<void> sendComplaint({

  required String category,
  required String description,
  required String priority,
  required double latitude,
  required double longitude,
   required  File? image,
  required bool isAnonymous,
  required BuildContext context,
}) async {
  try {
    FormData data = FormData.fromMap({
     
      "Category": category,
      "Description": description,
      "Priority": priority,
      "Latitude": latitude,
      "Longitude":longitude,
      "is_anonymous": isAnonymous,
      if (image != null)
        "Image": await MultipartFile.fromFile(image.path),
    });

    final response = await dio.post(
      "$url/send-complaint/$loginid/",
      data: data,
      options: Options(validateStatus: (_) => true),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Complaint submitted successfully")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Submission failed")),
    );

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Network error")),
    );
  }
}
