import 'package:HEvent/Profile/myplaceinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class speakerSetting extends StatefulWidget {
  @override
  _speakerSettingState createState() => _speakerSettingState();
}

class _speakerSettingState extends State<speakerSetting> {
  FirebaseUser user;
  var username;
  var firestoreInstance = Firestore.instance;
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

  Future getUsername(String id) async {
    var username1;
    // var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("user").document(id).get().then((value) {
      setState(() {
        username1 = value.data["name"];
      });
      // interests = value.data["Interests"] ;
      print(username1);
    });
    return username1;
  }

  @override
  void initState() {
    super.initState();

    f();
    getUser();
    loadData();
  }

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
    }
  }
  ////////////////////////////////////////////////////////////////////////////////////////

  speakerActivate(var t) {
    Firestore.instance.collection('user').document(user.uid).updateData({
      ///////user.uid
      'activeSpeaker': t, //activeSpeaker
    });

    if (t == true) {
      Toast.show(
        "The speaker is Activation",
        context,
      );
    } else {
      Toast.show(
        "The speaker is Deactivation",
        context,
      );
    } //activeSpeaker
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speaker Setting"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings_power,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                // this.activeSpeaker = currentvalue;
                if (currentvalue == true) {
                  setState(() {
                    currentvalue = false;
                  });
                } else {
                  setState(() {
                    currentvalue = true;
                  });
                }
                print(currentvalue);
                speakerActivate(currentvalue);
                //  Firestore.instance.runTransaction((transaction) async {await transaction.update( documentReference, value); };
                //  return activeSpeaker;
              });
            },
          )
        ],
      ),
      body: Container(
          // scrollDirection: Axis.vertical,
          //children: <Widget>[

          child: StreamBuilder<QuerySnapshot>(
        stream: name != "" && name != null
            ? Firestore.instance
                .collection('join_event_speaker')
                .where("serchIndex", arrayContains: name)
                // .where("placType", isEqualTo: widget.type)
                .snapshots()
            : Firestore.instance
                .collection('join_event_speaker')
                .where('user', isEqualTo: ID)
                //    .document(ID)
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
                      // onTap: () async {
                      //   Navigator.of(context)
                      //       .push(new MaterialPageRoute(builder: (context) {
                      //     return new myplaceinfo(
                      //       images: document["images"],
                      //       title: document["placeName"],
                      //       address: document["placeAddress"],
                      //       desciption: document["placeDescription"],
                      //       capacity: document["placecapacity"],
                      //       // services: document["services"],
                      //       // date: document["date"], status: document["status"],
                      //       docID: document.documentID,
                      //       userID: document['PlaceOwnerId'],
                      //       price: document['placePrice'],
                      //       //stat: avalible,favo: av,
                      //       //,color: color,
                      //     );
                      //   }));
                      // },
                      child: Card(
                    //elevation: elevation,

                    //   borderRadius: BorderRadius.circular(4.0),

                    child: Row(
                      children: <Widget>[
                        _buildThumbnail(document['photo']),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "Event Name : " + document['title'],
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
                                        text:
                                            "date: " + document['date'] + "\n",
                                      ),
                                      TextSpan(
                                        text: "Address : " + document['place'],
                                      ),
                                    ],
                                  ),
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                                const SizedBox(height: 5.0),
                                // IconButton(
                                //   icon: Icon(Icons.delete),
                                //   onPressed: () {
                                //     Firestore.instance
                                //         .collection("Events")
                                //         .document(document.documentID)
                                //         .delete()
                                //         .then((_) {
                                //       Toast.show("Deleted", context);
                                //     }).catchError((err) {
                                //       Toast.show("Err", context);
                                //     });
                                //   },
                                // )
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
        borderRadius: BorderRadius.only(
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

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          onEditingComplete: () {
            setState(() {
              // getdata();
            });
          },
          onSubmitted: (v) {
            setState(() {
              // getdata();
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
        // this._appBarTitle = new Text(widget.type);
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
