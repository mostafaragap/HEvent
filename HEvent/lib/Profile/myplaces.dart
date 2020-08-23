// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecproject/createEvent/eventName.dart';
// import 'package:ecproject/createEvent/eventName2.dart';
// import 'package:ecproject/createEvent/placeInfo.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class placelist extends StatefulWidget {
//   @override
//   _placelistState createState() => _placelistState();
// }

// class _placelistState extends State<placelist> {

//   @override
//   void initState(){
//     super.initState();
//     _data = getdata();
//      // TODO: implement initState
//     setState(() {
//       for(int i=0;i<500;i++){
//         inputs.add(false);
//       }
//     });
//   }

//   bool _checkBoxVal = false;
//   // List speakers = [
//   //   {
//   //     'name':'first',
//   //     'info':'asuhdkasmdkljasdkl',
//   //     'image':'assets/AI.jpg',
//   //   },
//   //   {
//   //     'name':'second',
//   //     'info':'asuhdk',
//   //     'image':'assets/Discovering.jpg',
//   //   },
//   //   {
//   //     'name':'3erd place',
//   //     'info':'mdkljasdkl',
//   //     'image':'assets/marketing.jpg',
//   //   },
//   // ];

//     List<bool> inputs = new List<bool>();
//     List<String> chooise = new List<String>();
//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   setState(() {
//   //     for(int i=0;i<10;i++){
//   //       inputs.add(false);
//   //     }
//   //   });
//   // }

//   placee(String choois ) async {
//     //choois = 'non';
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   await prefs.setString('place', choois);
//   print(choois);
// }

//   void ItemChange(bool val,int index,String id){///////////////////////////////////////////////////////////////////////////////
//     setState(() {
//       inputs[index] = val;
//       chooise.add(id);
//      // choois=id;
//       placee(id);
//     });
//   }
//   Future _data;
//   Future getdata() async {
//     var firestore = Firestore.instance;
//     if(name != "" && name != null){
//       QuerySnapshot qn = await firestore.collection('category').where("serchIndex", arrayContains: name).getDocuments();
//       return qn.documents;
//     }else{
//       QuerySnapshot qn = await firestore.collection('category').getDocuments();
//       return qn.documents;
//     }

//   }

//   get floatingActionButton => null;

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
//     final double itemWidth = size.width / 2;
//     return Scaffold(
//       appBar: _buildBar(context),

//       body: Container(
//             child: FutureBuilder(
//               future: getdata(),
//               builder: (_,snapshot){
//                if(snapshot.connectionState == ConnectionState.waiting){
//                 return Center(
//                 child: Text('loading...'),
//                 );
//                 }else{
//            return GridView.builder(
//          // childAspectRatio: 100.0, .count
//           itemCount: snapshot.data.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: (itemWidth / itemHeight),
//             ),
//           itemBuilder: (_,index){
//           return InkWell(
//             onTap: (){
//                 Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => placeInfo()),
//                 );
//             },
//               child: Padding(
//             //  width: MediaQuery.of(context).size.width,
//               padding: EdgeInsets.all(10),
//               child: Card(
//                 color: Colors.white,
//                 elevation: 20,
//                 child: Column(
//                   children: <Widget>[
//                     Align(
//                     alignment: Alignment.topRight,
//                     // child: Checkbox(
//                     // onChanged: (bool value) {
//                     // setState(() => this._checkBoxVal = value);
//                     // },
//                     // value: this._checkBoxVal,
//                     // ),
//                     child: CheckboxListTile(
//                         value: inputs[index],
//                         //title: new Text('item ${index}'),
//                         //controlAffinity: ListTileControlAffinity.leading,
//                         onChanged:(bool val){ItemChange(val, index,snapshot.data[index].data["title"]);}
//                     )
//                     ),

//                     Align(
//                       alignment: Alignment.center,
//                       heightFactor: 0.5,
//                       widthFactor: 0.3,
//                       child: ClipOval(
//                         //radius: 30,
//                        // maxRadius: 50.0,
//                         child: SizedBox(
//                           width: 70,
//                           height: 70,
//                           //child:Image.asset(document["image"],fit: BoxFit.fill,),////// image
//                            child: Image.network(snapshot.data[index].data["image"],fit: BoxFit.fill,),
//                         ),
//                       ),
//                     ),
//                    //Image.asset('${speakers[index]['image']}',width: 20,height: 20,),////// image
//                   // Image.asset('assets/AI.jpg',width: 20,height: 10,),////// image
//                   SizedBox(height: 22,),
//                    Text(snapshot.data[index].data["title"],

//                    style: GoogleFonts.montserrat(
//                               fontSize: 13.0,
//                               fontWeight: FontWeight.bold,
//                               textStyle: TextStyle(color: Colors.black),),

//                    ),
//                    SizedBox(height: 4,),
//                    Text(snapshot.data[index].data["discreption"],
//                    style: GoogleFonts.montserrat(
//                               fontSize: 12.0,
//                               fontWeight: FontWeight.w400,
//                               textStyle: TextStyle(color: Colors.black)),
//                    ),
//                   ],
//                 ),

//               ),

//             ),
//           );/*Text('${speakers[index]['name']}');*/
//             }
//            );

//                         }
//                       }
//                     ),
//         ),

//      /////////////////////////////////////
//         floatingActionButton: FloatingActionButton( ////////////////
//             onPressed: (){
//               //   Navigator.of(context).push(
//               //   new MaterialPageRoute(builder: (context){
//               //     return new eventName2(places: chooise);
//               //   })
//               // );
//                   //  Navigator.pushReplacement(context, //////////////////////////// navigation without go back
//                   //    new MaterialPageRoute(builder: (context){
//                   //    return new eventName2(places: chooise,/*plaace_done: "Done"*/);
//                   //    })
//                   //  );
//                   Navigator.pop(context,);
//               },
//           tooltip: 'Next',
//           child: Icon(Icons.arrow_back,color: Color(0xFFFD4F99),),
//           backgroundColor: Colors.black,
//            ),
//       );

