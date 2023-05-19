import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/constants/api_constance.dart';
import 'package:my_movies_app_flutter/models/movie_model.dart';
import 'package:http/http.dart'as http;
class MoviesProvider extends ChangeNotifier{
  List<Movie> moviesPlaying = [];
  List<Movie> moviespopular = [];
  List<Movie> moviesupcom = [];
  List<Movie> moviestrend = [];
  List<Movie> discoverlist = [];
  List<Movie> topRated=[];
  Future<List<Movie>> getallplayingMovies() async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.NOW_PLAYING}${ApiConstant.API_KEY}"));
    print('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List mvsTempList = [];
    for (var v in data["results"]) {
      mvsTempList.add(v);
      log(v.toString());
      print(data["results"].length.toString());
    }
    if (response.statusCode == 200) {
      moviesPlaying=Movie.moviesFromSnapshot(mvsTempList);

      notifyListeners();
      return moviesPlaying;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<Movie>> discovermovies(String sortby,String selected_genre) async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.DISCOVER_MOVIE}${ApiConstant.API_KEY}${sortby}${selected_genre}"));
    print('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List mvsTempList = [];
    for (var v in data["results"]) {
      mvsTempList.add(v);
      log(v.toString());
      print(data["results"].length.toString());
    }
    if (response.statusCode == 200) {
      discoverlist=Movie.moviesFromSnapshot(mvsTempList);

      notifyListeners();
      return discoverlist;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<Movie>> getallpopularMovies(String year) async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.POPULAR_MOVIES}${ApiConstant.API_KEY}${year}"));
    print('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List mvsTempList = [];
    for (var v in data["results"]) {
      mvsTempList.add(v);
      log(v.toString());
      print(data["results"].length.toString());
    }
    if (response.statusCode == 200) {
      moviespopular=Movie.moviesFromSnapshot(mvsTempList);

      notifyListeners();
      return moviespopular;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<Movie>> getallupcomMovies() async {
    var response = await http.get(Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.UPCOMING_MOVIE}${ApiConstant.API_KEY}"));
    print('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List mvsTempList = [];
    for (var v in data["results"]) {
      mvsTempList.add(v);
      log(v.toString());
      print(data["results"].length.toString());
    }
    if (response.statusCode == 200) {
      moviesupcom=Movie.moviesFromSnapshot(mvsTempList);

      notifyListeners();
      return moviesupcom;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<Movie>> getallTrendMovies(String trendigPer) async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.TRENDING_MOVIE_LIST}${trendigPer}${ApiConstant.API_KEY}"));
    print('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List mvsTempList = [];
    for (var v in data["results"]) {
      mvsTempList.add(v);
      log(v.toString());
      print(data["results"].length.toString());
    }
    if (response.statusCode == 200) {
      moviestrend=Movie.moviesFromSnapshot(mvsTempList);

      notifyListeners();
      return moviestrend;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<Movie>> getallTopratMovies(String topratPeryear) async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.TOP_RATED}${ApiConstant.API_KEY}${topratPeryear}"));
    print('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List mvsTempList = [];
    for (var v in data["results"]) {
      mvsTempList.add(v);
      log(v.toString());
      print(data["results"].length.toString());
    }
    if (response.statusCode == 200) {
      topRated=Movie.moviesFromSnapshot(mvsTempList);

      notifyListeners();
      return topRated;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

