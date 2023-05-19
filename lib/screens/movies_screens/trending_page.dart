import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/screens/movies_screens/movieDetails_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/Global_consts.dart';
import '../../constants/api_constance.dart';
import '../../models/movie_model.dart';
import '../../providers/movies_provider.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({Key? key}) : super(key: key);

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
 late MoviesProvider moviesProvider;
  late Future<List<Movie>> _listoftrendMovies;
  Color chosenColor=Colors.amberAccent;
  Color unChosenColor=Colors.transparent;
  bool weekSelected=false;
  String _trending_period="day";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    _listoftrendMovies = moviesProvider.getallTrendMovies(_trending_period);

  }
  @override
  Widget build(BuildContext context) {
return Consumer<MoviesProvider>(builder: (context,data,_){
  Size size=MediaQuery.of(context).size;
  log("${size.height}");
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Trending Per ........",style: bigwhite,),
            Row(
              children: [
                InkWell(
                  onTap: (){
                 setState(() {
                   _trending_period="week";
                   data.getallTrendMovies(_trending_period);
                 });
                    weekSelected=true;
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: weekSelected?chosenColor:unChosenColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Week",style: bluenormalStyle),
                      )),
                ),
                SizedBox(width: size.width*.09,),
                InkWell(
                  onTap: (){
                    setState(() {
                      weekSelected=false;
                      _trending_period="day";
                      data.getallTrendMovies(_trending_period);
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: weekSelected?unChosenColor:chosenColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Day",style: bluenormalStyle),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
      data.moviestrend.length==0?Center(child: CircularProgressIndicator(),):
      Container(
        height: size.height*.65,
        child: GridView.builder(
          shrinkWrap: true,
            itemCount: data.moviestrend.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              childAspectRatio: 2/3,
            ),

            itemBuilder: (context,index){
            return Stack(
              children: [
                data.moviestrend[index].posterPath==null?
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text("No Poster Available \n for ( ${data.moviestrend[index].title} )",style: bluenormalStyle,),
                  ),
                ):
                Container(
                  height: size.height*.5,
decoration: BoxDecoration(
      image: DecorationImage(image: NetworkImage("${ApiConstant.IMAGE_ORIG_POSTER}${data.moviestrend[index].posterPath}"),fit: BoxFit.fill)
),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MovieDetailsScreen(
                                          movieId:
                                              data.moviestrend[index].id)));
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
