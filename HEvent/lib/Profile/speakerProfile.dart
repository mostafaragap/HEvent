import 'package:HEvent/Profile/profile.dart';
import 'package:HEvent/Profile/speakerSetting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_ui_challenges/core/presentation/res/assets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class speakerProfile extends StatefulWidget {
  @override
  _speakerProfileState createState() => _speakerProfileState();
}

class _speakerProfileState extends State<speakerProfile> {
  FirebaseUser user;
  Future<void> getUser() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      print(user.uid);
    });
  } //////////////////////////////////////////////////////////////get user id

  SharedPreferences pref;
  var ID = "non";
  bool speakervalue;
  loadData() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      ID = pref.getString('ID');
      speakervalue = pref.getBool('speakervalue');
    });
    return ID;
  }

  @override
  void initState() {
    super.initState();

    f();
    getUser();
    loadData();
  }

  // String url="";
  @override
  // void initState() {
  //   super.initState();
  //     test();
  //       setState(() {

  //       });
  // }

  // test(){
  //   var saeed;
  //   return  StreamBuilder(
  //                 stream: Firestore.instance
  //                     .collection('user')
  //                     .document('6OLZy3ktjVPtQ3zvSNNKSv3njJq1')
  //                     .snapshots(),
  //                 builder: (context, snapshot) {
  //                   if (!snapshot.hasData) return Text('loading Data ...Please Wait');
  //                   setState(() {
  //                   url =  snapshot.data['facebookUrl'];
  //                         print(url);

  //                   });

  //                 }
  //   );
  // }

  static final String path = "lib/src/pages/profile/profile4.dart";
  bool activeSpeaker = true;
///////////////////////////////////////

  ////////////////////////////////////////////////////////////////////////////favorite
  bool fav;

  var my_color_variable;
  String id, duID;

//   f() async {

//     final String _collection = 'user';
// final Firestore _fireStore = Firestore.instance;

// getData() async {
//   return await _fireStore.collection(_collection).getDocuments();
// }

// getData().then((val){
//   print(val.documents.length);
//   print(val.documents[0]);
//     if(val.documents.length > 0){
//       setState(() {
//               currentvalue=val.documents[0].data['activeSpeaker'];
//       });
//       print(val.documents[0].data['activeSpeaker']);
//     }
//     else{
//         print("Not Found");
//     }
// });
  bool currentvalue;
  f() async {
    var data = await Firestore.instance.collection('user').document(ID).get();

    if (data['activeSpeaker'].exists) {
      setState(() {
        //TSM3 F SAF7A KOLHA W INISTATE AWL HAGA BTRN
        //  my_color_variable = Colors.red;
        currentvalue = data['activeSpeaker'];
      });
      print(data['activeSpeaker']);
      print("///////////////////////////////////");
    } else {
      setState(() {
        //  my_color_variable = Colors.white;
        currentvalue = false;
      });
    }

//  StreamBuilder(
//           stream: Firestore.instance
//               .collection('user')
//               .document('9L9FjF7TbnVGUt38AYeF8FrIm8g1')
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) return Text('loading Data ...Please Wait');

