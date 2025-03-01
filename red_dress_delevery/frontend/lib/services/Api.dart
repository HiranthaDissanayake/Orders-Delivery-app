// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:red_dress_delevery/Pages/home.dart';

class Api {
  static const baseUrl = "http://192.168.69.38:5000/api/";


  // Api for 
  Future login(Map<String, dynamic> data, BuildContext context) async {
    var url = Uri.parse("${baseUrl}login");

    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data)
      );

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login Successfull"),
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }

      if (res.statusCode == 401) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("User Not Found")));
      }

      if (res.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email and Password are required")),
        );
      }

      if (res.statusCode == 500) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Data Error")));
      }
    } catch (e) {
      print(e);
    }
  }


  // Add data to delivered table
  Future addDelivered(Map<String, dynamic> data, BuildContext context) async {
    var url = Uri.parse("${baseUrl}delivered");
  
    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data)
    );

    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Order marked as Delivered"),
          duration: Duration(seconds: 2),
        ),

      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to mark as delivered, Try Again"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  
  }








}
