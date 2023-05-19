import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/providers/authWithGoogle_provider.dart';
import 'package:my_movies_app_flutter/providers/authwith_TMDB_provider.dart';
import 'package:my_movies_app_flutter/screens/user_screens/signInWithTMDB_screen.dart';
import 'package:provider/provider.dart';

import '../constants/Global_consts.dart';
import '../screens/user_screens/googleuser_screen.dart';

class DismissibleDialog<T> extends PopupRoute<T> {


  @override
  Color? get barrierColor => Colors.black.withAlpha(0x60);

  // This allows the popup to be dismissed by tapping the scrim or by pressing
  // the escape key on the keyboard.
  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Successfully Registered!';

  @override
  Duration get transitionDuration => const Duration(seconds: 2);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Size size=MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          top: size.height*.15,
          child: Dialog(
            child: Container(
            height:size.height * .3,
             width:size.width * .8,
             padding:  EdgeInsets.all(10.0),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(5),
               color: Colors.white70,
             ),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 Consumer<AuthwithGoogleProvider>(builder: (context,data,_){
                   return Padding(
                     padding: const EdgeInsets.fromLTRB(0,10.0,0,10),
                     child: InkWell(
                       onTap:()async{
                         User? user =
                         await data.signInWithGoogle(context: context);
                         if (user != null) {
                           Navigator.of(context).pushReplacement(
                             MaterialPageRoute(
                                 builder: (context) => GoogleUserScreen(user: user,)
                             ),
                           );
                         }
                       },
                       child: Container(
                         height: size.height*.065,
                         width: size.width*.6,
                         decoration: BoxDecoration(
                             color:  Colors.white,
                             border: Border.all(color: Colors.amber,width: 3),
                             borderRadius: BorderRadius.circular(10)
                         ),

                         child: Center(child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Container(
                               height: size.height*.08,
                               width: size.width*.08,
                               decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   image: DecorationImage(image: AssetImage("assets/google.png"))
                               ),
                             ),
                             Text("Sign in with Google",style: blackbold,),
                           ],
                         )),
                       ),
                     ),
                   );
                 }),

                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Container(
                         color: Colors.black,
                         height: 2,
                         width: size.width * 0.2,
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                         child: Text(
                           'or',
                           style: blackbold,
                         ),
                       ),
                       Container(
                         color: Colors.black,
                         height: 2,
                         width: size.width * 0.2,
                       ),
                     ],
                   ),
                 ),

                  Consumer<AuthWithTMDBProvider>(builder: (context,data,_){
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0,10.0,0,10),
                    child: InkWell(
                      onTap:(){
                        // data.getToken();
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignInWithTMDBScreen()));
                      },
                      child: Container(
                        height: size.height*.065,
                        width: size.width*.6,
                        decoration: BoxDecoration(
                            color:  Colors.white,
                            border: Border.all(color: Colors.amber,width: 3),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Stack(
                              children: [
                                Text(
                                  "TMDB",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.amber,
                                  ),
                                ),
                                Text(
                                  'TMDB',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.amber,
                                  ),
                                ),
                              ],
                            ),
                            Text("Sign in with TMDB",style: blackbold,),
                          ],
                        ),
                        ),
                      ),
                    ),
                  );
                  }),
               ],
             ),
             ),

          ),
        ),
      ],
    );
  }
}