 import 'dart:async';
 import 'package:splashscreen/splashscreen.dart';
//import 'package:tic_tac_toe/HomePage.dart';

import 'package:HEvent/pages/setup/signIn.dart';
import 'package:flutter/material.dart';
// import 'package:ecproject/Pages/Setup/signIn.dart';
// import 'package:ecproject/Pages/Setup/signUp.dart';

// class welcomePage extends StatefulWidget {
//   @override
//   _welcomePageState createState() => _welcomePageState();
// }

// class _welcomePageState extends State<welcomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('el3adawy market'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           RaisedButton(
//               onPressed: navigateToSignIn,
//               child: Text('Sign in'),
//             ),
//             RaisedButton(
//                   onPressed: navigateToSignUp,
//                   child: Text('Sign up'),
//             )

//         ],
//       )
      
//     );
//   }


// void navigateToSignIn(){
//   Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true )) ;
// }
// void navigateToSignUp(){
//   Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp() )) ;


// }

// }

///////////////////////////////
///
// class welcomePage extends StatefulWidget {
//   @override
//   _welcomePageState createState() => _welcomePageState();
// }

// class _welcomePageState extends State<welcomePage> {
 
//     @override
//   void initState() {
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage('assets/AI.jpg'),
//             fit: BoxFit.cover
//         ) ,
//       ),
//       child: Center(
//         child: CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
//         ),
//       ),
//     );
//   }
//    @override
// void initState() {
//   super.initState();

//   loadData();
// }

// Future<Timer> loadData() async {
//   return new Timer(Duration(seconds: 3), onDoneLoading);
// }
// // onDoneLoading() async {
// //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
// // }

// onDoneLoading() async {
//   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
// }
  
  
// }

//////////////////////////

class welcomePage extends StatefulWidget {
  @override
  _welcomePageState createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 6,
      navigateAfterSeconds: new LoginPage(),
      // title: new Text('HEvent',
      // style: new TextStyle(
      //   fontWeight: FontWeight.bold,
      //   fontSize: 26.0,
      //   color: Colors.purple,
      //  ),
      // ),
      image: Image.asset("assets/logo2.png"),
      backgroundColor: Colors.white,
      photoSize: 180.0,
    );
  }
}



