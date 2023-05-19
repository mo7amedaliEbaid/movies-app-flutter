import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_movies_app_flutter/models/SeriesCastMember.dart';
import 'package:my_movies_app_flutter/models/tvDetails_model.dart';
import 'package:my_movies_app_flutter/providers/tmdb_userAccount_provider.dart';
import 'package:my_movies_app_flutter/providers/tv_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/Global_consts.dart';
import '../../constants/api_constance.dart';
import '../../customized/dissmissable.dart';
import '../../customized/myappBar.dart';
import '../celebs_screens/celeb_profile.dart';

class TvDetailsScreen extends StatefulWidget {
  const TvDetailsScreen({Key? key, required this.tvId}) : super(key: key);
  final int tvId;

  @override
  State<TvDetailsScreen> createState() => _TvDetailsScreenState();
}

class _TvDetailsScreenState extends State<TvDetailsScreen> {
  late Future<TvDetails> _tvdetails;
  late TvProvider tvProvider;
  late Future<List<CastMemberSeries>> _tvcast;

  @override
  void initState() {
    tvProvider = Provider.of<TvProvider>(context, listen: false);
    _tvdetails = tvProvider.getseriesById(id: widget.tvId);
    _tvcast = tvProvider.getcast( widget.tvId);
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
      body: Consumer2<TvProvider,UserAccountProvider>(builder: (context, data,userdata, _) {
        return SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    data.seriesById.backdropPath==null?
                    Container(
                      margin: EdgeInsets.fromLTRB(10,10,10,0),
                      height: size.height * .35,
                      width: size.width * .45,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${ApiConstant.IMAGE_ORIG_POSTER}${data.seriesById.posterPath}"),
                              fit: BoxFit.fill)),
                    ):
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: size.height * .35,
                      width: size.width * .45,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${ApiConstant.IMAGE_ORIG_POSTER}${data.seriesById.backdropPath}"),
                              fit: BoxFit.fill)),
                    ),
                    InkWell(
                      onTap: ()async{
                        SharedPreferences prefs=await SharedPreferences.getInstance();
                        String? pass=prefs.getString('pass');
                        if(pass !=null){
                          userdata.addToseriesWatchlist(data.seriesById.id!);
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
                          userdata.addToseriesFAVlist(data.seriesById.id!);
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
                          child: Text("Add To Favourite",style: blackbold,),
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
                        child: Text(
                          data.seriesById.name ?? "",
                          style: normalBoldWhite,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        )),
                    data.seriesById.overview == ''
                        ? Container()
                        : Padding(
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
                        data.seriesById.overview ?? '',
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
                    data.seriesById.tagline == ''
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                            child: Text(
                              "TageLine",
                              style: bluebold,
                            ),
                          ),
                    Container(
                      width: size.width * .5,
                      // padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data.seriesById.tagline ?? '',
                        style: TextStyle(
                            wordSpacing: 0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                            fontSize: 15),
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
                data.cast.isEmpty?Container():
                Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 20, 18, 15),
                  child: Text(
                    "Cast",
                    style: bluenormalStyle,
                  ),
                ),
                data.cast.isEmpty?Container():
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * .3,
                  width: size.width * .9,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: data.cast.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            data.cast[index].profilePath == null
                                ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Text(
                                  "No Image Available \n for ( ${data.cast[index].name} )",
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
                                        "${ApiConstant.IMAGE_ORIG_POSTER}${data.cast[index].profilePath}",
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
                                          celebId: data.cast[index].id)));
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
    data.seriesById.seasons==null?Container():
    Padding(
    padding: const EdgeInsets.fromLTRB(18.0, 40, 18, 15),
    child: Text(
    "Seasons",
    style: bluenormalStyle,
    ),
    ),
    data.seriesById.seasons==null?Container():
    Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    height: size.height * .3,
    width: size.width * .9,
    child: ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemCount: data.seriesById.seasons!.length,
    itemBuilder: (context, index) {
      return data.seriesById.seasons![index].posterPath == null
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            "No Poster Available \n for ( ${data.seriesById.seasons!.first.name} )",
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
                  "${ApiConstant.IMAGE_ORIG_POSTER}${data.seriesById.seasons![index]
                      .posterPath}",
                ),
                fit: BoxFit.fill)),
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
                            Text(data.seriesById.status ?? "", style: deepbold)
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
                                    data.seriesById.firstAirDate.toString()),
                                style: deepbold),
                          ],
                        ),SizedBox(
                          height: size.height * .013,
                        ),
                        Row(
                          children: [
                            Text("In Production", style: amberbold),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Text(
                                    data.seriesById.inProduction.toString(),
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
                              data.seriesById.spokenLanguages==null?Container():
                              Row(
                                children: [
                                  // ...data.movieById.spokenLanguages!.map((e) =>Text(e.name) ).toList(),
                                  Text("Languages", style: amberbold),
                                  SizedBox(
                                    width: size.width * .02,
                                  ),
                                  ...data.seriesById.spokenLanguages!
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
                                  Text(data.seriesById.originalName ?? "",
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
                            Text("${data.seriesById.episodeRunTime.toString()} mins",
                                style: deepbold)
                          ],
                        ),
                        SizedBox(
                          height: size.height * .013,
                        ),
                        Row(
                          children: [
                            Text("Number Of Seasons", style: amberbold),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Text(
                              data.seriesById.numberOfSeasons.toString(),
                              style: deepbold,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * .013,
                        ),
                        Row(
                          children: [
                            Text("Number Of Episodes", style: amberbold),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Text(
                              data.seriesById.numberOfEpisodes.toString(),
                              style: deepbold,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * .013,
                        ),
                        data.seriesById.createdBy==null?Container():
                        Row(
                          children: [
                            Text("Created By", style: amberbold),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            ...data.seriesById.createdBy!
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
                              Row(
                                children: [
                                  Text("Genres", style: amberbold),
                                  SizedBox(
                                    width: size.width * .02,
                                  ),
                                  ...data.seriesById.genres!
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
                              data.seriesById.voteAverage.toString(),
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
                              data.seriesById.voteCount.toString(),
                              style: deepbold,
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * .08,
                        ),
                      ]),
                ),
    ])
    );
      }),
    );
  }
}
