import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/models/genre_model.dart';
import 'package:my_movies_app_flutter/providers/genre_provider.dart';
import 'package:my_movies_app_flutter/screens/genres_screens/single_genre_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/Global_consts.dart';

class GenresPage extends StatefulWidget {
  const GenresPage({Key? key}) : super(key: key);

  @override
  State<GenresPage> createState() => _GenresPageState();
}

class _GenresPageState extends State<GenresPage> {
  late GenreProvider genreProvider;
  late Future<List<Genre>> _listofgenres;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genreProvider = Provider.of<GenreProvider>(context, listen: false);
    _listofgenres = genreProvider.getallGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GenreProvider>(builder: (context, data, _) {
      Size size = MediaQuery.of(context).size;
      return data.genres.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: size.height * .65,
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.genres.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 3,
                    //mainAxisSpacing: 15,
                    // crossAxisSpacing: 15
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SingleGenre(
                                  genre_id: data.genres[index].id,
                                  genre: data.genres[index].name,
                                )));
                      },
                      child: Container(
                        margin: EdgeInsets.all(size.height * .025),
                        decoration: BoxDecoration(
                            //  color: mycolors[index],
                            borderRadius: BorderRadius.circular(60),
                            gradient: mydecGrad[index],
                            boxShadow: List.filled(
                              50,
                              BoxShadow(
                                  color: Colors.deepPurple,
                                  offset: Offset(5, 10)),
                              growable: true,
                            )),

                        //height: size.height*.4,
                        child: Center(
                          child: Text(
                            data.genres[index].name,
                            maxLines: 1,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  }),
            );
    });
  }
}
