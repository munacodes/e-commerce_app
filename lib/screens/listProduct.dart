import 'package:e_commerce/screens/homePage.dart';
import 'package:e_commerce/widgets/widgetsExport.dart';
import 'package:flutter/material.dart';

class ListProduct extends StatelessWidget {
  final String name;
  final snapshot;
  const ListProduct({Key? key, required this.name, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const HomePage(),
              ),
            );
          },
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
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                  itemBuilder: (context, index) => SingleProduct(
                    image: snapshot.data.docs[index]["image"],
                    price: snapshot.data.docs[index]["price"],
                    name: snapshot.data.docs[index]["name"],
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
