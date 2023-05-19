import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/Global_consts.dart';
import '../../constants/api_constance.dart';
import '../../models/movie_model.dart';
import '../../providers/movies_provider.dart';
import 'movieDetails_screen.dart';

class PopPage extends StatefulWidget {
  const PopPage({Key? key}) : super(key: key);

  @override
  State<PopPage> createState() => _PopPageState();
}

class _PopPageState extends State<PopPage> {
  late MoviesProvider moviesProvider;
  late Future<List<Movie>> _listofpopMovies;
  TextEditingController _controller = TextEditingController();
  /*Color chosenColor=Colors.amberAccent;
  Color unChosenColor=Colors.transparent;
  bool weekSelected=false;*/
  String _year="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    _listofpopMovies = moviesProvider.getallpopularMovies(_year);

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(builder: (context,data,_){
      Size size=MediaQuery.of(context).size;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB( 15.0,15,15,10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Browse Popular Movies By Year ........",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),),

                Container(
                 // margin: EdgeInsets.all(20),
                  height: size.height*.039,
                 width: size.width*.15,
                 padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                  // width: 300,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.amber,width: 2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      keyboardAppearance: Brightness.dark,
                      cursorColor: Colors.amberAccent,
                      cursorRadius: Radius.circular(2),
                      controller: _controller,
                      onSubmitted: (selectedYear) {
                        setState(() {
                          _year="&year=$selectedYear";
                          data.getallpopularMovies(_year);
                        });
                      },
                      decoration: InputDecoration(

                        hintText: 'Year',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          data.moviespopular.length==0?Center(child: CircularProgressIndicator(),):
          Container(
            height: size.height*.65,
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: data.moviespopular.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2/3,
                ),

                itemBuilder: (context,index){
                  return Stack(
                    children: [
                      Container(
                        height: size.height*.5,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage("${ApiConstant.IMAGE_ORIG_POSTER}${data.moviespopular[index].posterPath}"),fit: BoxFit.fill)
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailsScreen(movieId: data.moviespopular[index].id)));

                          },
                          child: Container(
                            height: size.height*.04,
                            width: size.width*.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.amberAccent,
                            ),
                            child: Center(child: Text("See Details",style: bluesmallStyle,)),
                          ),
                        ),),
                    ],
                  );
                }),
          ),
        ],
      );
    });


  }
}
