import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/constants/api_constance.dart';
import 'package:my_movies_app_flutter/models/movie_model.dart';
import 'package:my_movies_app_flutter/providers/authwith_TMDB_provider.dart';
import 'package:my_movies_app_flutter/providers/movies_provider.dart';
import 'package:my_movies_app_flutter/screens/movies_screens/discover_screen.dart';
import 'package:my_movies_app_flutter/screens/movies_screens/playing_now_screen.dart';
import 'package:provider/provider.dart';
import '../../constants/Global_consts.dart';
import 'coming_soon.dart';
import 'movieDetails_screen.dart';
class MainsectionsPage extends StatefulWidget {
  const MainsectionsPage({Key? key}) : super(key: key);

  @override
  State<MainsectionsPage> createState() => _MainsectionsPageState();
}

class _MainsectionsPageState extends State<MainsectionsPage> {
 late MoviesProvider moviesProvider;
 late AuthWithTMDBProvider authWithTMDBProvider;
 late Future<List<Movie>> _listofplMovies;
 late Future<List<Movie>> _listofupcomMovies;
 late Future<List<Movie>> _listofdiscovered;
 int _currentPage = 0;
 late Timer _timer;
 PageController _toppageController = PageController(
   initialPage: 0,
 );
 /*PageController _botpageController = PageController(
   initialPage: 10,
 );*/


 @override
 void initState() {
   // TODO: implement initState
   super.initState();
   moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
   authWithTMDBProvider = Provider.of<AuthWithTMDBProvider>(context, listen: false);
   authWithTMDBProvider.getToken();
   _listofplMovies = moviesProvider.getallplayingMovies();
   _listofupcomMovies = moviesProvider.getallupcomMovies();
   _listofdiscovered = moviesProvider.discovermovies('','');
   _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
     if (_currentPage < 20) {
       _currentPage++;
     } else {
       _currentPage = 0;
     }

     _toppageController.animateToPage(
       _currentPage,
       duration: Duration(milliseconds: 350),
       curve: Curves.easeIn,
     );
   });
 }
 @override
 void dispose() {
   super.dispose();
   _timer.cancel();
 }
  @override
  Widget build(BuildContext context) {
   Size size=MediaQuery.of(context).size;
    return  Consumer<MoviesProvider>(builder: (context,data,_){
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("In Theaters",style: bigwhite,),
                 InkWell(
                   onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlayingNowScreen()));
                   },
                   child: Text("See All",style: bluenormalStyle),
                 )
              ],
            ),
          ),
          Container(
            height: size.height*.55,
            width: size.width*.9,
            child: PageView.builder(
              controller: _toppageController,
                scrollDirection: Axis.horizontal,
                itemCount: data.moviesPlaying.length,
                itemBuilder: (context,index){
              return Stack(
                children: [
                  Container(
                    height: size.height*.55,
                    width: size.width*.9,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage("${ApiConstant.IMAGE_ORIG_POSTER}${data.moviesPlaying[index].posterPath}"),fit: BoxFit.fill)
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailsScreen(movieId: data.moviesPlaying[index].id)));
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
          Padding(
            padding: const EdgeInsets.fromLTRB( 25.0, 30,25,15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discover",style: bigwhite,),
                InkWell(
                  onTap:(){ Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DiscoverScreen()));},
                  child: Text("See All",style: bluenormalStyle),
                )
              ],
            ),
          ),
          Container(
            height: size.height*.35,
            width: size.width*.9,
            margin: EdgeInsets.only(bottom: size.height*0),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: data.discoverlist.length,
                itemBuilder: (context,index){
                  return Stack(
                    children: [
                      Container(
                        height: size.height*.35,
                        width: size.width*.5,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage("${ApiConstant.IMAGE_ORIG_POSTER}${data.discoverlist[index].posterPath}"),fit: BoxFit.fill)
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailsScreen(movieId: data.discoverlist[index].id)));
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
          Padding(
            padding: const EdgeInsets.fromLTRB( 18.0, 40,18,15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Upcoming Soon",style: bigwhite,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UpcomingScreen()));
                  },
                  child: Text("See All",style: bluenormalStyle),
                )
              ],
            ),
          ),
          Container(
            height: size.height*.35,
            width: size.width*.9,
            margin: EdgeInsets.only(bottom: 40),
            child: ListView.builder(
             // controller: _botpageController,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: data.moviesupcom.length,
                itemBuilder: (context,index){
                  return Stack(
                    children: [
                      Container(
                        height: size.height*.35,
                        width: size.width*.5,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage("${ApiConstant.IMAGE_ORIG_POSTER}${data.moviesupcom[index].posterPath}"),fit: BoxFit.fill)
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailsScreen(movieId: data.moviesupcom[index].id)));
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
