import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:red_dress_delevery/services/Api.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int isOrders = 0;
   List<dynamic> orders = [];

  static const baseUrl = "http://192.168.69.38:5000/api/";

  // Api for fetch all orders
  Future <List<dynamic>> fetchAllOrders() async {

    var url = Uri.parse("${baseUrl}orders");

    final res = await http.get(url);

    if(res.statusCode==200){
      setState(() {
        orders = jsonDecode(res.body);
      });
      return orders;
    }else{
      throw Exception('Failed to get orders');
    }
  }

  // Api for deliver order
  Future<void> deleteOrder(int orderId) async {

    var url = Uri.parse("${baseUrl}orders/$orderId");

    final res = await http.delete(url);

    if(res.statusCode==200){
      setState(() {
        orders.removeWhere((order) => order['id'] == orderId);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order delivered successfully')));

    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update order, Try Again'))
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchAllOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error : ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Orders'));
        }

        return SizedBox(
          height: MediaQuery.of(context).size.height/1.6,
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var order = snapshot.data![index];
          
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 270,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        blurStyle: BlurStyle.normal,
                        offset: Offset(2, 2)
                      )
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 3,
                        blurStyle: BlurStyle.normal,
                        offset: Offset(2, 2)
                      )
                    ],                          
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 192, 50, 7),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order ID : ${order['id']}", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                              Text("Order Status : Not Delivered",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                              Text("Order Placed Date : ${order['orderPlacedDate']}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                              Text("Customer Address : ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                              Text("${order['address']}",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white)),
                              Text("Customer Name : ${order['customerName']}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                              Text("Customer Contact : ${order['phone']}",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white)),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.directions,color: Colors.white,size: 20),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Direction",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    width: 10,
                                  ),

                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 24, 161, 29),
                                    ),
                                    onPressed: () {
                                      var data = {
                                        'id': order['id'],
                                        'customerName': order['customerName'],
                                        'phone': order['phone'],
                                        'address': order['address'],
                                      };

                                      // Pass the data to the delivered screen

                                      
                                      //Delete the order from the database
                                      deleteOrder(order['id']);

                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.done_outlined,color: Colors.white,size: 20),
                                        SizedBox(width: 5,),
                                        Text(
                                          "Delivered",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17
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
