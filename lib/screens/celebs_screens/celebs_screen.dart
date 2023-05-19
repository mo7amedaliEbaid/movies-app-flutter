import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/models/celeb_model.dart';
import 'package:my_movies_app_flutter/providers/celebs_provider.dart';
import 'package:my_movies_app_flutter/screens/celebs_screens/celeb_profile.dart';
import 'package:provider/provider.dart';

import '../../constants/Global_consts.dart';
import '../../constants/api_constance.dart';

class CelebsPage extends StatefulWidget {
  const CelebsPage({Key? key}) : super(key: key);

  @override
  State<CelebsPage> createState() => _CelebsPageState();
}

class _CelebsPageState extends State<CelebsPage> {
  late CelebssProvider celebssProvider;
  late Future<List<Celeb>> _listoftrendclebs;
  Color chosenColor=Colors.amberAccent;
  Color unChosenColor=Colors.transparent;
  bool weekSelected=false;
  String _trending_period="day";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    celebssProvider = Provider.of<CelebssProvider>(context, listen: false);
    _listoftrendclebs = celebssProvider.getallcelebs(_trending_period);

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CelebssProvider>(builder: (context,data,_){
      Size size=MediaQuery.of(context).size;
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
                          data.getallcelebs(_trending_period);
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
                          data.getallcelebs(_trending_period);
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
          data.celebrities.length==0?Center(child: CircularProgressIndicator(),):
          Container(
            height: size.height*.67,
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: data.celebrities.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2/3,
                ),

                itemBuilder: (context,index){
                  return Stack(
                    children: [
                      data.celebrities[index].profilePath==null?
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Text("No Image Available \n for ( ${data.celebrities[index].name} )",style: bluenormalStyle,),
                        ),
                      ):
                      Container(
                        height: size.height*.5,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage("${ApiConstant.IMAGE_ORIG_POSTER}${data.celebrities[index].profilePath}"),fit: BoxFit.fill)
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: (){

                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CelebProfile(knownforList: data.celebrities[index].knownFor, celebId: data.celebrities[index].id, )));
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
                }),
          ),
        ],
      );
    });


  }
}
