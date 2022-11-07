import 'package:aniflix/models/wishlist.dart';
import 'package:aniflix/providers/wishlistprovider.dart';
import 'package:aniflix/services/analytics_services.dart';
import 'package:aniflix/services/custom_routes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:aniflix/config.dart';
import 'package:aniflix/providers/animeprovider.dart';
import 'package:aniflix/providers/episodeprovider.dart';
import 'package:aniflix/providers/searchprovider.dart';
import 'common/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setDefaultOrientation();
  setStatusBarColor();
  final docPath = await getApplicationDocumentsDirectory();
  Hive.init(docPath.path);
  Hive.registerAdapter(WishlistAdapter());
  await Hive.openBox<WishList>('wishlist');

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AnalyticsService().appOpen();
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AnimeProvider(),
        ),
        ChangeNotifierProvider.value(
          value: SearchProvider(),
        ),
        ChangeNotifierProvider.value(
          value: EpisodeProvider(),
        ),
        ChangeNotifierProvider.value(
          value: WishListProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Aniflix',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          appBarTheme: const AppBarTheme(
            color: Colors.black,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          fontFamily: 'Roboto',
          brightness: Brightness.dark,
          canvasColor: Colors.black,
          colorScheme: const ColorScheme.dark(
            secondary: Colors.red,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        navigatorObservers: [
          routeObserver,
          AnalyticsService().getAnalyticsObserver()
        ],
        initialRoute: '/',
        onGenerateRoute: CustomRoutes.generateRoute,
      ),
    );
  }
}