//             print(snapshot.data['activeSpeaker']);
//           }
// );
  }
  ////////////////////////////////////////////////////////////////////////////////////////

  speakerActivate(var t) {
    Firestore.instance.collection('user').document(user.uid).updateData({
      ///////user.uid
      'activeSpeaker': t, //activeSpeaker
    });
    Toast.show(
      "active speaker is $t",
      context,
    ); //activeSpeaker
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Speaker Profile"),
          leading: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                Navigator.pushReplacement(
                    context, //////////////////////////// navigation without go back
                    new MaterialPageRoute(builder: (context) {
                  return new ProfileScreen();
                }));
                //                 Navigator.of(context).push(
                // new MaterialPageRoute( builder: (context){
                //   return new ProfileScreen();
                //    }
                //    )
                //    );
              }),
          backgroundColor: Colors.blue,
          elevation: 0.0,
          centerTitle: true,
          // actions: <Widget>[
          //   // Switch(
          //   //    value: true,
          //   //   onChanged: (bool v) {
          //   //     setState(() {
          //   //       // this.activeSpeaker = currentvalue;
          //   //       if (currentvalue == true) {
          //   //         setState(() {
          //   //           currentvalue = false;
          //   //         });
          //   //       } else {
          //   //         setState(() {
          //   //           currentvalue = true;
          //   //         });
          //   //       }
          //   //       print(currentvalue);
          //   //       speakerActivate(currentvalue);
          //   //       //  Firestore.instance.runTransaction((transaction) async {await transaction.update( documentReference, value); };
          //   //       //  return activeSpeaker;
          //   //     });
          //   //   },
          //   //   activeColor: Colors.white,
          //   //   activeTrackColor: Colors.white,
          //   // ),
          // ],
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) {
                  return new speakerSetting();
                }));
              },
            )
          ],
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('user')
                .document(ID) //ID
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('loading Data ...Please Wait');

              return new SingleChildScrollView(
                padding: EdgeInsets.only(top: 7.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // FlatButton(
                    //   // icon: Icon(
                    //   //   Icons.favorite,
                    //   // ),

                    //   child: Text(
                    //       "please Click to Activate or Deactivate, Your Active Speaker is $currentvalue"),
                    //   color: Colors.red,
                    //   onPressed: () {
                    //     setState(() {
                    //       // this.activeSpeaker = currentvalue;
                    //       if (currentvalue == true) {
                    //         setState(() {
                    //           currentvalue = false;
                    //         });
                    //       } else {
                    //         setState(() {
                    //           currentvalue = true;
                    //         });
                    //       }
                    //       print(currentvalue);
                    //       speakerActivate(currentvalue);
                    //       //  Firestore.instance.runTransaction((transaction) async {await transaction.update( documentReference, value); };
                    //       //  return activeSpeaker;
                    //     });
                    //   },
                    // ),
                    // Switch(
                    //   value: true,
                    //   onChanged: (bool v) {
                    //     setState(() {
                    //       // this.activeSpeaker = currentvalue;
                    //       if (currentvalue == true) {
                    //         setState(() {
                    //           currentvalue = false;
                    //         });
                    //       } else {
                    //         setState(() {
                    //           currentvalue = true;
                    //         });
                    //       }
                    //       print(currentvalue);
                    //       speakerActivate(currentvalue);
                    //       //  Firestore.instance.runTransaction((transaction) async {await transaction.update( documentReference, value); };
                    //       //  return activeSpeaker;
                    //     });
                    //   },
                    //   activeColor: Colors.white,
                    // ),
                    _buildHeader(
                        snapshot.data['name'],
                        snapshot.data['eventType'],
                        snapshot.data['price'],
                        snapshot.data['photo']),
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(color: Colors.grey.shade200),
                      child: Text(snapshot.data['BIO Speaker']),
                    ),
                    _buildTitle("Experience"),
                    _buildExperienceRow(
                      company: snapshot.data['experiance'],
                      position: "The num of experiance from",
                      duration: snapshot.data['numofexperiance'],
                    ),
                    _buildTitle("Education"),
                    SizedBox(height: 5.0),
                    _buildExperienceRow(
                      company: snapshot.data['education'],
                      position: snapshot.data['selectFaculty'],
                      duration: "",
                    ),
                    SizedBox(height: 20.0),
                    _buildTitle("Contact"),
                    SizedBox(height: 5.0),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 30.0),
                        Icon(
                          Icons.mail,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          snapshot.data['email'],
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 30.0),
                        Icon(
                          Icons.phone,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          snapshot.data['phone'],
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    _buildSocialsRow(snapshot.data['facebookUrl'],
                        snapshot.data['youtubeChannel']),
                    SizedBox(height: 20.0),
                  ],
                ),
              );
            }));
  }

  Row _buildSocialsRow(String facebook, youtube) {
    //                  StreamBuilder(
    //           stream: Firestore.instance
    //               .collection('user')
    //               .document('6OLZy3ktjVPtQ3zvSNNKSv3njJq1')
    //               .snapshots(),
    //           builder: (context, snapshot) {
    //             if (!snapshot.hasData) return Text('loading Data ...Please Wait');
    //          print(snapshot.data['facebookUrl']);

    //           }
    // );
    return Row(
      children: <Widget>[
        SizedBox(width: 20.0),
        IconButton(
          color: Colors.indigo,
          icon: Icon(FontAwesomeIcons.facebookF),
          onPressed: () {
            _launchURL(facebook);
          },
        ),
        SizedBox(width: 5.0),
        SizedBox(width: 5.0),
        IconButton(
          color: Colors.red,
          icon: Icon(FontAwesomeIcons.youtube),
          onPressed: () {
            _launchURL(youtube);
          },
        ),
        SizedBox(width: 10.0),
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ListTile _buildExperienceRow(
      {String company, String position, String duration}) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 20.0),
        child: Icon(
          FontAwesomeIcons.solidCircle,
          size: 12.0,
          color: Colors.black54,
        ),
      ),
      title: Text(
        company,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text("$position ($duration)"),
    );
  }

  Row _buildSkillRow(String skill, double level) {
    return Row(
      children: <Widget>[
        SizedBox(width: 16.0),
        Expanded(
            flex: 2,
            child: Text(
              skill.toUpperCase(),
              textAlign: TextAlign.right,
            )),
        SizedBox(width: 10.0),
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(
            value: level,
          ),
        ),
        SizedBox(width: 16.0),
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Row _buildHeader(name, eventtype, price, photo) {
    return Row(
      children: <Widget>[
        SizedBox(width: 20.0),
        Container(
            width: 80.0,
            height: 80.0,
            child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 35.0,
                  backgroundImage: NetworkImage(photo),
                ))),
        SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text("Track $eventtype"),
            SizedBox(height: 5.0),
            Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.dollarSign,
                  size: 12.0,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "My price is $price Pound",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
