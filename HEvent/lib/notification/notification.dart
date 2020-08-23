
import 'package:HEvent/notification/speaker_notification.dart';
import 'package:HEvent/pages/setup/Interests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HEvent/homeExplore/moreExplore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';

class notification extends StatefulWidget {
  String type;
  notification({this.type});
  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  final dio = new Dio(); // for http requests
  String image = "";
  bool fav = false;
  bool join = false;
  var interests ;
  var intersts1 = [] ; 
var firestoreInstance = Firestore.instance ;
  FirebaseUser user;
  Future<void> getUser() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
   
      print(user.uid);
    });
  } //////////////////////////////////////////////////////////////get user id
Future getUserInterests() async
 {
  
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("user").document(firebaseUser.uid).get().then((value){
      setState(() {
        interests = value.data["Interests"] ;
       
    });
     // interests = value.data["Interests"] ;
      print(interests);
    });
    
    
   
 }
  @override
  void initState() {
    super.initState();
     getUser();
  
    _data = getdata();
  
  getUserInterests();

  }


  Future _data , _username;
  Future getdata() async {
    var firestore = Firestore.instance;
    if (name != "" && name != null) {
      QuerySnapshot qn = await firestore
          .collection('notification')
          .where("serchIndex", arrayContains: name)
          .where("trakName", whereIn: interests)
          .getDocuments();
      return qn.documents;
    } else {
      QuerySnapshot qn = await firestore
          .collection('notification')
         .where("trakName", whereIn: interests)
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
      title: _appBarTitle,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.person_add), 
          onPressed: (){
            Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => speaker_notification(
                   
                  )),
        );
          })
      ],
      ),
      
      body: Container(
          // scrollDirection: Axis.vertical,
          //children: <Widget>[

          child: StreamBuilder<QuerySnapshot>(
            
        stream: name != "" && name != null 
            ? Firestore.instance
                .collection('notification')
               // .where("serchIndex", arrayContains: name)
               .where("trakName", whereIn: interests)
                .snapshots() 
            : Firestore.instance
                .collection("notification")
                .where("trakName", whereIn: interests)
                .where('field', )
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
                       
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return new moreExplore(
                            photo: document["image"], title: document["Event_name"],
                            address: document["address"],
                            desciption: document["decription"],
                            capacity: document["capacity"].toString(),
                            place: document["place"],
                            date: document["date"],
                         //   speaker: document["speaker"],
                            // status: document["status"],
                            docID: document['Event_Id'],
                             userID: user.uid,
                            stat: avalible,
                            favo: av,
                            owner: document['User_Id'],
                            track: document['trakName'],
                            //,color: color,
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
                                         
                                          child: Text('There are Event for your preferred track ' + document['trakName'] 
                                            ,
                                            
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0),
                                            softWrap: true,
                                          )
                                          ,
                                        ), 
                                        //     _buildTag(context)
                                      ],
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: document["Event_name"] + '  tap for more info',
                                          ),
                                        ],
                                      ),
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    ),
                                    const SizedBox(height: 4.0),
                                   
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

 

  ////////////////////////////// search app bar
  Widget _appBarTitle = new Text('Notifications');
  Icon _searchIcon = new Icon(Icons.person_add);
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
      height: 60,
      width: 60,
      
      decoration: BoxDecoration(
        
        shape: BoxShape.circle,
      //  borderRadius:
            //  imageRight
            //     ? BorderRadius.only(
            //         topRight: Radius.circular(4.0),
            //         bottomRight: Radius.circular(4.0),
            //       )
            //     :
         //   BorderRadius.only(
        //  topLeft: Radius.circular(4.0),
        //  bottomLeft: Radius.circular(4.0),
       // ),
        image: DecorationImage(
          image: NetworkImage(img),
          fit: BoxFit.fill,
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
        this._appBarTitle = new Text(widget.type);
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

