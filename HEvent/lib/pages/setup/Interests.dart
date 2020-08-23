// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecproject/createEvent/placeInfo.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:toast/toast.dart';

// class Interests extends StatefulWidget {
//   @override
//   _InterestsState createState() => _InterestsState();
// }

// class _InterestsState extends State<Interests> {
//   @override
//   void initState() {
//     super.initState();
//     // _data = getdata();
//     // TODO: implement initState
//     setState(() {
//       for (int i = 0; i < 100; i++) {
//         inputs.add(false);
//       }
//     });
//     cheeck;
//   }

//   String coolr = "";

//   List<bool> inputs = new List<bool>();
//   List<String> chooise = new List<String>();

//   void ItemChange(bool val, int index, String id) {
//     setState(() {
//       inputs[index] = val;
//       chooise.add(id);
//     });
//   }

//   var visiabilty = 0.0;
//   var cheeck = false;

//   bool _checkBoxVal = false;
//   List speakers = [
//     {
//       'name': 'mohamed',
//       'info': 'asuhdkasmdkljasdkl',
//       'image': 'assets/AI.jpg',
//     },
//     {
//       'name': 'ahmed',
//       'info': 'asuhdk',
//       'image': 'assets/Discovering.jpg',
//     },
//     {
//       'name': 'khald',
//       'info': 'mdkljasdkl',
//       'image': 'assets/marketing.jpg',
//     },
//   ];

//   get floatingActionButton => null;

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
//     final double itemWidth = size.width / 2;
//     return Scaffold(
//       appBar: _buildBar(context),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: name != "" && name != null
//             ? Firestore.instance
//                 .collection('category')
//                 .where("serchIndex", arrayContains: name)
//                 .snapshots()
//             : Firestore.instance.collection("category").snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//             //  return new Text('Loading...');
//             default:
//               return new GridView(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: (itemWidth / itemHeight),
//                 ),
//                 children:
//                     snapshot.data.documents.map((DocumentSnapshot document) {
//                   return Padding(
//                     //  width: MediaQuery.of(context).size.width,
//                     padding: EdgeInsets.all(10),
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {
//                           visiabilty;
//                           cheeck = true;
//                           Toast.show("added  " + document['title'], context,
//                               duration: Toast.LENGTH_SHORT,
//                               gravity: Toast.BOTTOM);
//                           chooise.add(document['title']);
//                           print(chooise);
//                         });
//                       },
//                       child: Card(
//                         color: Colors.white,
//                         elevation: 20,
//                         child: Stack(
//                           children: <Widget>[
//                             Container(
//                               height: MediaQuery.of(context).size.height * 0.7,
//                               width: MediaQuery.of(context).size.width * 0.5,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5.0),
//                                   image: DecorationImage(
//                                       image: NetworkImage(document['image']),
//                                       fit: BoxFit.cover,
//                                       colorFilter: ColorFilter.mode(
//                                           Colors.black.withOpacity(0.3),
//                                           BlendMode.darken))),

//                               ///opacity //
//                             ),
//                             Center(
//                               child: Visibility(
//                                 child: Text(
//                                   document['title'],
//                                   style: //GoogleFonts.montserrat(

//                                       // fontWeight: FontWeight.bold,
//                                       TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 21.0,
//                                   ),
//                                   //),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 visible: cheeck,
//                               ),
//                             ),
//                             new Opacity(
//                                 opacity: visiabilty,
//                                 child: new Padding(
//                                   padding: const EdgeInsets.only(
//                                     left: 16.0,
//                                   ),
//                                   child: new Icon(Icons.done,
//                                       color: CupertinoColors.activeBlue),
//                                 )),
//                             Visibility(
//                               child: Text("Invisible"),
//                               maintainSize: true,
//                               maintainAnimation: true,
//                               maintainState: true,
//                               visible: cheeck,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         ////////////////
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => placeInfo()),
//           );
//         },
//         tooltip: 'Done',
//         child: Icon(
//           Icons.done,
//           color: Color(0xFFFD4F99),
//         ),
//         backgroundColor: Colors.black,
//       ),
//     );
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

//   void _searchPressed() {
//     setState(() {
//       if (this._searchIcon.icon == Icons.search) {
//         this._searchIcon = new Icon(Icons.close);
//         this._appBarTitle = new TextField(
//           onChanged: (val) => initiateSearch(val),
//           decoration: new InputDecoration(
//               prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
//         );
//       } else {
//         this._searchIcon = new Icon(Icons.search);
//         this._appBarTitle = new Text('Interests');
//       }
//     });
//   }

