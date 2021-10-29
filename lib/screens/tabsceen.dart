import 'package:aniflix/config/styles.dart';
import 'package:aniflix/screens/wishlist.dart';
import 'package:aniflix/screens/homepage.dart';
import 'package:aniflix/screens/searchscreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;
  final pageController = PageController(initialPage: 0);
  static List<Widget> _pages = [
    HomePage(),
    SearchScreen(),
    FavouritesScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
        appBar: PreferredSize(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const Text(
                    "ANIFLIX",
                    style: TextStyles.appbarStyle,
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.red,
                        size: 28,
                      ))
                ],
              ),
            ),
            preferredSize: Size.fromHeight(kToolbarHeight)),
        body: PageView(
          children: _pages,
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (val) {
            pageController.jumpToPage(val);
            setState(() {
              _currentIndex = val;
            });
          },
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), label: "Explore"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_rounded), label: "My List"),
          ],
        ));
  }
}
