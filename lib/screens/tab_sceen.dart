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
        body: Stack(
          children: [
            PageView(
              children: _pages,
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
            ),
            _buildAppBar(),
          ],
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
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded),
              label: "My List",
            ),
          ],
        ));
  }

  Widget _buildAppBar() {
    final mediaquery = MediaQuery.of(context);
    return Positioned(
      top: 0,
      child: Container(
        height: kToolbarHeight + mediaquery.padding.top,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          bottom: 8,
          left: 8,
          right: 8,
          top: mediaquery.padding.top,
        ),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
        ),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
