import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int isOrders = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order ID : 17"),
            Text("Order Status : Not Delivered"),
            Text("Order Placed Date : 2024.02.27"),
            Text("Customer Address : "),
            Text("No.121 , Matale , Sri Lanka"),
            Text("Customer Name : Kasun Bandara"),
            Text("Customer Contact : 0771234567"),
            SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: (){
                  
                },
                child: Text("Delivered", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
              ),
            )
          ],
        ),
      ),
    );
  }
}
