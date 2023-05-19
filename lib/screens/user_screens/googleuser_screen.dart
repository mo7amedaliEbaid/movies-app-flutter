import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_movies_app_flutter/setUp.dart';
import 'package:provider/provider.dart';

import '../../constants/Global_consts.dart';
import '../../customized/myappBar.dart';
import '../../providers/authWithGoogle_provider.dart';

class GoogleUserScreen extends StatelessWidget {
  GoogleUserScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _user.photoURL != null
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: size.height * .1,
                      child: ClipOval(
                        child: Image.network(
                          _user.photoURL!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  )
                : ClipOval(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.person,
                        size: 50,
                      ),
                    ),
                  ),
            Consumer<AuthwithGoogleProvider>(builder: (context, data, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(_user.displayName!, style: normalBoldWhite),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(size.width * .25, 0, 10, 10),
                        child: InkWell(
                          onTap: () async {
                            await data.signOut(context: context);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => SetUp()));
                          },
                          child: Container(
                              height: size.height * .05,
                              width: size.width * .2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.amber,
                              ),
                              child: Center(
                                child: Text(
                                  "Sign Out",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Text('${_user.email!} ', style: normalWhite),
                ],
              );
            })

            //Didn't develop the rest of this screen yet.
            //Didn't develop the rest of this screen yet.
            //Didn't develop the rest of this screen yet.
          ],
        ),
      ]),
    );
  }
}
