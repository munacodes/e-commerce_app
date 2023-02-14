import 'package:e_commerce/widgets/singleProduct.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget _buildCategoryProduct({required String image, required int color}) {
    return CircleAvatar(
      maxRadius: 35,
      backgroundColor: Color(color),
      child: Container(
        height: 50,
        child: Image(
          image: AssetImage('assets/images/$image'),
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: Drawer(),
        appBar: AppBar(
          title: const Text(
            'HomePage',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.grey[100],
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _key.currentState!.openDrawer();
            },
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.black,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
              color: Colors.black,
            ),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Category',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'See all',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 60,
                                  child: Row(
                                    children: [
                                      _buildCategoryProduct(
                                          image: "Dress.png",
                                          color: 0xFF33DCFD),
                                      _buildCategoryProduct(
                                          image: "Shirt.jpg",
                                          color: 0xFFF38CDD),
                                      _buildCategoryProduct(
                                          image: "Shoe.png", color: 0xFF4FF2AF),
                                      _buildCategoryProduct(
                                          image: "Pants.png",
                                          color: 0xFF74ACF7),
                                      _buildCategoryProduct(
                                          image: "Tie.png", color: 0xFFFC6C8D),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Featured',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'See all',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    SingleProduct(
                                      name: 'Man Long T-Shirt',
                                      price: 30.0,
                                      image: 'Man.png',
                                    ),
                                    SingleProduct(
                                      name: 'Watch',
                                      price: 33.0,
                                      image: 'Watch.jpg',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          height: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'New Achives',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'See all',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    SingleProduct(
                                      name: 'Male\'s Watch',
                                      price: 30.0,
                                      image: 'Watch 2.png',
                                    ),
                                    SingleProduct(
                                      name: 'Male\'s Pants',
                                      price: 33.0,
                                      image: 'Pants.png',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
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
  }
}
