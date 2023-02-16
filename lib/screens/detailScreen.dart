import 'package:e_commerce/screens/homePage.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  const DetailScreen(
      {Key? key, required this.image, required this.name, required this.price})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int count = 1;

  Widget _buildSizeProduct({required String name}) {
    return Container(
      height: 60,
      width: 60,
      color: const Color(0xFFF2F2F2),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Widget _buildColorProduct({required Color color}) {
    return Container(
      height: 60,
      width: 60,
      color: color,
    );
  }

  final TextStyle myStyle = const TextStyle(
    fontSize: 18,
  );
  Widget _buildImage() {
    return Center(
      child: Container(
        width: 350,
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(13),
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/${widget.image}'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameToDescriptionPart() {
    return Container(
      height: 100,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: myStyle,
              ),
              Text(
                '\$ ${widget.price}',
                style: const TextStyle(
                  color: Color(0xFF9B96D6),
                  fontSize: 18,
                ),
              ),
              Text(
                'Description',
                style: myStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      height: 170,
      child: Wrap(
        children: const [
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizePart() {
    return Column(
      children: [
        Text(
          'Size',
          style: myStyle,
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: 265,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSizeProduct(name: 'S'),
              _buildSizeProduct(name: 'M'),
              _buildSizeProduct(name: 'L'),
              _buildSizeProduct(name: 'XXL'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorPart() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'Color',
          style: myStyle,
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: 265,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildColorProduct(color: Colors.blue[200]!),
              _buildColorProduct(color: Colors.green[200]!),
              _buildColorProduct(color: Colors.yellow[200]!),
              _buildColorProduct(color: Colors.cyan[300]!),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'Quantity',
          style: myStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          width: 130,
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(20),
          ),
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
                style: myStyle,
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
    );
  }

  Widget _buildButtonPart() {
    return Column(
      children: [
        Container(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.pink,
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Text(
              'Check Out',
              style: myStyle,
            ),
          ),
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
            'Detail Page',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              color: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          child: ListView(
            children: [
              _buildImage(),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNameToDescriptionPart(),
                    _buildDescription(),
                    _buildSizePart(),
                    _buildColorPart(),
                    _buildQuantityPart(),
                    const SizedBox(
                      height: 15,
                    ),
                    _buildButtonPart(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
