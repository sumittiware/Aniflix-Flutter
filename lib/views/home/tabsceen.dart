import 'package:aniflix/views/favourites/favourites.dart';
import 'package:aniflix/views/home/homepage.dart';
import 'package:aniflix/views/search/searchscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;

  List<Widget> _pages = [HomePage(), SearchScreen(), FavouritesScreen()];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "ANIFLIX",
            style: TextStyle(
                color: Colors.red, fontSize: 27, fontWeight: FontWeight.bold),
          ),
          actions: const [
            CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(
                "S",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              maxRadius: 18,
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
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), title: Text("explore")),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), title: Text("favoraites")),
          ],
        ));
  }
}
