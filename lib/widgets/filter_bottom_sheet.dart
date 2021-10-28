import 'package:aniflix/config/styles.dart';
import 'package:aniflix/providers/searchprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    return BottomSheet(
      backgroundColor: Colors.grey.shade900,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Filters",
                  style: TextStyles.primaryTitle,
                ),
              ),
              Text(
                "Format",
                style: TextStyles.secondaryTitle2,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Wrap(
                  children: List.generate(
                      searchProvider.format.length,
                      (index) => GestureDetector(
                            onTap: () => searchProvider.setFormatFilter(index),
                            child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  searchProvider.format[index],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: (searchProvider.selectedFormat
                                              .contains(index)
                                          ? Colors.red
                                          : Colors.white)),
                                )),
                          )),
                ),
              ),
              Text(
                "Season Period",
                style: TextStyles.secondaryTitle2,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Wrap(
                  children: List.generate(
                      searchProvider.period.length,
                      (index) => GestureDetector(
                            onTap: () => searchProvider.setPeriodFilter(index),
                            child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  searchProvider.period[index],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: searchProvider.selectedPeriod
                                              .contains(index)
                                          ? Colors.red
                                          : Colors.white),
                                )),
                          )),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Apply",
                    style: TextStyles.secondaryTitle2,
                  ),
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(12),
                      backgroundColor: Colors.red,
                      primary: Colors.white),
                ),
              )
            ],
          ),
        );
      },
      onClosing: () {},
    );
  }
}

showFilterBottomSheet(BuildContext context) {
  showBottomSheet(
      context: context,
      builder: (context) {
        final searchProvider = Provider.of<SearchProvider>(context);
        return BottomSheet(
            backgroundColor: Colors.grey.shade900,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Text(
                            "Filters",
                            style: TextStyles.primaryTitle,
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.close))
                        ],
                      ),
                    ),
                    Text(
                      "Format",
                      style: TextStyles.secondaryTitle2,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Wrap(
                        children: List.generate(
                            searchProvider.format.length,
                            (index) => GestureDetector(
                                  onTap: () =>
                                      searchProvider.setFormatFilter(index),
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        searchProvider.format[index],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: (searchProvider
                                                    .selectedFormat
                                                    .contains(index)
                                                ? Colors.red
                                                : Colors.white)),
                                      )),
                                )),
                      ),
                    ),
                    Text(
                      "Season Period",
                      style: TextStyles.secondaryTitle2,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Wrap(
                        children: List.generate(
                            searchProvider.period.length,
                            (index) => GestureDetector(
                                  onTap: () =>
                                      searchProvider.setPeriodFilter(index),
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        searchProvider.period[index],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: searchProvider.selectedPeriod
                                                    .contains(index)
                                                ? Colors.red
                                                : Colors.white),
                                      )),
                                )),
                      ),
                    ),
                  ],
                ),
              );
            },
            enableDrag: true,
            onClosing: () {});
      });
}
