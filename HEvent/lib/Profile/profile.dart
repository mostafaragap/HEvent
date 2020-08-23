import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HEvent/Profile/IntroPage.dart';
import 'package:HEvent/Profile/dashboard/createdEvents.dart';
import 'package:HEvent/Profile/editProfile.dart';
import 'package:HEvent/createEvent/placeInfo.dart';
import 'package:HEvent/createEvent/placeList.dart';
import 'package:HEvent/homeExplore/moreExplore.dart';
import 'package:HEvent/scaning/subScanpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'dashboard/joindEventsInfo.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  @override
  String x = "";
  String y = "";

  // FirebaseUser user;
  // Future<void> getUser() async {
  //   FirebaseUser userData = await FirebaseAuth.instance.currentUser();
  //   setState(() {
  //     user = userData;
  //     print(user.uid);
  //   });
  // } //////////////////////////////////////////////////////////////get user id
  SharedPreferences pref;
  var ID = "non";
  loadData() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      ID = pref.getString('ID');
    });
    return ID;
  }

  @override
  void initState() {
    super.initState();

    // getUser();
    loadData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black.withOpacity(0.0),
      //   elevation: 0,
      //   title: Text(
      //     'danys_fire',
      //     style: TextStyle(fontSize: 20.0,color: Colors.blue),

      //   ),
      //   bottom: PreferredSize(
      //     child: Container(
      //       height: 1.0,
      //       color: Colors.black,
      //     ),
      //     preferredSize: Size.fromHeight(1.0),
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(MdiIcons.menu),
      //       color: Colors.blue,
      //       iconSize: 32.0,
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(MdiIcons.send),
      //       color: Colors.blue,
      //       iconSize: 32.0,
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(Icons.more_horiz),
      //       color: Colors.blue,
      //       iconSize: 32.0,
      //     ),
      //   ],
      // ),
      appBar: AppBar(
        title: Text("My Profile"),
        // leading: IconButton(
        //     icon: Icon(Icons.cancel),
        //     onPressed: () {
        //       Navigator.pushReplacement(
        //           context, //////////////////////////// navigation without go back
        //           new MaterialPageRoute(builder: (context) {
        //         return new ProfileScreen();
        //       }));
        //       //                 Navigator.of(context).push(
        //       // new MaterialPageRoute( builder: (context){
        //       //   return new ProfileScreen();
        //       //    }
        //       //    )
        //       //    );
        //     }),
        backgroundColor: Color(0xFF353535),
        elevation: 0.0,
        centerTitle: true,
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(
        //       Icons.done,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //     //  _editProfile();
        //     },
        //   )
        // ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('user').document(ID).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: Text('loading Data ...Please Wait'));
          x = snapshot.data['phone'];
          y = snapshot.data['address'];

          return new SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: Row(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            width: 110.0,
                            height: 110.0,
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Color(0xff476cfb),
                              child: ClipOval(
                                child: new SizedBox(
                                  width: 110.0,
                                  height: 110.0,
                                  child:
                                      // (image != null)
                                      //   ? Image.file(
                                      //     image,
                                      //   fit: BoxFit.fill,
                                      //ELSE
                                      // )
                                      Image.network(
                                    snapshot.data['photo'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Positioned(
                          //   bottom: 0.0,
                          //   right: 0.0,
                          //   width: 30.0,
                          //   height: 30.0,
                          //  // child:
                          //   // Material(
                          //   //   elevation: 5.0,
                          //   //   borderRadius: BorderRadius.circular(100.0),
                          //   //   //color: Colors.blueAccent,
                          //   //   // child: IconButton(
                          //   //   //   onPressed: () {},
                          //   //   //   icon: Icon(
                          //   //   //     MdiIcons.plus,
                          //   //   //     color: Colors.black,
                          //   //   //     size: 13.0,
                          //   //   //   ),
                          //   //   // ),
                          //   // ),
                          // ),
                        ],
                      ),
                      SizedBox(width: 25.0),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[],
                                ),
                                Column(
                                  children: <Widget>[],
                                ),
                                Column(
                                  children: <Widget>[],
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Material(
                                    elevation: 1,
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            new MaterialPageRoute(
                                                builder: (context) {
                                          return new editProfile(
                                              photo: snapshot.data['photo']);
                                        }));
                                      },
                                      child: Text(
                                        'Edit Profile',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       Text(
                //         snapshot.data['name'],
                //         style: TextStyle(
                //             fontSize: 16.0, fontWeight: FontWeight.bold),
                //       ),
                //       SizedBox(width: 8.0),
                //       Text(
                //         '|',
                //         style: TextStyle(fontSize: 16.0, color: Colors.grey),
                //       ),
                //       SizedBox(width: 8.0),
                //       Text(
                //         snapshot.data['email'],
                //         textAlign: TextAlign.left,
                //         style: TextStyle(fontSize: 16.0, color: Colors.black),
                //       )
                //     ],
                //   ),
                // ),
                /////////////////////////
                Container(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          snapshot.data['name'],
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '|',
                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            snapshot.data['email'],
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          )),
                    ],
                  ),
                ),
                ////////////////////////////
                Padding(
                  padding: EdgeInsets.only(
                      top: 15.0, right: 25.0, left: 25.0, bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            // margin: const EdgeInsets.all(16.0),
                            // padding: const EdgeInsets.all(16.0),
                            decoration:
                                BoxDecoration(color: Colors.grey.shade200),
                            child: (snapshot.data['BIO Profile'] != null)
                                ? Text(
                                    snapshot.data['BIO Profile'],
                                    textAlign: TextAlign.left,
                                  )
                                : Text(
                                    'Please go to Edit Profile to add a BIO',
                                    textAlign: TextAlign.left,
                                  ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Phone is $x',
                            style: TextStyle(fontSize: 16.0),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Address is $y',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  // margin: const EdgeInsets.all(8.0),
                  //padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                        "Would you like to be a partner with us in organizing Events?",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      // padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () {
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return new IntroPage();
                        }));
                      },
                      child: Text(
                        "Show More",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 15.0),
                //   child: Divider(),
                // ),
                DefaultTabController(
                  length: 4, //3
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: BorderDirectional(
                                bottom: BorderSide(color: Colors.grey[800]))),
                        child: SafeArea(
                          child: Column(
                            children: <Widget>[
                              TabBar(
                                indicatorColor: Colors.red,
                                labelColor: Colors.blue,
                                unselectedLabelColor: Colors.brown,
                                tabs: <Widget>[
                                  Tab(
                                    text: "My Events",
                                  ),
                                  Tab(text: "Event Created"),
                                  Tab(text: "Attended Events"),
                                  Tab(text: "scanning Events"), //////
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: TabBarView(
                          children: <Widget>[
                            /////tab1
                            joindEvents(),
                            // Tab2
                            myEvents(),
                            // Tab3////////////////////////////////////////////////////////////////////////////////////////////////
                            //  event(),
                            AttendEvents(),
                            //Tap4///////////////////////////////
                            scanningEvents(),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

////////////////////////////////////////////////////////////////////myEvents
  ///
  ///

  Container _buildThumbnail(String img) {
    return Container(
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        borderRadius:
            //  imageRight
            //     ? BorderRadius.only(
            //         topRight: Radius.circular(4.0),
            //         bottomRight: Radius.circular(4.0),
            //       )
            //     :
            BorderRadius.only(
          topLeft: Radius.circular(4.0),
          bottomLeft: Radius.circular(4.0),
        ),
        image: DecorationImage(
          image: NetworkImage(img),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  ///
  myEvents() {
    return StreamBuilder<QuerySnapshot>(
      stream: // name != "" && name != null
          //? Firestore.instance
          //  .collection('Events')
          //.where("serchIndex", arrayContains: name)
          //.snapshots()
          Firestore.instance
              .collection("Events")
              .where("owner", isEqualTo: ID)
              .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        if (!snapshot.hasData)
          return Center(
            child: Text('loading aata ...Please Wait'),
          );
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (context) {
                        return new createdEvents(
                            photo: document["image"],
                            title: document["name"],
                            address: document["address"],
                            desciption: document["decription"],
                            capacity: document["capacity"].toString(),
                            place: document["place"],
                            date: document["date"]
                            //,status: document["status"],
                            );
                      }));
                    },
                    child: Card(
                      //elevation: elevation,

                      //   borderRadius: BorderRadius.circular(4.0),

                      child: Row(
                        children: <Widget>[
                          _buildThumbnail(document["image"]),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          document["name"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0),
                                          softWrap: true,
                                        ),
                                      ),
                                      //     _buildTag(context)
                                    ],
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: document["decription"],
                                        ),
                                      ],
                                    ),
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                  const SizedBox(height: 5.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                    /////////////////////
                    );
              }).toList(),
            );
        }
      },
    );
  }

  ///.///////////////////////////////////////////////////////////////myEvents
  /////////////

////////////////////////////////////////////////////////////////////joindEvents
  ///
  ///

  joindEvents() {
    return StreamBuilder<QuerySnapshot>(
      stream: // name != "" && name != null
          //? Firestore.instance
          //  .collection('Events')
          //.where("serchIndex", arrayContains: name)
          //.snapshots()
          Firestore.instance
              .collection("join_event")
              .where("user", isEqualTo: ID)
              .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        if (!snapshot.hasData)
          return Center(
            child: Text('loading aata ...Please Wait'),
          );
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (context) {
                        return new joindEventsInfo(
                          photo: document["photo"], title: document["title"],
                          address: document["address"],
                          desciption: document["description"],
                          capacity: document["capacity"],
                          place: document["place"],
                          date: document["date"],
                          //status: document["status"],
                        );
                      }));
                    },
                    child: Card(
                      //elevation: elevation,

                      //   borderRadius: BorderRadius.circular(4.0),

                      child: Row(
                        children: <Widget>[
                          _buildThumbnail(document["photo"]),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          document["title"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0),
                                          softWrap: true,
                                        ),
                                      ),
                                      //     _buildTag(context)
                                    ],
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: document["description"],
                                        ),
                                      ],
                                    ),
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                  const SizedBox(height: 5.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                    /////////////////////
                    );
              }).toList(),
            );
        }
      },
    );
  }

  ///.///////////////////////////////////////////////////////////////joindEvents
  /////////////

