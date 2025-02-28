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



  // Api for fetch all orders
  Future <List<dynamic>> fetchAllOrders() async {

    var url = Uri.parse("${baseUrl}orders");

    final res = await http.get(url);

    if(res.statusCode==200){
      return jsonDecode(res.body);
    }else{
      throw Exception('Failed to get orders');
    }
  }

}
