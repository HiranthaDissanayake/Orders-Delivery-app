import 'package:flutter/material.dart';
import 'package:red_dress_delevery/Pages/home.dart';
import 'package:red_dress_delevery/services/Api.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  blurStyle: BlurStyle.normal,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Text("LOGIN", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                SizedBox(height: 40,),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }

                            if (!value.contains("@gmail.com")){
                              return 'Please enter a valid email';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email, color: Colors.deepOrange,),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return 'Please enter your password';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock, color: Colors.deepOrange,),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: GestureDetector(
                          onTap: (){
                            if (_formkey.currentState!.validate()){

                              var data = {
                                "email": _emailController.text,
                                "password": _passwordController.text
                              };

                              Api().login(data, context);
                            }
                          },
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                offset: Offset(0, 2),
                                blurRadius: 2,
                                
                              )],
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                            )
                          ),
                        ),
                      )    
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      )

    );
  }
}