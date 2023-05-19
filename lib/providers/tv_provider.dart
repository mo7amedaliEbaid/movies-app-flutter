import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:my_movies_app_flutter/models/SeriesCastMember.dart';
import 'package:my_movies_app_flutter/models/tvDetails_model.dart';
import 'package:my_movies_app_flutter/models/tv_model.dart';

import '../constants/api_constance.dart';
class TvProvider extends ChangeNotifier{
  List<TvSeries> series = [];
  TvDetails seriesById=TvDetails(firstAirDate: DateTime(0));
  List<CastMemberSeries> cast = [];
  Future<List<TvSeries>> getallseries(String sortby) async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.DISCOVER_TV}${ApiConstant.API_KEY}${ApiConstant.SORT_TV}${sortby}"));
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
      series=TvSeries.seriesFromSnapshot(tvsTempList);

      notifyListeners();
      return series;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<TvDetails> getseriesById({required int id}) async {
    try {
      var response = await http.get(Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.TV_DETAILS}${id}${ApiConstant.API_KEY}"));
      print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw data["message"];
      }
      seriesById=TvDetails.fromJson(data);
      notifyListeners();
      log(seriesById.id.toString());
      return seriesById;
    } catch (error) {
      log("an error occured while getting movie info $error");
      throw error.toString();
    }
  }
  Future<List<CastMemberSeries>> getcast(int tvId) async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.TV_DETAILS}${tvId}${ApiConstant.CREDITS_CREW}${ApiConstant.API_KEY}"));
    print('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List castTempList = [];
    for (var v in data["cast"]) {
      castTempList.add(v);
      log(v.toString());
      print(data["cast"].length.toString());
    }
    if (response.statusCode == 200) {
      cast=CastMemberSeries.castFromSnapshot(castTempList);

      notifyListeners();
      return cast;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

