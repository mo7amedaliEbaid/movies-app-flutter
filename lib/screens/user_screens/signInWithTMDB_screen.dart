import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/customized/myappBar.dart';
import 'package:my_movies_app_flutter/providers/authwith_TMDB_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/Global_consts.dart';

class SignInWithTMDBScreen extends StatefulWidget {
  const SignInWithTMDBScreen({Key? key}) : super(key: key);

  @override
  State<SignInWithTMDBScreen> createState() => _SignInWithTMDBScreenState();
}

class _SignInWithTMDBScreenState extends State<SignInWithTMDBScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(27),
                  ),
                  width:size.width*.85 ,
                  height: size.height*.08,
                  child: Center(
                    child: Text('Please Login into your TMDB Account',
                        style: blackbold, textAlign: TextAlign.center),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _usernameController,
                  style: bluebold,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      iconColor: Colors.grey,
                      //prefixIcon: Icon(Icons.nest_cam_wired_stand),
                      hintStyle: bluebold,
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: 'UserName'),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField( controller: _passwordController,
                  style: bluebold,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                   hintStyle: bluebold,
                    iconColor: Colors.grey,
                    hintText: 'Password',
                  ),
                ),
                Consumer<AuthWithTMDBProvider>(builder:(context,data,_){
                 return Padding(
                   padding: const EdgeInsets.all(28.0),
                   child: InkWell(
                      onTap: (){
                        data.loginWithTMDB(_usernameController.text.toString(),
                            _passwordController.text.toString(), context);
                      },
                      child: Container(
                        height: 40,
                        width: size.width*.5,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text("Login",style: blackbold,),
                        ),
                      ),
                    ),
                 );
                })

              ]),
        ),
      ),
    );
  }
}
