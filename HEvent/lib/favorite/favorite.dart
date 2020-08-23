import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HEvent/homeExplore/moreExplore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'favoriteDetails.dart';

class favorite  extends StatefulWidget {
  // String type;
  // explore({this.type});
  @override
  _favoriteState createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  final dio = new Dio(); // for http requests
  String image = "";
  bool fav = false;
  bool join = false;

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
    getUser();
    //_data = getdata();
    loadData();
  }

  Future _data;
  Future getdata() async {
    var firestore = Firestore.instance;
    if (name != "" && name != null) {
      QuerySnapshot qn = await firestore
          .collection('Events')
          .where("serchIndex", arrayContains: name)
         // .where("trakName", isEqualTo: widget.type)
          .getDocuments();
      return qn.documents;
    } else {
      QuerySnapshot qn = await firestore
          .collection('Events')
          //.where("trakName", isEqualTo: widget.type)
          .getDocuments();
      return qn.documents;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        backgroundColor: Color(0xFF353535),
        centerTitle: true,
        title: Text('Favorite'),
      ),
      body: Container(
          // scrollDirection: Axis.vertical,
          //children: <Widget>[

          child: StreamBuilder<QuerySnapshot>(
        stream: name != "" && name != null
            ? Firestore.instance
                .collection('favorite')
                .where("serchIndex", arrayContains: name)
                .where("user", isEqualTo: ID)
                .snapshots()
            : Firestore.instance
                .collection("favorite")
                .where("user", isEqualTo: ID)
                .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          if (!snapshot.hasData)
            return Center(
              child: Text('loading data ...Please Wait'),
            );
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(
                child: Text('loading....'),
              );
            default:
              return new ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return InkWell(
                      onTap: () async {
                        var now = new DateTime.now();
                        var avalible ;
                        bool av;
                       // DateTime dob = DateTime.parse('2021-10-12');
                       var parsedDate = DateTime.parse(document['date']);
                        int difference = now.difference(parsedDate).inHours;
                        print(difference);
                        if(difference < 1){
                        setState(() {
                          avalible = "avalible";//Text('avalible',style: TextStyle(color: Colors.green),);
                          av = true;
                        });
                        }else{
                        setState(() {
                          avalible = "not avalible";//Text('not avalible',style: TextStyle(color: Colors.red),);
                          av = false;
                        });
                        }
                        // var data = await Firestore.instance.collection('favorite').document(document.documentID).get();
                        // if(data.exists){
                        // setState(() {
                        // var color = Colors.red;
                        // bool favo = true;
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return new favoriteDetails(
                            photo: document["photo"], title: document["title"],
                            address: document["address"],
                            desciption: document["description"],
                            capacity: document["capacity"],
                            place: document["place"],
                            date: document["date"],
                            // status: document["status"],
                            docID: document.documentID, userID: user.uid,
                            stat: avalible,favo: av,
                            //,color: color,
                          );
                        }));
                        // });
                        // }
                        // else{
                        // setState(() {
                        //   var color = Colors.white;
                        //     bool favo = false;
                        //     Navigator.of(context)
                        //     .push(new MaterialPageRoute(builder: (context) {
                        //   return new moreExplore(photo: document["image"],title: document["name"],
                        //   address: document["address"], desciption: document["decription"],
                        //   capacity: document["capacity"], services: document["services"],
                        //   date: document["date"],status: document["status"],
                        //   docID: document.documentID, favo: favo,color: color,
                        //   );
                        // }));
                        //   });
                        // }
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
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    ),
                                    const SizedBox(height: 5.0),
                                    // Row(
                                    //   children: <Widget>[
                                    //     Text("Condition"),
                                    //     const SizedBox(width: 10.0),
                                    //     Icon(
                                    //       Icons.star,
                                    //       color: Colors.yellow,
                                    //     ),
                                    //     Icon(
                                    //       Icons.star,
                                    //       color: Colors.yellow,
                                    //     ),
                                    //     Icon(
                                    //       Icons.star,
                                    //       color: Colors.yellow,
                                    //     ),
                                    //     Icon(
                                    //       Icons.star,
                                    //       color: Colors.yellow,
                                    //     ),
                                    //     Icon(
                                    //       Icons.star,
                                    //       color: Colors.yellow,
                                    //     ),
                                    //   ],
                                    // ),
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
      )

          //   ],
          ),
    );
  }

  // Widget myDetailsContainer1(String name, String info) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.only(left: 8.0),
  //         child: Container(
  //             child: Text(
  //           name,
  //           style: TextStyle(
  //               color: /*Color(0xffe6020a)*/ Colors.black,
  //               fontSize: 22.0,
  //               fontWeight: FontWeight.bold),
  //         )),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(left: 8.0),
  //         child: Container(
  //             child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: <Widget>[
  //             Container(
  //               child: Icon(
  //                 FontAwesomeIcons.solidStar,
  //                 color: Colors.amber,
  //                 size: 15.0,
  //               ),
  //             ),
  //             Container(
  //               child: Icon(
  //                 FontAwesomeIcons.solidStarHalf,
  //                 color: Colors.amber,
  //                 size: 15.0,
  //               ),
  //             ),
  //             Container(
  //                 child: Text(
  //               "(321) \u00B7 0.9 mi",
  //               style: TextStyle(
  //                 color: Colors.black54,
  //                 fontSize: 18.0,
  //               ),
  //             )),
  //           ],
  //         )),
  //       ),
  //       Container(
  //           child: Text(
  //         info,
  //         style: TextStyle(
  //             color: Colors.black54,
  //             fontSize: 18.0,
  //             fontWeight: FontWeight.bold),
  //       )),
  //     ],
  //   );
  // }

  ////////////////////////////// search app bar
  Widget _appBarTitle = new Text('search...');
  Icon _searchIcon = new Icon(Icons.search);
  Widget _buildBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Color(0xFF353535),
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

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
  // void _searchPressed() {
  //   setState(() {
  //     if (this._searchIcon.icon == Icons.search) {
  //       this._searchIcon = new Icon(Icons.close);
  //       this._appBarTitle = new TextField(
  //         decoration: new InputDecoration(
  //             prefixIcon: new Icon(Icons.search),
  //             hintText: 'Search...'

  //         ),
  //       );
  //     } else {
  //       this._searchIcon = new Icon(Icons.search);
  //       this._appBarTitle = new Text(widget.type);
  //     }
  //   });
  // }
  /////////////////////////

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          onEditingComplete: () {
            setState(() {
              getdata();
            });
          },
          onSubmitted: (v) {
            setState(() {
              getdata();
            });
            print(v);
          },
          onChanged: (val) => initiateSearch(val),
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Favorite');
      }
    });
  }

  String name = "";
  void initiateSearch(String val) {
    setState(() {
      name = val.toLowerCase().trim();
    });
  }
}

// child: Padding(
//                           /////////////////////////
//                           padding: const EdgeInsets.only(
//                               left: 16.0, right: 16, top: 16, bottom: 0),
//                           child: Container(
//                             child: new FittedBox(
//                               child: Material(
//                                   color: Colors.white,
//                                   elevation: 6.0,
//                                   borderRadius: BorderRadius.circular(12.0),
//                                   // shadowColor: Color(0x802196F3),
//                                   child: Row(
//                                     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       Container(
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 30.0, top: 30, bottom: 30),
//                                           child: myDetailsContainer1(
//                                               snapshot.data[index].data["name"],
//                                               snapshot
//                                                   .data[index].data["info"]),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 30,
//                                       ),
//                                       Container(
//                                         width: 150,
//                                         height: 135,
//                                         child: ClipRRect(
//                                           borderRadius:
//                                               new BorderRadius.circular(10.0),
//                                           child: Image(
//                                               fit: BoxFit.fill,
//                                               alignment: Alignment.topRight,
//                                               image: NetworkImage(
//                                                 // "https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"),
//                                                 snapshot
//                                                     .data[index].data["image"],
//                                               )),
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                             ),
//                           ),
//                         ),
