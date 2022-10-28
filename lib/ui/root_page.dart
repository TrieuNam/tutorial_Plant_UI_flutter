import 'dart:core';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/ui/screens/cart_page.dart';
import 'package:plant_app/ui/screens/favorite_page.dart';
import 'package:plant_app/ui/screens/home_page.dart';
import 'package:plant_app/ui/screens/profile_page.dart';
import 'package:plant_app/ui/screens/scan_page.dart';

import '../models/plants.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _bottomNaviIndex = 0;

  List<Plant> favorites = [];
  List<Plant> myCart = [];

  int _bottomNavIndex = 0;

  List<Widget> _widgeOptions() {
    return [
      const HomePage(),
      FavoritePage(
        favoritePlants: favorites,
      ),
      CartPage(addCartPlants: myCart),
      const ProfilePage(),
    ];
  }

  //List of the page icons
  List<IconData> iconList = [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];

  //List of the pages titles
  List<String> titleList = [
    'Home',
    'Favorite',
    'Cart',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleList[_bottomNaviIndex],
              style: TextStyle(
                color: Constants.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            Icon(
              Icons.notifications,
              color: Constants.blackColor,
              size: 30.0,
            )
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNaviIndex,
        children: _widgeOptions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                child: const ScanPage(), type: PageTransitionType.bottomToTop),
          );
        },
        child: Image.asset(
          'assets/images/code-scan-two.png',
          height: 30.0,
        ),
        backgroundColor: Constants.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        splashColor: Constants.primaryColor,
        activeColor: Constants.primaryColor,
        inactiveColor: Colors.black.withOpacity(.5),
        icons: iconList,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        activeIndex: _bottomNaviIndex,
        onTap: (index) {
          setState(() {
            _bottomNaviIndex = index;
            final List<Plant> favoritePlants = Plant.getFavoritedPlants();
            final List<Plant> addToCartPlants = Plant.addedToCartPlants();
            favorites = favoritePlants;
            myCart = addToCartPlants.toSet().toList();
          });
        },
      ),
    );
  }
}