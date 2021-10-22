import 'package:aniflix/config/styles.dart';
import 'package:aniflix/providers/searchprovider.dart';

import 'package:aniflix/views/home/tabs/search/allanime.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final searchProvider = Provider.of<SearchProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: TextFormField(
                  controller: _searchController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    labelStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  onFieldSubmitted: (_) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AllAnimeScreen(
                              query: _searchController.text,
                            )));
                  },
                ),
              )),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: const Text("Genras", style: TextStyles.primaryTitle),
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
                itemCount: searchProvider.gneres.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AllAnimeScreen(
                            genra: searchProvider.gneres[index]))),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(12)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          searchProvider.gneres[index],
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
