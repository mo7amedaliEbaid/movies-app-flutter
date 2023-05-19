import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/constants/Global_consts.dart';
import 'package:my_movies_app_flutter/customized/myappBar.dart';
import 'package:my_movies_app_flutter/providers/search_provider.dart';
import 'package:my_movies_app_flutter/screens/search_screens/searched_celebs.dart';
import 'package:my_movies_app_flutter/screens/search_screens/searched_movies.dart';
import 'package:my_movies_app_flutter/screens/search_screens/searshed_series.dart';
import 'package:provider/provider.dart';

const List<String> list = <String>['Movie', 'TV Series', 'Celebrity'];

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  String dropdownValue = list.first;
List<String>recentSearches=[];
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          Consumer<SearchProvider>(builder: (context, data, _) {
            return Container(
              margin: EdgeInsets.all(20),
              height: size.height*.08,
              padding: EdgeInsets.fromLTRB(16, 6, 10, 0),
              // width: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.amber,width: 2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      style: bluebold,
                      controller: _controller,
                      onSubmitted: (searchedCharacter) {
                        recentSearches.add(searchedCharacter);
                        _controller.clear();
                        if(dropdownValue=="Movie"){
                          //data.getsearchedMovies(searchedCharacter);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchedMoviesScreen(
                                searchedfor: searchedCharacter,)));
                        }else if(dropdownValue=="TV Series"){
                         // data.getsearchedSeries(searchedCharacter);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchedTvScreen(

                                searchedfor: searchedCharacter,)));
                        }else{
                         // data.getsearchedCelebs(searchedCharacter);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchedCelebsScreen(
                                searchedfor: searchedCharacter,)));
                        }

                      },
                      decoration: InputDecoration(
                        hintText: 'Type here',
                        border: InputBorder.none,
                        hintStyle: bluebold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,size: 40,color: Colors.amber,),
                      elevation: 16,
                      style: deepbold,

                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),

                ],
              ),
            );
          }),
          Padding(
            padding:  EdgeInsets.only(top: size.height*.1),
            child: Text('Recent Searches', style: bluebold,),
          ),
          SizedBox(height: 0,),
          Container(
            margin: EdgeInsets.symmetric(horizontal:70,vertical: 17),
            padding: EdgeInsets.all(25),
            //width: size.width*.7,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red,width: 2),
                borderRadius: BorderRadius.circular(10),

            ),
            child: Center(
              child: recentSearches.isEmpty?Text('No Recent Searches!', style: bluebold,):
                  Column(
                    children: [
                      ...recentSearches.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(e,style:normalBoldWhite,),
                      ))
                    ],
                  )
            ),
          )
        ]),
      ),
    );
  }
}
