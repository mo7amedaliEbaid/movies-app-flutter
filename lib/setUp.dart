import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/customized/myappBar.dart';
import 'package:my_movies_app_flutter/screens/celebs_screens/celebs_screen.dart';
import 'package:my_movies_app_flutter/screens/tv_screens/tv_screen.dart';
import 'package:my_movies_app_flutter/screens/movies_screens/setUp_movies.dart';

import 'constants/Global_consts.dart';
class SetUp extends StatefulWidget {
   SetUp({Key? key}) : super(key: key);
  @override
  State<SetUp> createState() => _SetUpState();
}

class _SetUpState extends State<SetUp> {
  static  List<Widget> _widgetOptions = <Widget>[
    SetupMovies(),
    TvPage(),
    CelebsPage(),
  ];
  int _selectedIndex = 0;

   void _onItemTapped(int index) {
     setState(() {
       _selectedIndex = index;
     });
   }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        height: 55,
        child: BottomNavigationBar(
         // selectedItemColor: Colors.black,
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Text("Movies",style: botnsvst,),
              icon:Text('Movies',style: botnsvstInactive),
              label: '',
              backgroundColor: Colors.transparent
            ),
            BottomNavigationBarItem(
              activeIcon: Text("TV",style: botnsvst,),
              icon:Text('TV',style: botnsvstInactive),
              label: '',
                backgroundColor: Colors.transparent
            ),
            BottomNavigationBarItem(
              activeIcon: Text("Celebs",style: botnsvst,),
              icon:Text('Celebs',style: botnsvstInactive),
              label: '',
                backgroundColor: Colors.transparent
            ),

          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
     body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
