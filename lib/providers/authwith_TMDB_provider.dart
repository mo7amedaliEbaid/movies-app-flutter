import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:my_movies_app_flutter/models/userToken_model.dart';
import '../constants/api_constance.dart';
import '../screens/user_screens/TMDBUser_Screen.dart';
class AuthWithTMDBProvider extends ChangeNotifier{
  RequestToken requestTokeninstance=RequestToken();
  void getToken() async {
    try {
      var response = await http.get(Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.GET_TOKEN}${ApiConstant.API_KEY}"));
      print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw data["message"];
      }
      requestTokeninstance=RequestToken.fromJson(data);
      notifyListeners();
      log(requestTokeninstance.requestToken.toString());
      SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('request_token', requestTokeninstance.requestToken!);
    } catch (error) {
      log("an error occured while getting token $error");
      throw error.toString();
    }
  }
  void loginWithTMDB(String usename,String password,BuildContext context) async {
   SharedPreferences prefs =
    await SharedPreferences.getInstance();
   var userrequestToken = prefs.getString('request_token');
      log(usename);
      log(password);
      log(userrequestToken!);
    try {
      var response =
      (await http.post(Uri.parse('${ApiConstant.BASE_URL}${ApiConstant.LOGin_WITH_TMDB}${ApiConstant.API_KEY}'), body: {
        'username': "$usename",
        'password': "$password",
        'request_token': "${userrequestToken}",
      })) ;
      if (response.statusCode == 200) {
        createSession();
        var data = jsonDecode(response.body.toString());
        print(data['request_token']);
        print('Login successfully');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('pass', password);
       // prefs.setString('username', usename);
       // print(usename);
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TMDBUserScreen()));
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
  void createSession() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    var userrequestToken = prefs.getString('request_token');
    log(userrequestToken!);
    try {
      var response =
      (await http.post(Uri.parse('${ApiConstant.BASE_URL}${ApiConstant.GET_SESSION}${ApiConstant.API_KEY}'), body: {
        'request_token': "${userrequestToken}",
      })) ;
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['session_id']);
        print('session created successfully');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('session_id', data['session_id']);
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}