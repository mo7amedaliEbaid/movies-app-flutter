import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/models/itemonUserlists_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_constance.dart';
import '../models/account_model.dart';
import 'package:http/http.dart'as http;
class UserAccountProvider extends ChangeNotifier{
  AcountModel acountModel=AcountModel();
  List<ItemOnUserlistsModel> moviesWatchlist=[];
  List<ItemOnUserlistsModel> moviesFAVlist=[];
  List<ItemOnUserlistsModel> seriesFAVlist=[];
  List<ItemOnUserlistsModel> seriesWatchlist=[];
  Future<AcountModel> getAccountId() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    var session_id = prefs.getString('session_id');
    try {
      var response = await http.get(Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.GET_ACCOUNT}${ApiConstant.API_KEY}${ApiConstant.SESSION_ID}${session_id}"));
      print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw data["message"];
      }
      acountModel=AcountModel.fromJson(data);
      notifyListeners();
      log(acountModel.id.toString());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('account_id', acountModel.id.toString());
      return acountModel;
    } catch (error) {
      log("an error occured while getting token $error");
      throw error.toString();
    }
  }
  void addTomoviesWatchlist(int movieid) async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    var usersessionId = prefs.getString('session_id');
    var accountId = prefs.getString('account_id');
    //log(accountId!);
    //log(usersessionId!);
    try {
      var response =
      (await http.post(Uri.parse('${ApiConstant.BASE_URL}${ApiConstant.GET_ACCOUNT}/${accountId}${ApiConstant.WATCHLIST}${ApiConstant.API_KEY}${ApiConstant.SESSION_ID}${usersessionId}'), body: {
        'media_type': "movie",
        'media_id': "${movieid}",
        "watchlist": "true",
      })) ;
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());
        print(data['status_message']);
        print('movie added to watchlist successfully');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
  void addTomoviesFAVlist(int movieid) async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    var usersessionId = prefs.getString('session_id');
    var accountId = prefs.getString('account_id');
    //log(accountId!);
    //log(usersessionId!);
    try {
      var response =
      (await http.post(Uri.parse('${ApiConstant.BASE_URL}${ApiConstant.GET_ACCOUNT}/${accountId}${ApiConstant.FAVOURITE}${ApiConstant.API_KEY}${ApiConstant.SESSION_ID}${usersessionId}'), body: {
        'media_type': "movie",
        'media_id': "${movieid}",
        "favorite": "true",
      })) ;
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());
        print(data['status_message']);
        print('movie added to favs successfully');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<List<ItemOnUserlistsModel>> getwatchlistMovies() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    var usersessionId = prefs.getString('session_id');
    var accountId = prefs.getString('account_id');
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.GET_ACCOUNT}/${accountId}${ApiConstant.WATCHLIST}${ApiConstant.WATCHLIST_MOVIES}${ApiConstant.API_KEY}${ApiConstant.SESSION_ID}${usersessionId}"));
    print('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List wmvsTempList = [];
    for (var v in data["results"]) {
      wmvsTempList.add(v);
      log(v.toString());
      print(data["results"].length.toString());
    }
    if (response.statusCode == 200) {
      moviesWatchlist=ItemOnUserlistsModel.ItemsFromSnapshot(wmvsTempList);
      notifyListeners();
      return moviesWatchlist;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<ItemOnUserlistsModel>> getFAVlistMovies() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    var usersessionId = prefs.getString('session_id');
    var accountId = prefs.getString('account_id');
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.GET_ACCOUNT}/${accountId}${ApiConstant.FAVOURITE}${ApiConstant.WATCHLIST_MOVIES}${ApiConstant.API_KEY}${ApiConstant.SESSION_ID}${usersessionId}"));
    print('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List fmvsTempList = [];
    for (var v in data["results"]) {
      fmvsTempList.add(v);
      log(v.toString());
      print(data["results"].length.toString());
    }
    if (response.statusCode == 200) {
      moviesFAVlist=ItemOnUserlistsModel.ItemsFromSnapshot(fmvsTempList);
      notifyListeners();
      return moviesFAVlist;
    } else {
      throw Exception('Failed to load album');
    }
  }
  void addToseriesFAVlist(int serieid) async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    var usersessionId = prefs.getString('session_id');
    var accountId = prefs.getString('account_id');
    //log(accountId!);
    //log(usersessionId!);
    try {
      var response =
      (await http.post(Uri.parse('${ApiConstant.BASE_URL}${ApiConstant.GET_ACCOUNT}/${accountId}${ApiConstant.FAVOURITE}${ApiConstant.API_KEY}${ApiConstant.SESSION_ID}${usersessionId}'), body: {
        'media_type': "tv",
        'media_id': "${serieid}",
        "favorite": "true",
      })) ;
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());
        print(data['status_message']);
        print('series added to favs successfully');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<List<ItemOnUserlistsModel>> getFAVlistSeries() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    var usersessionId = prefs.getString('session_id');
    var accountId = prefs.getString('account_id');
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.GET_ACCOUNT}/${accountId}${ApiConstant.FAVOURIT_TV}${ApiConstant.API_KEY}${ApiConstant.SESSION_ID}${usersessionId}"));
    print('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List fmvsTempList = [];
    for (var v in data["results"]) {
      fmvsTempList.add(v);
      log(v.toString());
      print(data["results"].length.toString());
    }
    if (response.statusCode == 200) {
      seriesFAVlist=ItemOnUserlistsModel.ItemsFromSnapshot(fmvsTempList);
      notifyListeners();
      return seriesFAVlist;
    } else {
      throw Exception('Failed to load album');
    }
  }
  void addToseriesWatchlist(int serieId) async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    var usersessionId = prefs.getString('session_id');
    var accountId = prefs.getString('account_id');
    //log(accountId!);
    //log(usersessionId!);
    try {
      var response =
      (await http.post(Uri.parse('${ApiConstant.BASE_URL}${ApiConstant.GET_ACCOUNT}/${accountId}${ApiConstant.WATCHLIST}${ApiConstant.API_KEY}${ApiConstant.SESSION_ID}${usersessionId}'), body: {
        'media_type': "tv",
        'media_id': "${serieId}",
        "watchlist": "true",
      })) ;
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());
        print(data['status_message']);
        print('serie added to watchlist successfully');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<List<ItemOnUserlistsModel>> getwatchlistSeries() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    var usersessionId = prefs.getString('session_id');
    var accountId = prefs.getString('account_id');
    var response = await http.get(Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.GET_ACCOUNT}/${accountId}${ApiConstant.WATCHLIST_TV}${ApiConstant.API_KEY}${ApiConstant.SESSION_ID}${usersessionId}"));
    print('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List wmvsTempList = [];
    for (var v in data["results"]) {
      wmvsTempList.add(v);
      log(v.toString());
      print(data["results"].length.toString());
    }
    if (response.statusCode == 200) {
      seriesWatchlist=ItemOnUserlistsModel.ItemsFromSnapshot(wmvsTempList);
      notifyListeners();
      return seriesWatchlist;
    } else {
      throw Exception('Failed to load album');
    }
  }
}