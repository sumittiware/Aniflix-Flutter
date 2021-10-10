import 'package:aniflix/config.dart';
import 'package:aniflix/views/auth/authscreen.dart';
import 'package:aniflix/views/home/allanime.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CustomTextField(
              controller: _searchController,
              title: "Search",
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: const Text("Genras",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8),
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            AllAnimeScreen(genra: genres[index]))),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(12)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          genres[index],
                          style: const TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                  );
                }),
          ))
        ],
      ),
    );
  }
}
