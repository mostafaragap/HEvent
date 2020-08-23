import 'package:HEvent/Profile/speakerProfile.dart';
//import 'package:ecproject/createEvent/speaker.dart';
import 'package:HEvent/homeExplore/moreExplore.dart';
import 'package:HEvent/srearch/searchPlaceInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HEvent/createEvent/speakerProfile.dart';
import 'package:google_fonts/google_fonts.dart';

class searchPage extends StatefulWidget {
  @override
  _searchPageState createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  static const String Speaker = 'Speaker';
  static const String Place = 'Place';
  static const String Event = 'Event';

  static const List<String> choices = <String>[
    Speaker,
    Place,
    Event,
  ];

  String c = "";

 FirebaseUser user;
  Future<void> getUser() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      print(user.uid);
    });
  } //////////////////////////////////////////////////////////////get user id

  @override
  void initState() {
    super.initState();
    
    getUser();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: _buildBar(context),
      // body: Center(
      //   child: Text('chooise search type'),
      // ),
      body: (c == "Speaker")
          ? speaker()
          : (c == "Event")
              ? event()
              : (c == "Place")
                  ? place()
                  : Center(child: Text('chooise search type')),
    );
  }

  //@override
  speaker() {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return StreamBuilder<QuerySnapshot>(
      stream: name != "" && name != null
          ? Firestore.instance
              .collection('user')
              .where("speaker", isEqualTo: "speaker")
              .where("serchIndex", arrayContains: name)
              .snapshots()
          : Firestore.instance
              .collection("user")
              .where("speaker", isEqualTo: "speaker")
              .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        if (!snapshot.hasData)
          return Center(
            child: Text('loading data ...Please Wait'),
          );
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          //  return new Text('Loading...');
          default:
            return new GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
              ),
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Padding(
                  //  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => speakerProfilec(id: document['id'],)),
                          );
                        },
                    child: Card(
                      color: Colors.white,
                      elevation: 20,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),

                          Align(
                            alignment: Alignment.center,
                            heightFactor: 0.5,
                            widthFactor: 0.3,
                            child: ClipOval(
                              //radius: 30,
                              // maxRadius: 50.0,
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: Image.network(
                                  document['photo'],
                                  fit: BoxFit.fill,
                                ), ////// image
                              ),
                            ),
                          ),
                          //Image.asset('${speakers[index]['image']}',width: 20,height: 20,),////// image
                          // Image.asset('assets/AI.jpg',width: 20,height: 10,),////// image
                          SizedBox(
                            height: 22,
                          ),
                          Text(
                            document['name'],
                            style: GoogleFonts.montserrat(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              textStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          // Text(
                          //   document['discreption'],
                          //   style: GoogleFonts.montserrat(
                          //       fontSize: 12.0,
                          //       fontWeight: FontWeight.w400,
                          //       textStyle: TextStyle(color: Colors.black)),
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
/////////////////////////////////////////////////////////////////speaker

////////////////////////////////////////////////////////////////////Event
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
  event() {
    return StreamBuilder<QuerySnapshot>(
      stream: name != "" && name != null
          ? Firestore.instance
              .collection('Events')
              .where("serchIndex", arrayContains: name)
              .snapshots()
          : Firestore.instance.collection("Events").snapshots(),
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
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (context) {
                        return new moreExplore(
                          photo: document["image"], title: document["name"],
                            address: document["address"],
                            desciption: document["decription"],
                            capacity: document["capacity"].toString(),
                            place: document["place"],
                            date: document["date"],
                         //   speaker: document["speaker"],
                            // status: document["status"],
                            docID: document.documentID, userID: user.uid,
                            stat: avalible,favo: av,
                            track: document["trakName"],
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

  ///.///////////////////////////////////////////////////////////////Event
  ///

////////////////////////////////////////////////////////////////////place
  ///
  ///

  ///
  place() {
    return StreamBuilder<QuerySnapshot>(
      stream: name != "" && name != null
          ? Firestore.instance
              .collection('place')
              .where("serchIndex", arrayContains: name)
              // .where("placType", isEqualTo: widget.type)
              .snapshots()
          : Firestore.instance
              .collection("place")
              // .where("placType", isEqualTo: widget.type)
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
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (context) {
                        return new searchPlaceInfo(
                          images: document["images"],
                          title: document["placeName"],
                          address: document["placeAddress"],
                          desciption: document["placeDescription"],
                          capacity: document["placecapacity"],
                          // services: document["services"],
                          // date: document["date"], status: document["status"],
                          docID: document.documentID,
                          userID: document['PlaceOwnerId'],
                          price: document['placePrice'],
                          //stat: avalible,favo: av,
                          //,color: color,
                        );
                      }));
                    },
                    child: Card(
                      //elevation: elevation,

                      //   borderRadius: BorderRadius.circular(4.0),

                      child: Row(
                        children: <Widget>[
                          _buildThumbnail(document["images"][0]),
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
                                          document["placeName"],
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
                                          text: document["placeDescription"],
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

  ///.///////////////////////////////////////////////////////////////place
  ////////////////////////////// search app bar
  ///
  void choiceAction(String choice) {
    if (choice == Speaker) {
      setState(() {
        speaker();
        c = "Speaker";
      });
    } else if (choice == Place) {
      setState(() {
        //speaker();
        c = "Place";
      });
      print('Place');
    } else if (choice == Event) {
      setState(() {
        //speaker();
        c = "Event";
      });
      print('Event');
    }
  }

  ///
  ///
  ///
  Widget _appBarTitle = new Text('Search...');
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
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: choiceAction,
          itemBuilder: (BuildContext context) {
            return choices.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        )
      ],
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          onChanged: (val) => initiateSearch(val),
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search');
      }
    });
  }

  String name = "";
  void initiateSearch(String val) {
    setState(() {
      name = val.toLowerCase().trim();
    });
  }
  /////////////////////////
}
