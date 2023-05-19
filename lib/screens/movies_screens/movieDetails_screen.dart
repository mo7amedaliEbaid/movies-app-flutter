import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_movies_app_flutter/constants/Global_consts.dart';
import 'package:my_movies_app_flutter/customized/myappBar.dart';
import 'package:my_movies_app_flutter/models/crewMember_model.dart';
import 'package:my_movies_app_flutter/models/movieDetails_model.dart';
import 'package:my_movies_app_flutter/models/movie_model.dart';
import 'package:my_movies_app_flutter/providers/authwith_TMDB_provider.dart';
import 'package:my_movies_app_flutter/providers/movieDetails_provider.dart';
import 'package:my_movies_app_flutter/screens/celebs_screens/celeb_profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/api_constance.dart';
import '../../customized/dissmissable.dart';
import '../../providers/tmdb_userAccount_provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  MovieDetailsScreen({Key? key, required this.movieId}) : super(key: key);
  final int movieId;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<MovieDetails> _moviedetails;
  late Future<List<CrewMember>> _moviecrew;
  late MovieDetailsProvider movieDetailsProvider;
  late AuthWithTMDBProvider authWithTMDBProvider;
 // late UserAccountProvider userAccountProvider;
  late Future<List<Movie>> _similarMovies;

  @override
  void initState() {
    movieDetailsProvider =
        Provider.of<MovieDetailsProvider>(context, listen: false);
    authWithTMDBProvider =
        Provider.of<AuthWithTMDBProvider>(context, listen: false);
    /*userAccountProvider =
        Provider.of<UserAccountProvider>(context, listen: false);*/
    authWithTMDBProvider.createSession();
   // userAccountProvider.getAccountId();
    _moviedetails = movieDetailsProvider.getmovieById(id: widget.movieId);
    _moviecrew = movieDetailsProvider.getcrew(widget.movieId);
    _similarMovies = movieDetailsProvider.getallsimilarMovies(widget.movieId);
    super.initState();
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: MyAppBar(),
        body: Consumer2<MovieDetailsProvider,UserAccountProvider>(builder: (context, data,userdata, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        data.movieById.backdropPath==null?
                        Container(
                          margin: EdgeInsets.fromLTRB(10,10,10,0),
                          height: size.height * .35,
                          width: size.width * .45,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${ApiConstant.IMAGE_ORIG_POSTER}${data.movieById.posterPath}"),
                                  fit: BoxFit.fill)),
                        ):
                        Container(
                          margin: EdgeInsets.fromLTRB(10,10,10,0),
                          height: size.height * .33,
                          width: size.width * .45,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${ApiConstant.IMAGE_ORIG_POSTER}${data.movieById.backdropPath}"),
                                  fit: BoxFit.fill)),
                        ),
                        InkWell(
                          onTap: ()async{
                            SharedPreferences prefs=await SharedPreferences.getInstance();
                            String? pass=prefs.getString('pass');
                            if(pass !=null){
                              userdata.addTomoviesWatchlist(data.movieById.id!);
                            }else {
                              Navigator.of(context).push(
                                  DismissibleDialog<void>());

                            }
                          },

                          child: Container(
                            height: size.height * .05,
                            width: size.width * .45,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              //borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text("Add To Watchlist",style: blackbold,),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: ()async{
                            SharedPreferences prefs=await SharedPreferences.getInstance();
                            String? pass=prefs.getString('pass');
                            if(pass !=null){
                              userdata.addTomoviesFAVlist(data.movieById.id!);
                            }else {
                              Navigator.of(context).push(
                                  DismissibleDialog<void>());

                            }
                          },
                          child: Container(
                            height: size.height * .05,
                            width: size.width * .45,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              //borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text("Add To Favourites",style: blackbold,),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: size.width * .45,
                            margin: EdgeInsets.all(10),
                            child: Center(
                                child: Text(
                              data.movieById.title ?? "",
                              style: normalBoldWhite,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ))),
                        data.movieById.overview==''?Container():
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Text(
                            "OverView",
                            style: bluebold,
                          ),
                        ),
                        Container(
                          width: size.width * .5,
                          // padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data.movieById.overview ?? '',
                            style: TextStyle(
                                wordSpacing: 0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0,
                                fontSize: 15),
                            textAlign: TextAlign.start,
                            maxLines: 15,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                data.crew.isEmpty?Container():
                Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 20, 18, 15),
                  child: Text(
                    "Crew",
                    style: bluenormalStyle,
                  ),
                ),
                data.crew.isEmpty?Container():
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * .3,
                  width: size.width * .9,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: data.crew.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            data.crew[index].profilePath == null
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Text(
                                        "No Image Available \n for ( ${data.crew[index].name} )",
                                        style: bluenormalStyle,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: size.height * .3,
                                    width: size.width * .35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              "${ApiConstant.IMAGE_ORIG_POSTER}${data.crew[index].profilePath}",
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CelebProfile(
                                          knownforList: [],
                                          celebId: data.crew[index].id)));
                                },
                                child: Container(
                                  height: size.height * .03,
                                  width: size.width * .22,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.amberAccent,
                                  ),
                                  child: Center(
                                      child: Text(
                                    "See Profile",
                                    style: bluesmallStyle,
                                  )),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                data.similarMovies.isEmpty?Container():
                Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 40, 18, 15),
                  child: Text(
                    "Similar Movies",
                    style: bluenormalStyle,
                  ),
                ),
                data.similarMovies.isEmpty?Container():
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * .3,
                  width: size.width * .9,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: data.similarMovies.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            data.similarMovies[index].posterPath == null
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Text(
                                        "No Poster Available \n for ( ${data.similarMovies[index].title} )",
                                        style: bluenormalStyle,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: size.height * .3,
                                    width: size.width * .35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              "${ApiConstant.IMAGE_ORIG_POSTER}${data.similarMovies[index].posterPath}",
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MovieDetailsScreen(
                                          movieId:
                                              data.similarMovies[index].id)));
                                },
                                child: Container(
                                  height: size.height * .03,
                                  width: size.width * .22,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.amberAccent,
                                  ),
                                  child: Center(
                                      child: Text(
                                    "See Details",
                                    style: bluesmallStyle,
                                  )),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 25, 18, 10),
                  child: Text(
                    "More Info",
                    style: bluebold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Status", style: amberbold),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Text(data.movieById.status ?? "", style: deepbold)
                          ],
                        ),
                        SizedBox(
                          height: size.height * .013,
                        ),
                        Row(
                          children: [
                            Text("Realease Date", style: amberbold),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Text(
                                convertDateTimeDisplay(
                                    data.movieById.releaseDate.toString()),
                                style: deepbold),
                          ],
                        ),
                        SizedBox(
                          height: size.height * .013,
                        ),
                        Container(
                          height: 20,
                          width: size.width * .9,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              data.movieById.spokenLanguages==null?Container():
                              Row(
                                children: [
                                  // ...data.movieById.spokenLanguages!.map((e) =>Text(e.name) ).toList(),
                                  Text("Languages", style: amberbold),
                                  SizedBox(
                                    width: size.width * .02,
                                  ),
                                  ...data.movieById.spokenLanguages!
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: Text(
                                              "( ${e.englishName} )",
                                              style: deepbold,
                                            ),
                                          ))
                                      .toList(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * .013,
                        ),
                        Container(
                          height: 20,
                          width: size.width*.9,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
                              Row(
                                children: [
                                  Text("Original Title", style: amberbold,),
                                  SizedBox(
                                    width: size.width * .02,
                                  ),
                                  Text(data.movieById.originalTitle ?? "",
                                      style: deepbold)
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * .013,
                        ),
                        Row(
                          children: [
                            Text("Runtime", style: amberbold),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Text("${data.movieById.runtime} mins",
                                style: deepbold)
                          ],
                        ),
                        SizedBox(
                          height: size.height * .013,
                        ),
                        Row(
                          children: [
                            Text("Budget (\$)", style: amberbold),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Text(
                              data.movieById.budget.toString(),
                              style: deepbold,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * .013,
                        ),
                        Row(
                          children: [
                            Text("Box Office (\$)", style: amberbold),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Text(
                              data.movieById.revenue.toString(),
                              style: deepbold,
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * .013,
                        ),
                        Container(
                          height: 20,
                          width: size.width * .9,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              data.movieById.genres==null?Container():
                              Row(
                                children: [
                                  Text("Genres", style: amberbold),
                                  SizedBox(
                                    width: size.width * .02,
                                  ),
                                  ...data.movieById.genres!
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: Text(
                                              "( ${e.name} )",
                                              style: deepbold,
                                            ),
                                          ))
                                      .toList(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * .013,
                        ),
                        Row(
                          children: [
                            Text("Average Rating", style: amberbold),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Text(
                              data.movieById.voteAverage.toString(),
                              style: deepbold,
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * .013,
                        ),
                        Row(
                          children: [
                            Text("Number Of Votes", style: amberbold),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Text(
                              data.movieById.voteCount.toString(),
                              style: deepbold,
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * .08,
                        ),
                      ]),
                ),
              ],
            ),
          );
        }));
  }
}
