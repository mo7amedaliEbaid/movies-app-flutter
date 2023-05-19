import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/customized/myappBar.dart';
import 'package:my_movies_app_flutter/providers/tmdb_userAccount_provider.dart';
import 'package:my_movies_app_flutter/screens/movies_screens/movieDetails_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/Global_consts.dart';
import '../../constants/api_constance.dart';
import '../../models/itemonUserlists_model.dart';
import '../tv_screens/tvDetails_screen.dart';

class TMDBUserScreen extends StatefulWidget {
  const TMDBUserScreen({Key? key}) : super(key: key);

  @override
  State<TMDBUserScreen> createState() => _TMDBUserScreenState();
}

class _TMDBUserScreenState extends State<TMDBUserScreen> {
  late UserAccountProvider userAccountProvider;
  late Future<List<ItemOnUserlistsModel>> _moviewatchlist;
  late Future<List<ItemOnUserlistsModel>> _movieFAVlist;
  late Future<List<ItemOnUserlistsModel>> _tvwatchlist;
  late Future<List<ItemOnUserlistsModel>> _tvFAVlist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userAccountProvider =
        Provider.of<UserAccountProvider>(context, listen: false);
    userAccountProvider.getAccountId();
    _moviewatchlist = userAccountProvider.getwatchlistMovies();
    _movieFAVlist = userAccountProvider.getFAVlistMovies();
    _tvFAVlist = userAccountProvider.getFAVlistSeries();
    _tvwatchlist = userAccountProvider.getwatchlistSeries();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(),
      body: Consumer<UserAccountProvider>(
        builder: (context, data, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'UserName',
                      style: deepbold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      data.acountModel.username!,
                      style: bigwhite,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 30, 18, 15),
                  child: Text(
                    "Your Movies Watchlist",
                    style: bluenormalStyle,
                  ),
                ),
                data.moviesWatchlist.isEmpty
                    ? Container(
                        height: size.height * .2,
                        width: size.width * .9,
                        child: Center(
                          child: Text(
                            'Add Some Titles To This List',
                            style: bigwhite,
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: size.height * .3,
                        width: size.width * .9,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: data.moviesWatchlist.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  data.moviesWatchlist[index].posterPath == null
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(25.0),
                                            child: Text(
                                              "No Poster Available \n for ( ${data.moviesWatchlist[index].title} )",
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
                                                    "${ApiConstant.IMAGE_ORIG_POSTER}${data.moviesWatchlist[index].posterPath}",
                                                  ),
                                                  fit: BoxFit.fill)),
                                        ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MovieDetailsScreen(
                                                      movieId: data
                                                          .moviesWatchlist[
                                                              index]
                                                          .id,
                                                    )));
                                      },
                                      child: Container(
                                        height: size.height * .03,
                                        width: size.width * .22,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                  padding: const EdgeInsets.fromLTRB(18.0, 30, 18, 15),
                  child: Text(
                    "Your Favourite Movies",
                    style: bluenormalStyle,
                  ),
                ),
                data.moviesWatchlist.isEmpty
                    ? Container(
                        height: size.height * .2,
                        width: size.width * .9,
                        child: Center(
                          child: Text(
                            'Add Some Titles To This List',
                            style: bigwhite,
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: size.height * .3,
                        width: size.width * .9,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: data.moviesFAVlist.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  data.moviesFAVlist[index].posterPath == null
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(25.0),
                                            child: Text(
                                              "No Poster Available \n for ( ${data.moviesFAVlist[index].title} )",
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
                                                    "${ApiConstant.IMAGE_ORIG_POSTER}${data.moviesFAVlist[index].posterPath}",
                                                  ),
                                                  fit: BoxFit.fill)),
                                        ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MovieDetailsScreen(
                                                      movieId: data
                                                          .moviesFAVlist[index]
                                                          .id,
                                                    )));
                                      },
                                      child: Container(
                                        height: size.height * .03,
                                        width: size.width * .22,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                  padding: const EdgeInsets.fromLTRB(18.0, 30, 18, 15),
                  child: Text(
                    "Your Tv Watchlist",
                    style: bluenormalStyle,
                  ),
                ),
                data.seriesWatchlist.isEmpty
                    ? Container(
                        height: size.height * .2,
                        width: size.width * .9,
                        child: Center(
                          child: Text(
                            'Add Some Titles To This List',
                            style: bigwhite,
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: size.height * .3,
                        width: size.width * .9,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: data.seriesWatchlist.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  data.seriesWatchlist[index].posterPath == null
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(25.0),
                                            child: Text(
                                              "No Poster Available \n for ( ${data.seriesWatchlist[index].title} )",
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
                                                    "${ApiConstant.IMAGE_ORIG_POSTER}${data.seriesWatchlist[index].posterPath}",
                                                  ),
                                                  fit: BoxFit.fill)),
                                        ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TvDetailsScreen(
                                                      tvId: data
                                                          .seriesWatchlist[
                                                              index]
                                                          .id,
                                                    )));
                                      },
                                      child: Container(
                                        height: size.height * .03,
                                        width: size.width * .22,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                  padding: const EdgeInsets.fromLTRB(18.0, 30, 18, 15),
                  child: Text(
                    "Your Favourite Series",
                    style: bluenormalStyle,
                  ),
                ),
                data.seriesFAVlist.isEmpty
                    ? Container(
                        height: size.height * .2,
                        width: size.width * .9,
                        child: Center(
                          child: Text(
                            'Add Some Titles To This List',
                            style: bigwhite,
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: size.height * .3,
                        width: size.width * .9,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: data.seriesFAVlist.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  data.seriesFAVlist[index].posterPath == null
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(25.0),
                                            child: Text(
                                              "No Poster Available \n for ( ${data.seriesFAVlist[index].title} )",
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
                                                    "${ApiConstant.IMAGE_ORIG_POSTER}${data.seriesFAVlist[index].posterPath}",
                                                  ),
                                                  fit: BoxFit.fill)),
                                        ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TvDetailsScreen(
                                                      tvId: data
                                                          .seriesFAVlist[index]
                                                          .id,
                                                    )));
                                      },
                                      child: Container(
                                        height: size.height * .03,
                                        width: size.width * .22,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