////////////////////////////////////////////////////////////////////scanningEvents
  ///
  ///

  scanningEvents() {
    return StreamBuilder<QuerySnapshot>(
      stream: // name != "" && name != null
          //? Firestore.instance
          //  .collection('Events')
          //.where("serchIndex", arrayContains: name)
          //.snapshots()
          Firestore.instance
              .collection("scanTeam")
              .where("userID", isEqualTo: ID)
              .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        if (!snapshot.hasData)
          return Center(
            child: Text('loading aata ...Please Wait'),
          );
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (context) {
                        return new SubScanPage(
                          eventTitle1: document["eventTitle"],
                          eventPhoto: document["eventphoto"],
                        );
                      }));
                    },
                    child: Card(
                      //elevation: elevation,

                      //   borderRadius: BorderRadius.circular(4.0),

                      child: Row(
                        children: <Widget>[
                          _buildThumbnail(document["eventphoto"]),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          document["eventTitle"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0),
                                          softWrap: true,
                                        ),
                                      ),
                                      //     _buildTag(context)
                                    ],
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        // TextSpan(
                                        //   text:  document["description"],
                                        // ),
                                      ],
                                    ),
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                  const SizedBox(height: 5.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                    /////////////////////
                    );
              }).toList(),
            );
        }
      },
    );
  }
  /////////////////////////////////////////////////////////////////scanningEvents

