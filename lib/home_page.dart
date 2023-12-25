import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_proj/cubits/auth_cubit.dart';
import 'package:final_proj/cubits/store_cubit.dart';
import 'package:final_proj/models/ad_model.dart';

import 'package:final_proj/screens/cart_screen.dart';
import 'package:final_proj/screens/category_screen.dart';
import 'package:final_proj/screens/profile_screen.dart';
import 'package:final_proj/screens/splash_screen.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static String id = 'home-page';

  @override
  Widget build(BuildContext context) {
    List<Ad> adsData = context
        .select((StoreCubit cubit) => cubit.state['ads'] as List<Ad>? ?? []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              context.read<AuthCubit>().signOut();
              // Navigate back to SplashScreen upon sign-out
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const SplashScreen(),
              ));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: _buildCarouselItems(context, adsData),
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text('Welcome to the Home Page!'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.deepPurple,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation
          switch (index) {
            case 0:
              // Do nothing, already on the home page
              break;
            case 1:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const CategoryScreen()));
              break;
            case 2:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const CartScreen()));
              break;
            case 3:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()));
              break;
          }
        },
      ),
    );
  }

  List<Widget> _buildCarouselItems(BuildContext context, List<Ad> adsData) {
    return adsData.map((ad) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .4,
          height: MediaQuery.of(context).size.height * .3,
          child: Image.network(
            ad.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      );
    }).toList();
  }
}
