import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/screens/feed_screen.dart';
import 'package:mobile_project/screens/home_screen.dart';
import 'package:mobile_project/screens/login_screen.dart';
import 'package:mobile_project/screens/signup_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget _getScreenId(){
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        //  if(snapshot.hasData){
        //   return FeedScreen();
        // }else{
        //   return LoginScreen();
        // }
        if(snapshot.hasData){
          return HomeScreen(userId: snapshot.data.uid);
        }else{
          return LoginScreen();
        }
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tubes Mobile',
      debugShowCheckedModeBanner: false,
      home: _getScreenId(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        FeedScreen.id: (context) => FeedScreen(),
      },
    );
  }
}