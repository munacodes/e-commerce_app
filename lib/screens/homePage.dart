import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_commerce/screens/detailScreen.dart';
import 'package:e_commerce/screens/listProduct.dart';
import 'package:e_commerce/widgets/singleProduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              _buildCategoryProduct(image: "Dress.png", color: 0xFF33DCFD),
              _buildCategoryProduct(image: "Shirt.png", color: 0xFFF38CDD),
              _buildCategoryProduct(image: "Shoe.png", color: 0xFF4FF2AF),
              _buildCategoryProduct(image: "Pant.png", color: 0xFF74ACF7),
              _buildCategoryProduct(image: "Tie.png", color: 0xFFFC6C8D),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeature() {
    return Column(
      children: [
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
                    builder: (ctx) => const ListProduct(name: 'Featured'),
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
                    builder: (context) => const DetailScreen(
                      name: 'Man Long T-Shirt',
                      price: 30.0,
                      image: 'Man.png',
                    ),
                  ),
                );
              },
              child: const SingleProduct(
                name: 'Man Long T-Shirt',
                price: 30.0,
                image: 'Man.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const DetailScreen(
                      name: 'Watch',
                      price: 33.0,
                      image: 'Watch.jpg',
                    ),
                  ),
                );
              },
              child: const SingleProduct(
                name: 'Watch',
                price: 33.0,
                image: 'Watch.jpg',
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
                          builder: (ctx) =>
                              const ListProduct(name: 'New Archives'),
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
                            builder: (context) => const DetailScreen(
                              name: 'Male\'s Watch',
                              price: 40.0,
                              image: 'Watch 2.png',
                            ),
                          ),
                        );
                      },
                      child: const SingleProduct(
                        name: 'Male\'s Watch',
                        price: 40.0,
                        image: 'Watch 2.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const DetailScreen(
                              name: 'Male\'s Pants',
                              price: 10.0,
                              image: 'Pant 2.png',
                            ),
                          ),
                        );
                      },
                      child: const SingleProduct(
                        name: 'Male\'s Pants',
                        price: 10.0,
                        image: 'Pant 2.png',
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
    return SafeArea(
      child: Scaffold(
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
        body: Container(
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
      ),
    );
  }
}
