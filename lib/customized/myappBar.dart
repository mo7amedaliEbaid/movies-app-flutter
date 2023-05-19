import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/providers/authWithGoogle_provider.dart';
import 'package:my_movies_app_flutter/setUp.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/search_screens/search_screen.dart';
import '../screens/user_screens/TMDBUser_Screen.dart';


class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  MyAppBar({Key? key}) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size(200, 190);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.154,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(18.0, 20, 18, 0),
            color: Colors.grey.shade800,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => SetUp()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Stack(
                          children: [
                            Text(
                              "TMDB",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.white60,
                              ),
                            ),
                            Text(
                              'TMDB',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchScreen()));
                          },
                          child: Icon(Icons.search)),
                      SizedBox(
                        width: size.width * .04,
                      ),
                      Consumer<AuthwithGoogleProvider>(
                          builder: (context, data, _) {
                        return Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String? pass = prefs.getString('pass');
                                if (pass != null) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => TMDBUserScreen()));
                                } else {
                                  data.initializeFirebase(context: context);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.amber,
                                ),
                              ),
                            ));
                      })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
