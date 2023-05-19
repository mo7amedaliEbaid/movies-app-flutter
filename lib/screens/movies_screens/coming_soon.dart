import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/customized/myappBar.dart';
import 'package:provider/provider.dart';
import '../../constants/Global_consts.dart';
import '../../constants/api_constance.dart';
import '../../models/movie_model.dart';
import '../../providers/movies_provider.dart';
import 'movieDetails_screen.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  late MoviesProvider moviesProvider;
  late Future<List<Movie>> _listofupMovies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    _listofupMovies = moviesProvider.getallupcomMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(builder: (context, data, _) {
      Size size = MediaQuery.of(context).size;
      return Scaffold(
        appBar: MyAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Coming Soon",style: bluenormalStyle,),
            ),
            data.moviesupcom.length == 0
                ? Center(
              child: CircularProgressIndicator(),
            )
                :Flexible(
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.moviesupcom.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                  ),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        data.moviesupcom[index].posterPath==null?
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Text("No Poster Available \n for ( ${data.moviesupcom[index].title} )",style: bluenormalStyle,),
                          ),
                        ):
                        Container(
                          height: size.height * .5,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${ApiConstant.IMAGE_ORIG_POSTER}${data.moviesupcom[index].posterPath}"),
                                  fit: BoxFit.fill)),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: size.height * .04,
                            width: size.width * .25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.amberAccent,
                            ),
                            child: Center(
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailsScreen(movieId: data.moviesupcom[index].id,)));
                                  },
                                  child: Text(
                                    "See Details",
                                    style: bluesmallStyle,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      );
    });
  }
}
