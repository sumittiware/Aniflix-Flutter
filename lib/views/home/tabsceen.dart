import 'package:aniflix/config/styles.dart';
import 'package:aniflix/views/favourites/favourites.dart';
import 'package:aniflix/views/home/tabs/homepage.dart';
import 'package:aniflix/views/home/tabs/songspage.dart';
import 'package:aniflix/views/home/tabs/search/searchscreen.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;
  static const List<Widget> _pages = [
    HomePage(),
    SearchScreen(),
    SongsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
        body: Column(
          children: [
            SizedBox(height: padding.top),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Text(
                    "ANIFLIX",
                    style: TextStyles.appbarStyle,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const FavouritesScreen())),
                      icon: const Icon(
                        Icons.list_rounded,
                        size: 28,
                        color: Colors.red,
                      )),
                ],
              ),
            ),
            Expanded(child: _pages[_currentIndex]),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (val) {
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
                icon: Icon(Icons.music_note_rounded), label: "Songs"),
          ],
        ));
  }
}
