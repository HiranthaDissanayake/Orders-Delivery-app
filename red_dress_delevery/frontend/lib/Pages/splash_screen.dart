import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:red_dress_delevery/Pages/Login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo1.png", width: 200,fit: BoxFit.cover,),
          Center(
            child: Lottie.asset("assets/delevery.json",
            width: 300,
             repeat: true),
          ),

          Text("Deliver with Honesty, Serve with Trust!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),

          Text("Integrity in every order, satisfaction in every delivery.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(top: 20),
                child: Center(
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}