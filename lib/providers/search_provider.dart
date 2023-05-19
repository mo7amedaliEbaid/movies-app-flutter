import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:my_movies_app_flutter/models/movie_model.dart';
import 'package:my_movies_app_flutter/models/tv_model.dart';

import '../constants/api_constance.dart';
import '../models/celeb_model.dart';
class SearchProvider extends ChangeNotifier{
  List<Movie> searchedforMovies = [];
  List<TvSeries> searchedforseries = [];
  List<Celeb> searchedforCelebs = [];

  Future<List<Movie>> getsearchedMovies(String searchedFor) async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.SEARCH_MOVIES}${ApiConstant.API_KEY}${ApiConstant.SEARCH_QUERY}${searchedFor}"));
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
      searchedforMovies=Movie.moviesFromSnapshot(mvsTempList);

      notifyListeners();
      return searchedforMovies;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<TvSeries>> getsearchedSeries(String searchedFor) async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.SEARCH_TV}${ApiConstant.API_KEY}${ApiConstant.SEARCH_QUERY}${searchedFor}"));
    print('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List tvsTempList = [];
    for (var v in data["results"]) {
      tvsTempList.add(v);
      log(v.toString());
      print(data["results"].length.toString());
    }
    if (response.statusCode == 200) {
      searchedforseries=TvSeries.seriesFromSnapshot(tvsTempList);

      notifyListeners();
      return searchedforseries;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<Celeb>> getsearchedCelebs(String searchedFor) async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.SEARCH_PERSON}${ApiConstant.API_KEY}${ApiConstant.SEARCH_QUERY}${searchedFor}"));
    print('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List celebsTempList = [];
    for (var v in data["results"]) {
      celebsTempList.add(v);
      log(v.toString());
      print(data["results"].length.toString());
    }
    if (response.statusCode == 200) {
      searchedforCelebs=Celeb.celebsFromSnapshot(celebsTempList);

      notifyListeners();
      return searchedforCelebs;
    } else {
      throw Exception('Failed to load album');
    }
  }

}

