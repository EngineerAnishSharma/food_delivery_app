import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/admin/admin_login.dart';
import 'package:food_delivery_app/pages/details.dart';
import 'package:food_delivery_app/services/database.dart';
import 'package:food_delivery_app/widgets/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = true, salad = false, burger = false;
  Stream? foodItemStream;

  onTheLoad() async {
    foodItemStream = await DatabaseMethods().getFoodItem("Pizza");
    setState(() {});
  }

  @override
  void initState() {
    onTheLoad();
    super.initState();
  }

  Widget allItems() {
    return StreamBuilder(
        stream: foodItemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (Details(
                                  detail: ds["Detail"],
                                  image: ds["Image"],
                                  name: ds["Name"],
                                  price: ds["Price"]))),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(25.0),
                                    child: Image.network(
                                      ds['Image'],
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    ds["Name"],
                                    style: AppWidget.semiboldTextFieldStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Fresh and Healthy",
                                    style: AppWidget.lightTextFieldStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "\$" + ds["Price"],
                                    style: AppWidget.semiboldTextFieldStyle(),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    );
                  })
              : const Center(child: CircularProgressIndicator());
        });
  }

  Widget allItemsVertically() {
    return StreamBuilder(
        stream: foodItemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (Details(
                                  detail: ds["Detail"],
                                  image: ds["Image"],
                                  name: ds["Name"],
                                  price: ds["Price"]))),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            width: MediaQuery.of(context).size.width - 40,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    ds['Image'],
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        ds["Name"],
                                        style:
                                            AppWidget.semiboldTextFieldStyle(),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        "Honey honeey",
                                        style: AppWidget.lightTextFieldStyle(),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        "\$" + ds["Price"],
                                        style:
                                            AppWidget.semiboldTextFieldStyle(),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : const Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello Anish,",
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => (const AdminLogin())),
                    );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(3.0),
                      // margin: const EdgeInsets.only(right: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Delicious Food",
                style: AppWidget.headLineTextFieldStyle(),
              ),
              Text(
                "Discover anf get great food",
                style: AppWidget.lightTextFieldStyle(),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                // margin: const EdgeInsets.only(right: 20.0),
                child: showItem(),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(height: 280, child: allItems()),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => (Details(
              //                     detail:
              //                         "sxkclsmdkomczlvmsfkscmzldjvmdkfmockmzczmc  ",
              //                     image: "image",
              //                     name: "name",
              //                     price: "25"))),
              //           );
              //         },
              //         child: Container(
              //           margin: const EdgeInsets.all(5.0),
              //           child: Material(
              //             elevation: 5.0,
              //             borderRadius: BorderRadius.circular(20.0),
              //             child: Container(
              //               padding: const EdgeInsets.all(14.0),
              //               child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Image.asset(
              //                       "images/salad2.png",
              //                       width: 150,
              //                       height: 150,
              //                       fit: BoxFit.cover,
              //                     ),
              //                     Text(
              //                       "Veggie Taco Hash",
              //                       style: AppWidget.semiboldTextFieldStyle(),
              //                     ),
              //                     const SizedBox(
              //                       height: 5,
              //                     ),
              //                     Text(
              //                       "Fresh and Healthy",
              //                       style: AppWidget.lightTextFieldStyle(),
              //                     ),
              //                     const SizedBox(
              //                       height: 5,
              //                     ),
              //                     Text(
              //                       "\$25",
              //                       style: AppWidget.semiboldTextFieldStyle(),
              //                     ),
              //                   ]),
              //             ),
              //           ),
              //         ),
              //       ),
              //       const SizedBox(
              //         width: 3,
              //       ),
              //       Container(
              //         margin: const EdgeInsets.all(5.0),
              //         child: Material(
              //           elevation: 5.0,
              //           borderRadius: BorderRadius.circular(20.0),
              //           child: Container(
              //             padding: const EdgeInsets.all(14.0),
              //             child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Image.asset(
              //                     "images/salad2.png",
              //                     width: 150,
              //                     height: 150,
              //                     fit: BoxFit.cover,
              //                   ),
              //                   Text(
              //                     "Mix veg Salad",
              //                     style: AppWidget.semiboldTextFieldStyle(),
              //                   ),
              //                   const SizedBox(
              //                     height: 5,
              //                   ),
              //                   Text(
              //                     "Spicy and onion",
              //                     style: AppWidget.lightTextFieldStyle(),
              //                   ),
              //                   const SizedBox(
              //                     height: 5,
              //                   ),
              //                   Text(
              //                     "\$25",
              //                     style: AppWidget.semiboldTextFieldStyle(),
              //                   ),
              //                 ]),
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              allItemsVertically(),
              // Material(
              //   elevation: 5.0,
              //   borderRadius: BorderRadius.circular(20.0),
              //   child: Container(
              //     padding: const EdgeInsets.all(5.0),
              //     width: MediaQuery.of(context).size.width - 40,
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Image.asset(
              //           "images/salad2.png",
              //           width: 120,
              //           height: 120,
              //           fit: BoxFit.cover,
              //         ),
              //         const SizedBox(
              //           width: 20.0,
              //         ),
              //         Column(
              //           children: [
              //             SizedBox(
              //               width: MediaQuery.of(context).size.width / 2,
              //               child: Text(
              //                 "Mediterranann Chickpea Salad",
              //                 style: AppWidget.semiboldTextFieldStyle(),
              //               ),
              //             ),
              //             SizedBox(
              //               width: MediaQuery.of(context).size.width / 2,
              //               child: Text(
              //                 "Honey honeey",
              //                 style: AppWidget.lightTextFieldStyle(),
              //               ),
              //             ),
              //             SizedBox(
              //               width: MediaQuery.of(context).size.width / 2,
              //               child: Text(
              //                 "\$25",
              //                 style: AppWidget.semiboldTextFieldStyle(),
              //               ),
              //             ),
              //           ],
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Material(
              //   elevation: 5.0,
              //   borderRadius: BorderRadius.circular(20.0),
              //   child: Container(
              //     padding: const EdgeInsets.all(5.0),
              //     width: MediaQuery.of(context).size.width - 40,
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Image.asset(
              //           "images/salad2.png",
              //           width: 120,
              //           height: 120,
              //           fit: BoxFit.cover,
              //         ),
              //         const SizedBox(
              //           width: 20.0,
              //         ),
              //         Column(
              //           children: [
              //             SizedBox(
              //               width: MediaQuery.of(context).size.width / 2,
              //               child: Text(
              //                 "Mediterranann Chickpea Salad",
              //                 style: AppWidget.semiboldTextFieldStyle(),
              //               ),
              //             ),
              //             SizedBox(
              //               width: MediaQuery.of(context).size.width / 2,
              //               child: Text(
              //                 "Honey honeey",
              //                 style: AppWidget.lightTextFieldStyle(),
              //               ),
              //             ),
              //             SizedBox(
              //               width: MediaQuery.of(context).size.width / 2,
              //               child: Text(
              //                 "\$25",
              //                 style: AppWidget.semiboldTextFieldStyle(),
              //               ),
              //             ),
              //           ],
              //         )
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
            foodItemStream = await DatabaseMethods().getFoodItem("Ice-cream");
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: icecream ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(
                'images/ice-cream.png',
                height: 40.0,
                width: 40.0,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = true;
            salad = false;
            burger = false;
            foodItemStream = await DatabaseMethods().getFoodItem("Pizza");
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: pizza ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'images/pizza.png',
                height: 40.0,
                width: 40.0,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = false;
            salad = true;
            burger = false;
            foodItemStream = await DatabaseMethods().getFoodItem("Salad");
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: salad ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(
                'images/salad.png',
                height: 40.0,
                width: 40.0,
                fit: BoxFit.cover,
                color: salad ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = false;
            salad = false;
            burger = true;
            foodItemStream = await DatabaseMethods().getFoodItem("Burger");
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: burger ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(
                'images/burger.png',
                height: 40.0,
                width: 40.0,
                fit: BoxFit.cover,
                color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
