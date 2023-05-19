import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/models/crewMember_model.dart';

import '../constants/api_constance.dart';
import '../models/movieDetails_model.dart';
import 'package:http/http.dart'as http;

import '../models/movie_model.dart';
class MovieDetailsProvider extends ChangeNotifier{
  MovieDetails movieById=MovieDetails(releaseDate: DateTime(0));
  List<CrewMember> crew = [];
  List<Movie> similarMovies=[];
  Future<List<Movie>> getallsimilarMovies(int movieId) async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.MOVIE_DETAILS}${movieId}${ApiConstant.SIMILAR_MOVIES}${ApiConstant.API_KEY}"));
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
      similarMovies=Movie.moviesFromSnapshot(mvsTempList);

      notifyListeners();
      return similarMovies;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<MovieDetails> getmovieById({required int id}) async {
    try {
      var response = await http.get(Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.MOVIE_DETAILS}${id}${ApiConstant.API_KEY}"));
      print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw data["message"];
      }
      movieById=MovieDetails.fromJson(data);
      notifyListeners();
      log(movieById.id.toString());
      return movieById;
    } catch (error) {
      log("an error occured while getting movie info $error");
      throw error.toString();
    }
  }
  Future<List<CrewMember>> getcrew(int movieId) async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.MOVIE_DETAILS}${movieId}${ApiConstant.CREDITS_CREW}${ApiConstant.API_KEY}"));
    print('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List crewTempList = [];
    for (var v in data["cast"]) {
      crewTempList.add(v);
      log(v.toString());
      print(data["cast"].length.toString());
    }
    if (response.statusCode == 200) {
      crew=CrewMember.crewFromSnapshot(crewTempList);

      notifyListeners();
      return crew;
    } else {
      throw Exception('Failed to load album');
    }
  }
}