import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/models/tv_model.dart';
import 'package:my_movies_app_flutter/providers/tv_provider.dart';
import 'package:my_movies_app_flutter/screens/tv_screens/tvDetails_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/Global_consts.dart';
import '../../constants/api_constance.dart';
import '../../models/movie_model.dart';
import '../../providers/movies_provider.dart';

class TvPage extends StatefulWidget {
  const TvPage({Key? key}) : super(key: key);

  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  late TvProvider tvProvider;
  late Future<List<TvSeries>> _listofseries;
  Color _chosenColor=Colors.amberAccent;
  Color _unChosenColor=Colors.transparent;
  bool voteselected=false;
  String _sort_by="popularity.desc";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tvProvider = Provider.of<TvProvider>(context, listen: false);
    _listofseries = tvProvider.getallseries(_sort_by);

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TvProvider>(builder: (context,data,_){
      Size size=MediaQuery.of(context).size;
      return
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Sort By ........",style: bigwhite,),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          _sort_by="vote_average.dsc";
                          data.getallseries(_sort_by);
                        });
                        voteselected=true;
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: voteselected?_chosenColor:_unChosenColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("Rating",style: bluenormalStyle),
                          )),
                    ),
                    SizedBox(width: size.width*.09,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          voteselected=false;
                          _sort_by="popularity.desc";
                          data.getallseries(_sort_by);
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: voteselected?_unChosenColor:_chosenColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("Popularity",style: bluenormalStyle),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
          data.series.length==0?Center(child: CircularProgressIndicator(),):
          Container(
            height: size.height*.66,
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: data.series.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2/3,
                ),

                itemBuilder: (context,index){
                  return Stack(
                    children: [
                      data.series[index].posterPath==null?
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Text("No Poster Available \n for ( ${data.series[index].name} )",style: bluenormalStyle,),
                        ),
                      ):
                      Container(
                        height: size.height*.5,
                        decoration: BoxDecoration(
                            image: DecorationImage(image:
                            NetworkImage("${ApiConstant.IMAGE_ORIG_POSTER}${data.series[index].posterPath}"),fit: BoxFit.fill)
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TvDetailsScreen(tvId: data.series[index].id)));
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
