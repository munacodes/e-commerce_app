import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/screens/detailScreen.dart';
import 'package:e_commerce/screens/listProduct.dart';
import 'package:e_commerce/widgets/singleProduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/models/modelsExport.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Product? menData;
  Product? womenData;
  Product? bulbData;
  Product? smartPhoneData;
  var featureSnapshot;
  var newArchivesSnapshot;
  var shirt;
  var dress;
  var shoe;
  var tie;
  var pant;

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

  bool homeColor = true;

  bool cartColor = false;

  bool aboutColor = false;

  bool contactUsColor = false;

  Widget _buildMyDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(
              'SabirBugti',
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              'sabirBugti@gmail.com',
              style: TextStyle(color: Colors.black),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFF8F8F8),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/Profile Pic.png'),
              /*
                  If you want the image to have its original radius remove 
                  backgroundimage and use this...
                  radius: 40,
                  child: Image.asset('assets/images/Profile Pic.png'),
                  */
            ),
          ),
          ListTile(
            selected: homeColor,
            onTap: () {
              setState(() {
                homeColor = true;
                contactUsColor = false;
                cartColor = false;
                aboutColor = false;
              });
            },
            leading: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          ListTile(
            selected: cartColor,
            onTap: () {
              setState(() {
                cartColor = true;
                contactUsColor = false;
                homeColor = false;
                aboutColor = false;
              });
            },
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
          ),
          ListTile(
            selected: aboutColor,
            onTap: () {
              setState(() {
                aboutColor = true;
                contactUsColor = false;
                cartColor = false;
                homeColor = false;
              });
            },
            leading: const Icon(Icons.info),
            title: const Text('About'),
          ),
          ListTile(
            selected: contactUsColor,
            onTap: () {
              setState(() {
                contactUsColor = true;
                homeColor = false;
                cartColor = false;
                aboutColor = false;
              });
            },
            leading: const Icon(Icons.phone),
            title: const Text('Contact Us'),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSlider() {
    return Container(
      height: 200,
      child: Carousel(
        // dotColor: Colors.white,
        autoplay: true,
        // dotIncreaseSize: 10,
        //  dotIncreasedColor: Colors.blue,
        //  dotSize: 20,
        showIndicator: false,
        images: const [
          AssetImage('assets/images/Man Watch 2.jpg'),
          AssetImage('assets/images/Game Pad.jpg'),
          AssetImage('assets/images/Shoe 6.jpg'),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    return Column(
      children: [
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Category',
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ListProduct(
                        name: 'Dress',
                        snapshot: dress,
                      ),
                    ),
                  );
                },
                child: _buildCategoryProduct(
                    image: "Dress.png", color: 0xFF33DCFD),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ListProduct(
                        name: 'Shirt',
                        snapshot: shirt,
                      ),
                    ),
                  );
                },
                child: _buildCategoryProduct(
                    image: "Shirt.png", color: 0xFFF38CDD),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ListProduct(
                        name: 'Shoe',
                        snapshot: shoe,
                      ),
                    ),
                  );
                },
                child:
                    _buildCategoryProduct(image: "Shoe.png", color: 0xFF4FF2AF),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ListProduct(
                        name: 'Pant',
                        snapshot: pant,
                      ),
                    ),
                  );
                },
                child:
                    _buildCategoryProduct(image: "Pant.png", color: 0xFF74ACF7),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ListProduct(
                        name: 'Tie',
                        snapshot: tie,
                      ),
                    ),
                  );
                },
                child:
                    _buildCategoryProduct(image: "Tie.png", color: 0xFFFC6C8D),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeature() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Featured',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => ListProduct(
                      name: 'Featured',
                      snapshot: featureSnapshot,
                    ),
                  ),
                );
              },
              child: const Text(
                'View More',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      name: menData!.name,
                      price: menData!.price,
                      image: menData!.image,
                    ),
                  ),
                );
              },
              child: SingleProduct(
                name: menData!.name,
                price: menData!.price,
                image: menData!.image,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      name: womenData!.name,
                      price: womenData!.price,
                      image: womenData!.image,
                    ),
                  ),
                );
              },
              child: SingleProduct(
                name: womenData!.name,
                price: womenData!.price,
                image: womenData!.image,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNewAchives() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'New Achives',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => ListProduct(
                            name: 'New Archives',
                            snapshot: newArchivesSnapshot,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'View More',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
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
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              name: bulbData!.name,
                              price: bulbData!.price,
                              image: bulbData!.image,
                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                        name: bulbData!.name,
                        price: bulbData!.price,
                        image: bulbData!.image,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              name: smartPhoneData!.name,
                              price: smartPhoneData!.price,
                              image: smartPhoneData!.image,
                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                        name: smartPhoneData!.name,
                        price: smartPhoneData!.price,
                        image: smartPhoneData!.image,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: _buildMyDrawer(),
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
      body: SafeArea(
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection("products")
                .doc("86qW7GLuZTzoDa7HdRQD")
                .collection("featureproduct")
                .get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              featureSnapshot = snapshot;
              menData = Product(
                image: snapshot.data!.docs[0]["image"],
                name: snapshot.data!.docs[0]["name"],
                price: snapshot.data!.docs[0]["price"],
              );

              womenData = Product(
                image: snapshot.data!.docs[1]["image"],
                name: snapshot.data!.docs[1]["name"],
                price: snapshot.data!.docs[1]["price"],
              );
              return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('category')
                      .doc('gdmsJAqm1gihcpfrn2c4')
                      .collection('shirt')
                      .get(),
                  builder: (context, shirtSnapshot) {
                    if (shirtSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    shirt = shirtSnapshot;

                    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance
                            .collection("products")
                            .doc("86qW7GLuZTzoDa7HdRQD")
                            .collection("newachives")
                            .get(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          newArchivesSnapshot = snapshot;
                          bulbData = Product(
                            image: snapshot.data!.docs[0]["image"],
                            name: snapshot.data!.docs[0]["name"],
                            price: snapshot.data!.docs[0]["price"],
                          );
                          smartPhoneData = Product(
                            image: snapshot.data!.docs[2]["image"],
                            name: snapshot.data!.docs[2]["name"],
                            price: snapshot.data!.docs[2]["price"],
                          );
                          return Container(
                            height: double.infinity,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListView(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildImageSlider(),
                                      _buildCategory(),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      _buildFeature(),
                                      _buildNewAchives(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  });
            }),
      ),
    );
  }
}
