import 'package:aniflix/config/styles.dart';
import 'package:aniflix/views/favourites/favourites.dart';
import 'package:aniflix/views/home/tabs/homepage.dart';
import 'package:aniflix/views/home/tabs/songspage.dart';
import 'package:aniflix/views/home/tabs/search/searchscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
    // FavouritesScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "ANIFLIX",
            style: TextStyles.appbarStyle,
          ),
          actions: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FavouritesScreen())),
              child: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Text("S",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                maxRadius: 18,
              ),
            ),
            const SizedBox(
              width: 8,
            )
          ],
        ),
        body: _pages[_currentIndex],
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
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.favorite), label: "Favoraites"),
          ],
        ));
  }
}
