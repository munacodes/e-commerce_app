import 'package:flutter/material.dart';

class CheckOut extends StatefulWidget {
  final double price;
  final String name;
  final String image;
  const CheckOut(
      {Key? key, required this.price, required this.image, required this.name})
      : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

const TextStyle myStyle = TextStyle(
  fontSize: 18,
);

class _CheckOutState extends State<CheckOut> {
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
                        const Text(
                          'Cloths',
                          style: myStyle,
                        ),
                        Text(
                          '\$ ${widget.price}',
                          style: const TextStyle(
                            color: Color(0xFF9B96D6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 35,
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Quantity"),
                              Text("1"),
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

  Widget _buildBottomDetail(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          startName,
          style: myStyle,
        ),
        Text(
          endName,
          style: myStyle,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'CheckOut Page',
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
            onPressed: () {},
            child: const Text(
              'Buy',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSingleCartProduct(),
                  _buildSingleCartProduct(),
                  _buildSingleCartProduct(),
                  _buildSingleCartProduct(),
                  Container(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildBottomDetail(
                          startName: "Your Price",
                          endName: "\$ 60.00",
                        ),
                        _buildBottomDetail(
                          startName: "Discount",
                          endName: "3%",
                        ),
                        _buildBottomDetail(
                          startName: "Shipping",
                          endName: "\$ 60.00",
                        ),
                        _buildBottomDetail(
                          startName: "Total",
                          endName: "\$ 120",
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
