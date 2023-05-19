import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/constants/Global_consts.dart';
import 'package:my_movies_app_flutter/screens/movies_screens/trending_page.dart';

import '../genres_screens/genres_screen.dart';
import 'mainSections_screen.dart';
import 'pop_page.dart';
import 'top_rated_screen.dart';

class SetupMovies extends StatefulWidget {
  const SetupMovies({Key? key}) : super(key: key);

  @override
  State<SetupMovies> createState() => _SetupMoviesState();
}

class _SetupMoviesState extends State<SetupMovies> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MainsectionsPage(),
    TrendingPage(),
    PopPage(),
    TopRatedScreen(),
    GenresPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 0),
              height: MediaQuery.of(context).size.height * .077,
              width: MediaQuery.of(context).size.width * 1.6,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  Container(
                    //   height: 70,
                    width: MediaQuery.of(context).size.width * 1.7,
                    child: BottomNavigationBar(
                      selectedLabelStyle: labelStyle,
                      // selectedItemColor: Colors.transparent,
                      items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                            activeIcon: Text(
                              "Main Sections",
                              style: normalBoldWhite,
                            ),
                            icon: Text('Main Sections', style: normalWhite),
                            label: '______________________',
                            backgroundColor: Colors.transparent),
                        BottomNavigationBarItem(
                            activeIcon: Text(
                              "Trending",
                              style: normalBoldWhite,
                            ),
                            icon: Text('Trending', style: normalWhite),
                            label: '________________',
                            backgroundColor: Colors.transparent),
                        /*   BottomNavigationBarItem(
                            activeIcon: Text("Celebrities",style: normalBoldWhite,),
                            icon:Text('Celebrities',style: normalWhite),
                            label: '______________________',
                              backgroundColor: Colors.transparent
                          ),*/
                        BottomNavigationBarItem(
                          activeIcon: Text(
                            "Popular",
                            style: normalBoldWhite,
                          ),
                          icon: Text('Popular', style: normalWhite),
                          label: '__________________',
                          backgroundColor: Colors.black,
                        ),
                        BottomNavigationBarItem(
                            activeIcon: Text(
                              "Top Rated",
                              style: normalBoldWhite,
                            ),
                            icon: Text(
                              'Top Rated',
                              style: normalWhite,
                            ),
                            label: '_______________',
                            backgroundColor: Colors.transparent),
                        BottomNavigationBarItem(
                            activeIcon: Text(
                              "Genres",
                              style: normalBoldWhite,
                            ),
                            icon: Text(
                              'Genres',
                              style: normalWhite,
                            ),
                            label: '____________',
                            backgroundColor: Colors.transparent),
                      ],
                      type: BottomNavigationBarType.shifting,
                      currentIndex: _selectedIndex,

                      onTap: _onItemTapped,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
    );
  }
}
