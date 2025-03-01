import 'package:flutter/material.dart';
import 'package:red_dress_delevery/services/Api.dart';

class Delivered extends StatefulWidget {
  const Delivered({super.key});

  @override
  State<Delivered> createState() => _DeliveredState();
}

class _DeliveredState extends State<Delivered> {
  int isOrders = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api().fetchAllDeliveredOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error : ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Delivered Orders Found'));
        }

        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.6,
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var order = snapshot.data![index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        blurStyle: BlurStyle.normal,
                        offset: Offset(2, 2),
                      ),
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
                              offset: Offset(2, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 192, 50, 7),
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
                                  fontSize: 16
                                ),
                              ),
                              Text(
                                "Customer Address : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16
                                ),
                              ),
                              Text(
                                "${order['address']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Customer Name : ${order['customerName']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16
                                ),
                              ),
                              Text(
                                "Customer Contact : ${order['phone']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
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
