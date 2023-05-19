import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/customized/myappBar.dart';
import 'package:my_movies_app_flutter/screens/movies_screens/movieDetails_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/Global_consts.dart';
import '../../constants/api_constance.dart';
import '../../models/movie_model.dart';
import '../../providers/movies_provider.dart';

class DiscoverScreen extends StatefulWidget {
  DiscoverScreen({Key? key,}) : super(key: key);
  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late MoviesProvider moviesProvider;
  late Future<List<Movie>> _listoftrendMovies;
  Color _chosenColor=Colors.amberAccent;
  Color _unChosenColor=Colors.transparent;
  bool _voteselected=false;
  String _sort_by="&sort_by=popularity.desc";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    _listoftrendMovies = moviesProvider.discovermovies("${_sort_by}","");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar(),
      body: Consumer<MoviesProvider>(builder: (context,data,_){
        Size size=MediaQuery.of(context).size;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Sort By ........",style: bigwhite,),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                _sort_by="&sort_by=vote_count.desc";
                                data.discovermovies(_sort_by,'');
                              });
                              _voteselected=true;
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  color: _voteselected?_chosenColor:_unChosenColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text("Votes Count",style: bluenormalStyle),
                                )),
                          ),
                        ),
                        SizedBox(width: size.width*.09,),
                        InkWell(
                          onTap: (){
                            setState(() {
                              _voteselected=false;
                              _sort_by="&sort_by=popularity.desc";
                              data.discovermovies(_sort_by,'');
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: _voteselected?_unChosenColor:_chosenColor,
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
            data.discoverlist.length==0?Center(child: CircularProgressIndicator(),):
            Container(
              height: size.height*.72,
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.discoverlist.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2/3,
                  ),

                  itemBuilder: (context,index){
                    return Stack(
                      children: [
                        data.discoverlist[index].posterPath==null?
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Text("No Poster Available \n for ( ${data.discoverlist[index].title} )",style: bluenormalStyle,),
                          ),
                        ):
                        Container(
                          height: size.height*.5,
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
          ],
        );
      }),
    );




  }
}
