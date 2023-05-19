import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/constants/api_constance.dart';
import 'package:http/http.dart'as http;

import '../models/celeb_model.dart';
import '../models/celebrityProfile_model.dart';
class CelebssProvider extends ChangeNotifier{
  List<Celeb> celebrities = [];
   CelebrityProfile celebProfileById=CelebrityProfile(birthday: DateTime(1970));
  Future<List<Celeb>> getallcelebs(String trendigPer) async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.TRENDING_PERSONS}${trendigPer}${ApiConstant.API_KEY}"));
    print('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List clbsTempList = [];
    for (var v in data["results"]) {
      clbsTempList.add(v);
      log(v.toString());
      print(data["results"].length.toString());
    }
    if (response.statusCode == 200) {
      celebrities=Celeb.celebsFromSnapshot(clbsTempList);

      notifyListeners();
      return celebrities;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<CelebrityProfile> getCelebById({required int id}) async {
    try {
      var response = await http.get(Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.PERSONS_DETAILS}${id}${ApiConstant.API_KEY}"));
      print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw data["message"];
      }
      celebProfileById=CelebrityProfile.fromJson(data);
      notifyListeners();
      log(celebProfileById.id.toString());
      return celebProfileById;
    } catch (error) {
      log("an error occured while getting celeb info $error");
      throw error.toString();
    }
  }
}