////////////////////////////////////////////////////////////////////AttendEvents
  ///
  ///

  AttendEvents() {
    return StreamBuilder<QuerySnapshot>(
      stream: // name != "" && name != null
          //? Firestore.instance
          //  .collection('Events')
          //.where("serchIndex", arrayContains: name)
          //.snapshots()
          Firestore.instance
              .collection("attendees")
              .where("userID", isEqualTo: ID)
              .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        if (!snapshot.hasData)
          return Center(
            child: Text('loading aata ...Please Wait'),
          );
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Container(
                         // height: MediaQuery.of(context).size.height * 0.1,
                          child: AlertDialog(
                            // title: Text("Rate Event"),

                            //contentPadding: EdgeInsets.all(100),
                            content:
                             Container(
                               height: MediaQuery.of(context).size.height * 0.6,
                               child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text("Rate Event"),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SmoothStarRating(
                                    rating: 0.0,
                                    isReadOnly: false,
                                    size: 30,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_half,
                                    defaultIconData: Icons.star_border,
                                    starCount: 5,
                                    allowHalfRating: true,
                                    spacing: 2.0,
                                    onRated: (value) {
                                      print("rating value -> $value");
                                      // print("rating value dd -> ${value.truncate()}");
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text("Rate Place"),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SmoothStarRating(
                                    rating: 0.0,
                                    isReadOnly: false,
                                    size: 30,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_half,
                                    defaultIconData: Icons.star_border,
                                    starCount: 5,
                                    allowHalfRating: true,
                                    spacing: 2.0,
                                    onRated: (value) {
                                      print("rating value -> $value");
                                      // print("rating value dd -> ${value.truncate()}");
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text("Rate Speaker"),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SmoothStarRating(
                                    rating: 0.0,
                                    isReadOnly: false,
                                    size: 30,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_half,
                                    defaultIconData: Icons.star_border,
                                    starCount: 5,
                                    allowHalfRating: true,
                                    spacing: 2.0,
                                    onRated: (value) {
                                      print("rating value -> $value");
                                      // print("rating value dd -> ${value.truncate()}");
                                    },
                                  )
                                ],
                            ),
                             ),
                            actions: [
                              FlatButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      //elevation: elevation,

                      //   borderRadius: BorderRadius.circular(4.0),

                      child: Row(
                        children: <Widget>[
                          _buildThumbnail(document["eventphoto"]),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          document["eventtitle"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0),
                                          softWrap: true,
                                        ),
                                      ),
                                      //     _buildTag(context)
                                    ],
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        // TextSpan(
                                        //   text:  document["description"],
                                        // ),
                                      ],
                                    ),
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                  const SizedBox(height: 5.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                    /////////////////////
                    );
              }).toList(),
            );
        }
      },
    );
  }
  ////////////////////////////////////////////////////////////////AttendEvents

}

class Highlight extends StatelessWidget {
  final String image;
  final String title;

  Highlight({this.image, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 25.0),
      child: Column(
        children: <Widget>[
          Container(
            child: CircleAvatar(
              backgroundImage: AssetImage(image),
            ),
            width: 75.0,
            height: 75.0,
            padding: EdgeInsets.all(3.0),
            decoration:
                BoxDecoration(color: Colors.grey[800], shape: BoxShape.circle),
          ),
          SizedBox(height: 5.0),
          Text(
            title,
            style: TextStyle(fontSize: 14.0),
          )
        ],
      ),
    );
  }
}
