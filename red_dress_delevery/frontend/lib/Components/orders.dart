import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:red_dress_delevery/Pages/location.dart';
import 'package:red_dress_delevery/services/Api.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int isOrders = 0;
  List<dynamic> orders = [];
  late Future<List<dynamic>> futureOrders; // Store Future

  static const baseUrl = "http://192.168.82.38:5000/api/";

  @override
  void initState() {
    super.initState();
    futureOrders = fetchAllOrders(); // Fetch data once and store it
  }

  Future<List<dynamic>> fetchAllOrders() async {
    var url = Uri.parse("${baseUrl}orders");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        setState(() {
          orders = jsonDecode(res.body);
        });
        return orders;
      } else {
        throw Exception('Failed to get orders');
      }
    } catch (e) {
      throw Exception("Error fetching orders: $e");
    }
  }

  Future<void> deleteOrder(int orderId) async {
    var url = Uri.parse("${baseUrl}orders/$orderId");

    try {
      final res = await http.delete(url);
      if (res.statusCode == 200) {
        setState(() {
          orders.removeWhere((order) => order['id'] == orderId);
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Order delivered successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update order, Try Again')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: futureOrders, // Use stored Future
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              children: [
                Lottie.asset("assets/empty.json", width: 300, repeat: true),
              ],
            ),
          );
        }

        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.6,
          child: ListView.builder(
            itemCount: orders.length, // Use `orders` directly
            itemBuilder: (context, index) {
              var order = orders[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        spreadRadius: 3,
                        blurRadius: 4,
                        blurStyle: BlurStyle.normal,
                        offset: Offset(2, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 179, 50, 11),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order ID : ${order['id']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "Order Status : Not Delivered",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "Order Placed Date : ${order['orderPlacedDate']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "Customer Address : ${order['address']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "Customer Name : ${order['customerName']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "Customer Contact : ${order['phone']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () async {
                                try {
                                  await _checkLocationPermission(); // Ensure permission is granted

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => Location(
                                            latitude: double.parse(
                                              order['latitude'],
                                            ),
                                            longitude: double.parse(
                                              order['longitude'],
                                            ),
                                          ),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.directions,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Direction",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  24,
                                  161,
                                  29,
                                ),
                              ),
                              onPressed: () {
                                var data = {
                                  'id': order['id'],
                                  'customerName': order['customerName'],
                                  'phone': order['phone'],
                                  'address': order['address'],
                                };

                                // Pass the data to the delivered screen
                                Api().addDelivered(data, context);

                                // Delete the order from the database
                                deleteOrder(order['id']);
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.done_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Delivered",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
