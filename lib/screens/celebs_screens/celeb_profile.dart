import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_movies_app_flutter/constants/Global_consts.dart';
import 'package:my_movies_app_flutter/customized/myappBar.dart';
import 'package:my_movies_app_flutter/models/celebrityProfile_model.dart';
import 'package:my_movies_app_flutter/providers/celebs_provider.dart';
import 'package:provider/provider.dart';
import '../../constants/api_constance.dart';
import '../../models/celeb_model.dart';
import '../movies_screens/movieDetails_screen.dart';
class CelebProfile extends StatefulWidget {
   CelebProfile({Key? key, required this.knownforList, required this.celebId}) : super(key: key);
final List<KnownFor> knownforList;
final int celebId;
  @override
  State<CelebProfile> createState() => _CelebProfileState();
}

class _CelebProfileState extends State<CelebProfile> {
  late Future<CelebrityProfile> _celebrityProfile;
  late CelebssProvider celebssProvider;
  @override
  void initState() {
    celebssProvider = Provider.of<CelebssProvider>(context, listen: false);
    _celebrityProfile=celebssProvider.getCelebById(id: widget.celebId);
    //print(celebssProvider.celebProfileById.id.toString());
  //  print(widget.knownforList.first.posterPath.toString());
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
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(),
      body: Consumer<CelebssProvider>(builder: (context,data,_) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              data.celebProfileById.name==null||data.celebProfileById.biography==null?
                  Center(child: CircularProgressIndicator(),):
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 Column(
                   children: [
                     Padding(
                       padding: const EdgeInsets.fromLTRB(11.0,0,11,11),
                       child: Text(data.celebProfileById.name??'',style: bigwhite),
                     ),
                     data.celebProfileById.profilePath==null?
                     Center(
                       child: Padding(
                         padding: const EdgeInsets.all(25.0),
                         child: Text("No Image Available \n for ( ${data.celebProfileById.name} )",style: bluenormalStyle,),
                       ),
                     ):
                     Container(
                        margin: EdgeInsets.fromLTRB(10,0,15,0),
                        height: size.height*.34,
                        width: size.width*.4,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage("${ApiConstant.IMAGE_ORIG_POSTER}${data.celebProfileById.profilePath}"),fit: BoxFit.fill)
                        ),

                      ),
                   ],
                 ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                         padding: const EdgeInsets.fromLTRB(18.0,10,0,10),
                         child: Text("Biography",style: bluebold,),
                       ),
                       Card(
                         elevation:10,
                         child: Container(
                           height: size.height*.35,
                           width: size.width*.47,
                           child: ListView(
                             shrinkWrap: true,
                             children:[ Container(
                               width: size.width*.5,
                               padding: const EdgeInsets.all(8.0),
                               child: Text(data.celebProfileById.biography??'',style: TextStyle(
                                  wordSpacing: 0,
                                 fontWeight: FontWeight.bold,
                                 letterSpacing: 0,
                                 fontSize: 15
                               ),

                               textAlign: TextAlign.start,
                               ),
                             ),
                           ]),
                         ),
                       ),
                     ],
                   )
                ],
              ),
              widget.knownforList.isEmpty?Container():
              Padding(
                padding: const EdgeInsets.fromLTRB( 18.0, 10,18,15),
                child: Text("Known For",style: bluebold,),
              ),
              widget.knownforList.isEmpty?Container():
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: size.height*.3,
                width: size.width*.9,
                child: ListView.builder(
                  shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.knownforList.length,
                    itemBuilder: (context,index){
                  return Stack(
                    children: [
                      widget.knownforList[index].posterPath==null?
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Text("No Poster Available \n for ( ${widget.knownforList[index].title} )",style: bluenormalStyle,),
                        ),
                      ):
                      Container(
                      height: size.height*.3,
                        width: size.width*.35,
                        decoration: BoxDecoration(
                          image: DecorationImage(image:NetworkImage("${ApiConstant.IMAGE_ORIG_POSTER}${widget.knownforList[index].posterPath}",),fit: BoxFit.fill
                          )
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailsScreen(movieId: widget.knownforList[index].id)));},
                          child: Container(
                            height: size.height*.03,
                            width: size.width*.22,
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
                padding: const EdgeInsets.fromLTRB( 18.0, 25,18,10),
                child: Text("More Info",style: bluebold,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Born",style: amberbold),
                        SizedBox(width: size.width*.02,),
                        Text(convertDateTimeDisplay(data.celebProfileById.birthday.toString())

                            ,style: deepbold),
                      ],
                    ),
                    data.celebProfileById.deathday!=null?
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Text("Death",style: bluebold),
                          SizedBox(width: size.width*.02,),
                          Text(convertDateTimeDisplay(data.celebProfileById.deathday.toString()),style: amberbold)

                        ],
                      ),
                    ):
                    SizedBox(height: size.height*.013,),
                    Row(

                      children: [
                        Text("Gender",style: amberbold),
                        SizedBox(width: size.width*.02,),
                        data.celebProfileById.gender==1?Text("Female",style: deepbold):Text("Male",style: deepbold)

                      ],
                    ),
                    SizedBox(height: size.height*.013,),
                    Row(
                      children: [
                        Text("Home",style: amberbold),
                        SizedBox(width: size.width*.02,),
                        Text(data.celebProfileById.placeOfBirth??"",style: deepbold)

                      ],
                    ),
                    SizedBox(height: size.height*.013,),
                    Row(
                      children: [
                        Text("Known For Department",style: amberbold),
                        SizedBox(width: size.width*.02,),
                        Text(data.celebProfileById.knownForDepartment??"",style: deepbold)
                      ],
                    ),
                    SizedBox(height: size.height*.013,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Also Known As",style: amberbold),
                        SizedBox(width: size.width*.02,),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                           // height: size.height*.3,
                            width: size.width*.64,
                            child: Text(data.celebProfileById.alsoKnownAs.toString(),style: deepbold,maxLines: 20,))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      })

    );
  }
}
