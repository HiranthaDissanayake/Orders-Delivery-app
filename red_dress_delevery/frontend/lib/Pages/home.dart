import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();

  int isOrders = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 211, 165),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Red",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Dress",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Delivery",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Icon(
                      Icons.delivery_dining_outlined,
                      color: Colors.black,
                      size: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Stack(
            children: [
              Container(
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.deepOrange),
              ),

              Container(
                height: 600,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 211, 165),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                ),

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 40,
                        right: 40,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              blurStyle: BlurStyle.normal,
                              offset: Offset(
                                0,
                                1,
                              ), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isOrders = 0;
                                  });
                                  _pageController.animateToPage(
                                    0,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        blurStyle: BlurStyle.normal,
                                        offset: Offset(
                                          0,
                                          1,
                                        ), // changes position of shadow
                                      ),
                                    ],
                                    color:
                                        isOrders == 0
                                            ? Colors.deepOrange
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Orders",
                                      style: TextStyle(
                                        color:
                                            isOrders == 0
                                                ? Colors.white
                                                : Colors.deepOrange,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 5),

                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isOrders = 1;
                                  });
                                  _pageController.animateToPage(
                                    1,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        blurStyle: BlurStyle.normal,
                                        offset: Offset(
                                          0,
                                          1,
                                        ), // changes position of shadow
                                      ),
                                    ],
                                    color:
                                        isOrders == 1
                                            ? Colors.deepOrange
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Delevered",
                                      style: TextStyle(
                                        color:
                                            isOrders == 1
                                                ? Colors.white
                                                : Colors.deepOrange,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            isOrders = index;
                          });
                        },
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(
                              20,
                            ), // Added margin for better visibility
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Page ${index + 1}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
