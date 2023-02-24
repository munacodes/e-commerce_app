import 'package:e_commerce/screens/checkOut.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final double price;
  final String name;
  final String image;
  const CartScreen(
      {Key? key, required this.price, required this.image, required this.name})
      : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int count = 1;

  final TextStyle myStyle = const TextStyle(
    fontSize: 18,
  );

  Widget _buildSingleCartProduct() {
    return Container(
      height: 150,
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 130,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/${widget.image}'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  height: 140,
                  width: 200,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: myStyle,
                        ),
                        Text(
                          'Cloths',
                          style: myStyle,
                        ),
                        Text(
                          '\$ ${widget.price.toString()}',
                          style: const TextStyle(
                            color: Color(0xFF9B96D6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 35,
                          width: 120,
                          color: const Color(0xFFF2F2F2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (count > 1) {
                                      count--;
                                    }
                                    count--;
                                  });
                                },
                                child: const Icon(Icons.remove),
                              ),
                              Text(
                                count.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    count++;
                                  });
                                },
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF746BC9),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => CheckOut(
                  price: widget.price,
                  image: widget.image,
                  name: widget.name,
                ),
              ),
            );
          },
          child: const Text(
            'Continue',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cart Page',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            _buildSingleCartProduct(),
            _buildSingleCartProduct(),
            _buildSingleCartProduct(),
            _buildSingleCartProduct(),
            _buildSingleCartProduct(),
            _buildSingleCartProduct(),
            _buildSingleCartProduct(),
            _buildSingleCartProduct(),
            _buildSingleCartProduct(),
          ],
        ),
      ),
    );
  }
}
