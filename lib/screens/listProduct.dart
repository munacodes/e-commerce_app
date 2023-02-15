import 'package:e_commerce/widgets/widgetsExport.dart';
import 'package:flutter/material.dart';

class ListProduct extends StatelessWidget {
  final String name;
  const ListProduct({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              color: Colors.black,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.notifications_none),
              color: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 650,
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.6,
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
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
                        SingleProduct(
                          name: 'Hp Laptop',
                          price: 40.0,
                          image: 'Laptop.jpg',
                        ),
                        SingleProduct(
                          name: 'Canvas',
                          price: 25.0,
                          image: 'Shoe 1.jpg',
                        ),
                        SingleProduct(
                          name: 'Ring',
                          price: 20.0,
                          image: 'Ring.png',
                        ),
                        SingleProduct(
                          name: 'Wireless Game Pad',
                          price: 10.0,
                          image: 'Game Pad.jpg',
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
