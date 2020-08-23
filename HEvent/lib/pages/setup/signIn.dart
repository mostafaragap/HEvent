import 'package:HEvent/pages/setup/signUp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:HEvent/Pages/home.dart';
import 'package:HEvent/homePage.dart';



// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => new _LoginPageState(); 
// }

// class _LoginPageState extends State<LoginPage> {

// String _email , _password;
// final GlobalKey<FormState> _formkey =GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Form(
//         key: _formkey, //el mas2ol 3n save form
//         child: Column(
//           children: <Widget>[  //bktb t7teeh el design
//             TextFormField(
//               validator: (input){
//                 if(input.isEmpty){
//                   return 'please type an Email';
//                 }
//               } ,
//               onSaved: (input) => _email = input,
//               decoration: InputDecoration(
//                 labelText: 'Email'
//               ),
//             ),
//             TextFormField(
//               validator: (input){
//                 if(input.length<6){
//                   return 'your password needs to be least at 6 character';
//                 }
//               } ,
//               onSaved: (input) => _password = input,
//               decoration: InputDecoration(
//                 labelText: 'Password'
//               ),
//               obscureText: true,
//             ),
//             RaisedButton(
//               onPressed: signIn,
//               child: Text('Sign In'),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//     Future<void> signIn() async {
//     final formState = _formkey.currentState;
//     if(formState.validate()){
//       formState.save();
//       try{
//         AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
//         FirebaseUser user = result.user;
//         Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user))) ;
//                //Todo: Navigate to home
//       }catch(e){
//         print(e.message);
//       }
//     }
//   }
// }
import 'package:flutter/material.dart';
//import 'SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../Home.dart';
import '../../homePage.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  
String _email , _password;
final GlobalKey<FormState> _formkey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Colors.orange.shade100,
      body: SafeArea(
          child: SingleChildScrollView(/////////
        child: Container(
          padding: EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Text(
                  'Log In',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              
////////////////////////////////////////////////
      Form(
        key: _formkey, //el mas2ol 3n save form
        child: Column(
          children: <Widget>[  //bktb t7teeh el design
            TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return 'please type an Email';
                }
              } ,
              onSaved: (input) => _email = input,
              // decoration: InputDecoration(
              //   labelText: 'Email'
              // ),
               keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.check),
                      hintText: 'Your Email',
                      labelText: 'Your Email',
                      labelStyle: TextStyle(fontWeight: FontWeight.w400))
            ),
            TextFormField(
              validator: (input){
                if(input.length<6){
                  return 'your password needs to be least at 6 character';
                }
              } ,
              onSaved: (input) => _password = input,
              // decoration: InputDecoration(
              //   labelText: 'Password'
              // ),
               obscureText: true,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    //  suffixText: 'Forget',
                      hintText: 'Password',
                      labelText: 'Password',
                      labelStyle: TextStyle(fontWeight: FontWeight.w400))
            
            ),
            // RaisedButton(
            //   onPressed: /*signIn*/() {},
            //   child: Text('Sign In'),
            // )
           Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: RawMaterialButton(
                  onPressed: signIn,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Log In',
                      style: TextStyle(
                          color: Color(0xFFFD4F99), fontWeight: FontWeight.w400),
                    ),
                  ),
                  elevation: 6.0,
                  fillColor: Colors.black,
                  shape: StadiumBorder(),
                ),
              ),

          ],
        ),
      ),



              
              // TextField(//////////////////////////////////////////////////////////
              //     keyboardType: TextInputType.emailAddress,
              //     style: TextStyle(fontWeight: FontWeight.w500),
              //     decoration: InputDecoration(
              //         suffixIcon: Icon(Icons.check),
              //         hintText: 'Your Email',
              //         labelText: 'Your Email',
              //         labelStyle: TextStyle(fontWeight: FontWeight.w400))),
              // SizedBox(
              //   height: 10.0,
              // ),
              // TextField(
              //     obscureText: true,
              //     style: TextStyle(fontWeight: FontWeight.w500),
              //     decoration: InputDecoration(
              //         suffixText: 'Forget',
              //         hintText: 'Password',
              //         labelText: 'Password',
              //         labelStyle: TextStyle(fontWeight: FontWeight.w400))),
              // Padding(
              //   padding: const EdgeInsets.only(top: 30.0),
              //   child: RawMaterialButton(
              //     onPressed: () {},
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 12.0),
              //       child: Text(
              //         'Log In',
              //         style: TextStyle(
              //             color: Colors.white, fontWeight: FontWeight.w400),
              //       ),
              //     ),
              //     elevation: 6.0,
              //     fillColor: Colors.black,
              //     shape: StadiumBorder(),
              //   ),
              // ),


              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Or sign up with Social account',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.0),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 Container(
                      width: 140.0,
                      child: OutlineButton(
                        splashColor: Colors.black,
                        onPressed: () {
                          _googleSignIn();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Icon(Icons.android),
                            Icon(
                                MdiIcons.google,
                                color: Colors.black,
                                size: 13.0,
                              ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Google')
                          ],
                        ),
                        shape: StadiumBorder(),
                        borderSide: BorderSide(width: 1.5),
                      ),
                    ),
                  // Container(
                  //   width: 140,
                  //   child: OutlineButton(
                  //     splashColor: Colors.black,
                  //     onPressed: () {
                  //       signInWithGoogle();
                  //     },
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: <Widget>[
                  //         Icon(Icons.android),
                  //         SizedBox(
                  //           width: 5.0,
                  //         ),
                  //         Text('Twittter')
                  //       ],
                  //     ),
                  //     shape: StadiumBorder(),
                  //     borderSide: BorderSide(width: 1.5),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
  FirebaseUser user;
  Future<void> getUser() async {
     SharedPreferences pref;
      pref = await SharedPreferences.getInstance();
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      pref.clear();
       pref.setString('ID',user.uid);
      print(user.uid);
    });
  } //////////////////////////////////////////////////////////////get user id

  

      Future<void> signIn() async {
      
    final formState = _formkey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        if(result != null){
          print('welcom');
          getUser();
        }else{
          print('user not found');
                 }   
        print(user.uid);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FancyBottomBarPage(/*user: user*/))) ;
        // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage()));
               //Todo: Navigate to home
      }catch(e){
        print(e.message);
        Toast.show("ensure your email or password", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
 
      }
    }
  }

    // Sign in with Google.
  Future<FirebaseUser> _googleSignIn() async {

    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Note: user.providerData[0].photoUrl == googleUser.photoUrl.
    final user =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;
   // kFirebaseAnalytics.logLogin();
    //setState(() => this._user = user);
    return user;
  }
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);
  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  return 'signInWithGoogle succeeded: $user';
}
void signOutGoogle() async{
  await googleSignIn.signOut();
  print("User Sign Out");
}
}
