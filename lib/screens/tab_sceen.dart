import 'package:aniflix/config/styles.dart';
import 'package:aniflix/screens/favourites_screen.dart';
import 'package:aniflix/screens/home_page.dart';
import 'package:aniflix/screens/search_screen.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;
  final pageController = PageController(initialPage: 0);
  static final List<Widget> _pages = [
    const HomePage(),
    const SearchScreen(),
    const FavouritesScreen(),
  ];
  @override
  Widget build(BuildContext context) {
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
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.red,
                        size: 28,
                      ))
                ],
              ),
            ),
            preferredSize: const Size.fromHeight(kToolbarHeight)),
        body: PageView(
          children: _pages,
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
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
