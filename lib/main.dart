import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/providers/authWithGoogle_provider.dart';
import 'package:my_movies_app_flutter/providers/authwith_TMDB_provider.dart';
import 'package:my_movies_app_flutter/providers/celebs_provider.dart';
import 'package:my_movies_app_flutter/providers/genre_provider.dart';
import 'package:my_movies_app_flutter/providers/movieDetails_provider.dart';
import 'package:my_movies_app_flutter/providers/movies_provider.dart';
import 'package:my_movies_app_flutter/providers/search_provider.dart';
import 'package:my_movies_app_flutter/providers/tmdb_userAccount_provider.dart';
import 'package:my_movies_app_flutter/providers/tv_provider.dart';
import 'package:my_movies_app_flutter/setUp.dart';
import 'package:provider/provider.dart';
main()async{
/*  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();*/
  runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => MoviesProvider()),
    ChangeNotifierProvider(create: (_) => CelebssProvider()),
    ChangeNotifierProvider(create: (_) => GenreProvider()),
    ChangeNotifierProvider(create: (_) => TvProvider()),
    ChangeNotifierProvider(create: (_) => SearchProvider()),
    ChangeNotifierProvider(create: (_) => MovieDetailsProvider()),
    ChangeNotifierProvider(create: (_) => AuthWithTMDBProvider()),
    ChangeNotifierProvider(create: (_) => UserAccountProvider()),
    ChangeNotifierProvider(create: (_) => AuthwithGoogleProvider()),
  ],
     child: MyApp()));
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       theme: ThemeData(
         backgroundColor: Colors.black,
         scaffoldBackgroundColor: Colors.black,
         brightness: Brightness.dark,
         bottomNavigationBarTheme: BottomNavigationBarThemeData(
           backgroundColor: Colors.black,
          // selectedLabelStyle: labelStyle,
           selectedItemColor: Colors.black,
             elevation: 0
         )
       ),
        debugShowCheckedModeBanner: false,
        home: SetUp(),
      );

  }
}