//   String name = "";
//   void initiateSearch(String val) {
//     setState(() {
//       name = val.toLowerCase().trim();
//     });
//   }
//   /////////////////////////
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HEvent/createEvent/eventName.dart';
import 'package:HEvent/createEvent/eventName2.dart';
import 'package:HEvent/createEvent/placeInfo.dart';
import 'package:HEvent/pages/setup/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Interests extends StatefulWidget {
  @override
  _InterestsState createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {

   FirebaseUser user;
 Future<void> getUser() async{
  FirebaseUser userData = await FirebaseAuth.instance.currentUser();
  setState(() {
    user = userData;
    print(user.uid);
  });
 }


  @override
  void initState() {
    super.initState();
    getUser();
    _data = getdata();
    // TODO: implement initState
    setState(() {
      for (int i = 0; i < 500; i++) {
        inputs.add(false);
      }
    });
  }

  bool _checkBoxVal = false;
 

  List<bool> inputs = new List<bool>();
  List<String> chooise = new List<String>();
  
  

  void ItemChange(bool val, int index, String id) {
    ///////////////////////////////////////////////////////////////////////////////
    setState(() {
      if(val == true){
      inputs[index] = val;
      chooise.add(id);
      }else{
        inputs[index] = val;
        chooise.remove(id);
      }
    });
  }

  Future _data;
  Future getdata() async {
    var firestore = Firestore.instance;
    //if(name != "" && name != null){
    //  QuerySnapshot qn = await firestore.collection('category').where("serchIndex", arrayContains: name).getDocuments();
    //  return qn.documents;
    //  }else{
    QuerySnapshot qn = await firestore.collection('Interests').getDocuments();
    return qn.documents;
    // }
  }

  get floatingActionButton => null;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF353535),
        centerTitle: true,
        title: Text('Interests'),
      ),

      body: Container(
        child: FutureBuilder(
            future: _data,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('loading...'),
                );
              } else {
                return GridView.builder(
                    // childAspectRatio: 100.0, .count
                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (itemWidth / itemHeight),
                    ),
                    itemBuilder: (_, index) {
                      return Padding(
                        //  width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        child: Card(
                          color: Colors.white,
                          elevation: 20,
                          child: Stack(
                            //child: Column(
                            children: <Widget>[
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            snapshot.data[index].data["image"]),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.3),
                                            BlendMode.darken))),

                                ///opacity //
                              ),
                              Align(
                                  // right: 1,
                                  // top: 1,
                                        alignment: Alignment.topRight,
                                  child: CheckboxListTile(
                                      value: inputs[index],
                                      //title: new Text('item ${index}'),
                                      //controlAffinity: ListTileControlAffinity.leading,
                                      onChanged: (bool val) {
                                        ItemChange(val, index,
                                            snapshot.data[index].data["title"]);
                                      })),
                              Center(
                                child: Visibility(
                                  child: Text(
                                    snapshot.data[index].data['title'],
                                    style: //GoogleFonts.montserrat(

                                        // fontWeight: FontWeight.bold,
                                        TextStyle(
                                      color: Colors.white,
                                      fontSize: 21.0,
                                    ),
                                    //),
                                    textAlign: TextAlign.left,
                                  ),
                                  //    visible: cheeck,
                                ),
                              ),
                            ],
                            //),
                          ),
                        ),
                        // ),
                      ); /*Text('${speakers[index]['name']}');*/
                    });
              }
            }),
      ),

      /////////////////////////////////////
      floatingActionButton: FloatingActionButton(
        ////////////////
        onPressed: () async {
          //   Navigator.of(context).push(
          //   new MaterialPageRoute(builder: (context){
          //     return new eventName2(places: chooise);
          //   })
          // );
          //  Navigator.pushReplacement(context, //////////////////////////// navigation without go back
          //    new MaterialPageRoute(builder: (context){
          //    return new eventName2(places: chooise,/*plaace_done: "Done"*/);
          //    })
          //  );
          // Navigator.pop(
          //   context,
          // );
           final FirebaseMessaging _fcm = FirebaseMessaging();
          _fcm.getToken().then((token) async {

      var userquery = Firestore.instance.collection('tokens').where('token' , isEqualTo :token).limit(1);
     userquery.getDocuments().then((data){
    if(data.documents.length > 0)
    {
   print("Erroooooooooooooooor");
    }else {
      Firestore.instance.collection('tokens').document().setData({
      'token':token,
      'user_Id':user.uid,
       'Interests': chooise
    }); 
    }

     });
  
   });
          await Firestore.instance.collection('user').document(user.uid).updateData(
         { 
           'Interests': chooise ,
           
         }
          );
          print(user.uid);
          print(chooise);
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())) ;
        },
        tooltip: 'Done',
        child: Icon(
          Icons.done,
          color: Color(0xFFFD4F99),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }

}
