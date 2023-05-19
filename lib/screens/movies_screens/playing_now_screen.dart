import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/customized/myappBar.dart';
import 'package:my_movies_app_flutter/screens/movies_screens/movieDetails_screen.dart';
import 'package:provider/provider.dart';
import '../../constants/Global_consts.dart';
import '../../constants/api_constance.dart';
import '../../models/movie_model.dart';
import '../../providers/movies_provider.dart';

class PlayingNowScreen extends StatefulWidget {
  const PlayingNowScreen({Key? key}) : super(key: key);

  @override
  State<PlayingNowScreen> createState() => _PlayingNowScreenState();
}

class _PlayingNowScreenState extends State<PlayingNowScreen> {
  late MoviesProvider moviesProvider;
  late Future<List<Movie>> _listofplayinMovies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    _listofplayinMovies = moviesProvider.getallplayingMovies();
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
              child: Text("In Theaters",style: bluenormalStyle,),
            ),
            data.moviesPlaying.length == 0
                ? Center(
              child: CircularProgressIndicator(),
            )
                :Flexible(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: data.moviesPlaying.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                    ),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          data.moviesPlaying[index].posterPath==null?
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Text("No Poster Available \n for ( ${data.moviesPlaying[index].title} )",style: bluenormalStyle,),
                            ),
                          ):
                          Container(
                            height: size.height * .5,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${ApiConstant.IMAGE_ORIG_POSTER}${data.moviesPlaying[index].posterPath}"),
                                    fit: BoxFit.fill)),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailsScreen(movieId: data.moviesPlaying[index].id)));
                              },
                              child: Container(
                                height: size.height * .04,
                                width: size.width * .25,
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
          ],
        ),
      );
    });
  }
}
