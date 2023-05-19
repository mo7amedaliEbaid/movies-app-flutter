import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../constants/api_constance.dart';
import '../models/genre_model.dart';
import 'package:http/http.dart'as http;
class GenreProvider extends ChangeNotifier{
List<Genre> genres=[];
Future<List<Genre>> getallGenres() async {
  var response = await http.get(Uri.parse(
      "${ApiConstant.BASE_URL}${ApiConstant.GENRES_LIST}${ApiConstant.API_KEY}"));
  print('Response status: ${response.statusCode}');
  log('Response body: ${response.body}');
  var data = jsonDecode(response.body);
  List gnsTempList = [];
  for (var v in data["genres"]) {
    gnsTempList.add(v);
    log(v.toString());
    print(data["genres"].length.toString());
  }
  if (response.statusCode == 200) {
    genres=Genre.genresFromSnapshot(gnsTempList);

    notifyListeners();
    return genres;
  } else {
    throw Exception('Failed to load album');
  }
}
}