//   }

//   ////////////////////////////// search app bar
//   Widget _appBarTitle = new Text('Search...');
//   Icon _searchIcon = new Icon(Icons.search);
//   Widget _buildBar(BuildContext context) {
//     return new AppBar(
//       backgroundColor: Color(0xFF353535),
//       centerTitle: true,
//       title: _appBarTitle,
//       leading: new IconButton(
//         icon: _searchIcon,
//         onPressed: _searchPressed,

//       ),
//     );
//   }
//   getData() async{

//      var firestore = Firestore.instance;
//     QuerySnapshot qn = await firestore.collection('category').where("serchIndex", arrayContains: name).getDocuments();
//       return qn.documents;
// }

//   void _searchPressed() {
//     setState(() {
//       if (this._searchIcon.icon == Icons.search) {
//         this._searchIcon = new Icon(Icons.close);
//         this._appBarTitle = new TextField(
//           onEditingComplete: (){
//                setState(() {
//                   getdata();
//                 getData();
//                 _data;
//                });
//               },

//               onSubmitted: (v){
//                 setState(() {
//                   getdata();
//                 getData();
//                 _data;
//                });
//                 print(v);
//               },
//           onChanged: (val) => initiateSearch(val),
//           keyboardType: TextInputType.text,
//           decoration: new InputDecoration(
//               prefixIcon: new Icon(Icons.search),
//               hintText: 'Search...'

//           ),
//         );
//       } else {
//         this._searchIcon = new Icon(Icons.search);
//         this._appBarTitle = new Text('Speaker');
//       }
//     });
//   }

//    String name = "";
//   void initiateSearch(String val) {
//     setState(() {
//       name = val.toLowerCase().trim();
//     });
//   }
//   /////////////////////////
// }

import 'package:HEvent/Profile/myplaceinfo.dart';
import 'package:HEvent/Profile/placeEdit.dart';
import 'package:HEvent/Profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecproject/Profile/myplaceinfo.dart';
// import 'package:ecproject/Profile/profile.dart';
// import 'package:ecproject/createEvent/placeInfo.dart';
// import 'package:ecproject/homeExplore/moreExplore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class myplaces extends StatefulWidget {
  String type;
  myplaces({this.type});
  @override
  _myplacesState createState() => _myplacesState();
}

class _myplacesState extends State<myplaces> {
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
    _data = getdata();
    f();
    getUser();
    loadData();
  }

  bool activePlace = true;

  Future _data;
  Future getdata() async {
    var firestore = Firestore.instance;
    if (name != "" && name != null) {
      QuerySnapshot qn = await firestore
          .collection('Events')
          .where("serchIndex", arrayContains: name)
          .where("trakName", isEqualTo: widget.type)
          .getDocuments();
      return qn.documents;
    } else {
      QuerySnapshot qn = await firestore
          .collection('Events')
          .where("trakName", isEqualTo: widget.type)
          .getDocuments();
      return qn.documents;
    }
  }

  bool currentvalue;
  f() async {
    var data = await Firestore.instance.collection('place').document(ID).get();

    if (data['activePlace'].exists) {
      setState(() {
        //TSM3 F SAF7A KOLHA W INISTATE AWL HAGA BTRN
        //  my_color_variable = Colors.red;
        currentvalue = data['activePlace'];
      });
      print(data['activePlace']);
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

  placeActivate(var t, var docid) {
    Firestore.instance.collection('place').document(docid).updateData({
      ///////user.uid
      'activePlace': t, //activeSpeaker
    });
    if (t == true) {
      Toast.show(
        "The Place is Activation",
        context,
      );
    } else {
      Toast.show(
        "The Place is Deactivation",
        context,
      );
    } //activeSpeaker
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Places"),
        leading: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              Navigator.pushReplacement(context,
                  new MaterialPageRoute(builder: (context) {
                return new ProfileScreen();
              }));
            }),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
          // scrollDirection: Axis.vertical,
          //children: <Widget>[

          child: StreamBuilder<QuerySnapshot>(
        stream: name != "" && name != null
            ? Firestore.instance
                .collection('place')
                .where("serchIndex", arrayContains: name)
                // .where("placType", isEqualTo: widget.type)
                .snapshots()
            : Firestore.instance
                .collection("place")
                .where("PlaceOwnerId", isEqualTo: ID)
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
                          return new myplaceinfo(
                            images: document["images"],
                            title: document["placeName"],
                            address: document["placeAddress"],
                            desciption: document["placeDescription"],
                            capacity: document["placecapacity"],
                            // services: document["services"],
                            // date: document["date"], status: document["status"],
                            docID: document.documentID,
                            userID: document['PlaceOwnerId'],
                            price: document['placePrice'].toString(),
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
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    ),
                                    const SizedBox(height: 5.0),
                                    IconButton(
                                      icon: Icon(Icons.power_settings_new),
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
                                          placeActivate(currentvalue,
                                              document.documentID);
                                          //  Firestore.instance.runTransaction((transaction) async {await transaction.update( documentReference, value); };
                                          //  return activeSpeaker;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            new MaterialPageRoute(
                                                builder: (context) {
                                          return new placeEdit(
                                              placeID: document.documentID);
                                        }));
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        Firestore.instance
                                            .collection("place")
                                            .document(document.documentID)
                                            .delete()
                                            .then((_) {
                                          Toast.show("Deleted", context);
                                        }).catchError((err) {
                                          Toast.show("Err", context);
                                        });
                                      },
                                    )
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
