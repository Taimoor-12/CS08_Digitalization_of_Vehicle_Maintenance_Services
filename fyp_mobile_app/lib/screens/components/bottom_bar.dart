import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:badges/badges.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:fyp_mobile_app/screens/account/accounts_screen.dart';
import 'package:fyp_mobile_app/screens/cart/cart_screen.dart';
import 'package:fyp_mobile_app/screens/dashboard/dashboard.dart';
import 'package:fyp_mobile_app/search/search_page.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const Dashboard(),
    const AccountScreen(),
    const SearchPage(),
    // const Center(
    //   child: Text('Search Page'),
    // ),
    // const CartScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final cartLen =
    //     Provider.of<UserProvider>(context, listen: false).user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: kPrimaryColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: kTextColor,
        backgroundColor: kBackgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0 ? kPrimaryColor : kBackgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),
          // cart

          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1 ? kPrimaryColor : kBackgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person_outline_outlined,
              ),
            ),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2 ? kPrimaryColor : kBackgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.search,
              ),
            ),
            label: '',
          ),
          // BottomNavigationBarItem(
          //   icon: Container(
          //     width: bottomBarWidth,
          //     decoration: BoxDecoration(
          //       border: Border(
          //         top: BorderSide(
          //           color: _page == 2 ? kPrimaryColor : kBackgroundColor,
          //           width: bottomBarBorderWidth,
          //         ),
          //       ),
          //     ),
          //     child: const Icon(
          //       Icons.search,
          //     ),
          //   ),
          //   label: '',
          // ),
          // BottomNavigationBarItem(
          //   icon: Container(
          //     width: bottomBarWidth,
          //     decoration: BoxDecoration(
          //       border: Border(
          //         top: BorderSide(
          //           color: _page == 2 ? kPrimaryColor : kBackgroundColor,
          //           width: bottomBarBorderWidth,
          //         ),
          //       ),
          //     ),
          //     child: Badge(
          //       elevation: 0,
          //       badgeContent: Text(cartLen.toString()),
          //       badgeColor: kBackgroundColor,
          //       child: const Icon(
          //         Icons.shopping_cart_outlined,
          //       ),
          //     ),
          //   ),
          //   label: '',
          // ),
        ],
      ),
    );
  }
}
