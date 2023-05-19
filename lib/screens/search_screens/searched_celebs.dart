import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/models/celeb_model.dart';
import 'package:my_movies_app_flutter/screens/search_screens/search_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/Global_consts.dart';
import '../../constants/api_constance.dart';
import '../../customized/myappBar.dart';
import '../../models/movie_model.dart';
import '../../providers/search_provider.dart';
import '../celebs_screens/celeb_profile.dart';

class SearchedCelebsScreen extends StatefulWidget {
  const SearchedCelebsScreen({Key? key, required this.searchedfor})
      : super(key: key);
  final String searchedfor;

  @override
  State<SearchedCelebsScreen> createState() => _SearchedCelebsScreenState();
}

class _SearchedCelebsScreenState extends State<SearchedCelebsScreen> {
  late SearchProvider searchProvider;
  late Future<List<Celeb>> _listofsearchedcelebs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    _listofsearchedcelebs =
        searchProvider.getsearchedCelebs(widget.searchedfor);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: MyAppBar(),
        body: Consumer<SearchProvider>(builder: (context, data, _) {
          return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    'Search Results For”${widget.searchedfor}”',
                    style: bluebold,
                  ),
                ),
                data.searchedforCelebs.isNotEmpty
                    ?
                Flexible(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.7 / 3,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        crossAxisCount: 2),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount:data.searchedforCelebs.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          data.searchedforCelebs[index].profilePath==null?
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Text("No Image Available \n for ( ${data.searchedforCelebs[index].name} )",style: bluenormalStyle,),
                            ),
                          ):
                          Container(
                            height: size.height*.5,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage("${ApiConstant.IMAGE_ORIG_POSTER}${data.searchedforCelebs[index].profilePath}"),fit: BoxFit.fill)
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: (){

                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CelebProfile(knownforList: data.searchedforCelebs[index].knownFor, celebId: data.searchedforCelebs[index].id, )));
                              },
                              child: Container(
                                height: size.height*.04,
                                width: size.width*.25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.amberAccent,
                                ),
                                child: Center(child: Text("See Profile",style: bluesmallStyle,)),
                              ),
                            ),),
                        ],
                      );
                    },
                  ),
                )
                    :Center(
                  child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red,width: 2)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Sorry We Stucked While Searching The Internet!",style: normalBoldWhite,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Try To Your Search Again",style: bluebold,),
                          ),
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SearchScreen()));
                                  },
                                  child: Icon(Icons.refresh,size: 20,color: Colors.white,)),
                            ),
                          )
                        ],
                      )),
                ),
              ]);
        })

    );
  }
}
