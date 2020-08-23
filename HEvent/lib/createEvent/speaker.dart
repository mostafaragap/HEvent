// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecproject/createEvent/placeInfo.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class speaker extends StatefulWidget {
//   @override
//   _speakerState createState() => _speakerState();
// }

// class _speakerState extends State<speaker> {
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
//   }

//   List<bool> inputs = new List<bool>();
//   List<String> chooise = new List<String>();

//   void ItemChange(bool val, int index, String id) {
//     setState(() {
//       inputs[index] = val;
//       chooise.add(id);
//     });
//   }

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

//       // body: Container(

//       //     child: GridView.builder(
//       //    // childAspectRatio: 100.0, .count
//       //     itemCount: speakers.length,
//       //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       //       crossAxisCount: 2,
//       //       childAspectRatio: (itemWidth / itemHeight),
//       //       ),
//       //     itemBuilder: (BuildContext context,index){
//       //     return Padding(

//       //     //  width: MediaQuery.of(context).size.width,
//       //       padding: EdgeInsets.all(10),
//       //       child: Card(
//       //         color: Colors.white,
//       //         elevation: 20,
//       //         child: Column(
//       //           children: <Widget>[
//       //             Align(
//       //             alignment: Alignment.topRight,
//       //             child: Checkbox(
//       //             onChanged: (bool value) {
//       //             setState(() => this._checkBoxVal = value);
//       //             },
//       //             value: this._checkBoxVal,
//       //             ),
//       //             ),

//       //             Align(
//       //               alignment: Alignment.center,
//       //               heightFactor: 0.5,
//       //               widthFactor: 0.3,
//       //               child: ClipOval(
//       //                 //radius: 30,
//       //                // maxRadius: 50.0,
//       //                 child: SizedBox(
//       //                   width: 70,
//       //                   height: 70,
//       //                   child:Image.asset('${speakers[index]['image']}',fit: BoxFit.fill,),////// image

//       //                 ),
//       //               ),
//       //             ),
//       //            //Image.asset('${speakers[index]['image']}',width: 20,height: 20,),////// image
//       //           // Image.asset('assets/AI.jpg',width: 20,height: 10,),////// image
//       //           SizedBox(height: 22,),
//       //            Text('${speakers[index]['name']}',

//       //            style: GoogleFonts.montserrat(
//       //                       fontSize: 13.0,
//       //                       fontWeight: FontWeight.bold,
//       //                       textStyle: TextStyle(color: Colors.black),),

//       //            ),
//       //            SizedBox(height: 4,),
//       //            Text('${speakers[index]['info']}',
//       //            style: GoogleFonts.montserrat(
//       //                       fontSize: 12.0,
//       //                       fontWeight: FontWeight.w400,
//       //                       textStyle: TextStyle(color: Colors.black)),
//       //            ),
//       //           ],
//       //         ),

//       //       ),

//       //     );/*Text('${speakers[index]['name']}');*/
//       //       }
//       //      ),

//       //   ),

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
//                     child: Card(
//                       color: Colors.white,
//                       elevation: 20,
//                       child: Column(
//                         children: <Widget>[
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: Checkbox(
//                               onChanged: (bool value) {
//                                 setState(() => this._checkBoxVal = value);
//                               },
//                               value: this._checkBoxVal,
//                             ),
//                           ),

//                           Align(
//                             alignment: Alignment.center,
//                             heightFactor: 0.5,
//                             widthFactor: 0.3,
//                             child: ClipOval(
//                               //radius: 30,
//                               // maxRadius: 50.0,
//                               child: SizedBox(
//                                 width: 70,
//                                 height: 70,
//                                 child: Image.network(
//                                   document['image'],
//                                   fit: BoxFit.fill,
//                                 ), ////// image
//                               ),
//                             ),
//                           ),
//                           //Image.asset('${speakers[index]['image']}',width: 20,height: 20,),////// image
//                           // Image.asset('assets/AI.jpg',width: 20,height: 10,),////// image
//                           SizedBox(
//                             height: 22,
//                           ),
//                           Text(
//                             document['title'],
//                             style: GoogleFonts.montserrat(
//                               fontSize: 13.0,
//                               fontWeight: FontWeight.bold,
//                               textStyle: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 4,
//                           ),
//                           Text(
//                             document['discreption'],
//                             style: GoogleFonts.montserrat(
//                                 fontSize: 12.0,
//                                 fontWeight: FontWeight.w400,
//                                 textStyle: TextStyle(color: Colors.black)),
//                           ),
//                         ],
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
//         tooltip: 'Next',
//         child: Icon(
//           Icons.arrow_back,
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
//         this._appBarTitle = new Text('Speaker');
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
import 'package:HEvent/createEvent/speakerProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class speaker extends StatefulWidget {
  String budget;
  var date;
  String track;
  speaker(
      {
      this.budget,
      this.date,
      this.track
      });
  @override
  _speakerState createState() => _speakerState();
}

class _speakerState extends State<speaker> {
  @override
  void initState() {
    super.initState();
    _data = getdata();
    // TODO: implement initState
    setState(() {
      for (int i = 0; i < 500; i++) {
        inputs.add(false);
      }
    });
    print(int.parse(widget.budget));
    print(widget.date);
  }

  List<bool> inputs = new List<bool>();
  List<String> chooise = new List<String>();
  List<String> chooiseid = new List<String>();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   setState(() {
  //     for(int i=0;i<10;i++){
  //       inputs.add(false);
  //     }
  //   });
  // }

  // speaker(var speaker) async {
  //   //choois = 'non';
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   await prefs.setString('speaker', speaker);
  //   print(speaker);
  // }

  void ItemChange(bool val, int index, String id) {
    ///////////////////////////////////////////////////////////////////////////////
    setState(() {
      if (val == true) {
        inputs[index] = val;
        chooise.add(id);
      } else {
        inputs[index] = val;
        chooise.remove(id);
      }
    });
  }
  void ItemChangeid(bool val, int index, String id) {
    ///////////////////////////////////////////////////////////////////////////////
    setState(() {
      if (val == true) {
        inputs[index] = val;
        
        chooiseid.add(id);
      } else {
        inputs[index] = val;
      
        chooiseid.remove(id);
      }
    });
  }

  List<int> speakerPrice = new List<int>();
  int speakerPriceSum = 0;

    void ItemChangeSpekerPrice(bool val, int index, int price) {
    ///////////////////////////////////////////////////////////////////////////////
    setState(() {
      if (val == true) {
        inputs[index] = val;
        
        speakerPrice.add(price);
      } else {
        inputs[index] = val;
      
        speakerPrice.remove(price);
      }
    });
  }

  

  Future _data;
  Future getdata() async {
    var firestore = Firestore.instance;
    if (name != "" && name != null) {
      QuerySnapshot qn = await firestore
          .collection('user')
          .where("speaker", isEqualTo: "speaker")
          .where("serchIndex", arrayContains: name)
         // .where("price", isNull: false)
       // .where("price", isLessThanOrEqualTo: int.parse(widget.budget))
        //.where("schedule", arrayContains : widget.date)
          
          .getDocuments();
      return qn.documents;
    } else {
      QuerySnapshot qn = await firestore.collection('user')
      .where("speaker", isEqualTo: "speaker")
      .where('activeSpeaker', isEqualTo: true)
    //  .where("price", isNull: false)
      .where("price" , isLessThanOrEqualTo: int.parse(widget.budget))
      .where("schedule", arrayContains : widget.date)
      .where('eventType', isEqualTo: widget.track)
      .getDocuments();
      return qn.documents;
    } 
  }

  get floatingActionButton => null;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: _buildBar(context),

      body: Container(
        child: FutureBuilder(
            future: getdata(),
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
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => speakerProfilec(id: snapshot.data[index].data["id"],)),
                          );
                        },
                        child: Padding(
                          //  width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          child: Card(
                            color: Colors.white,
                            elevation: 20,
                            child: Column(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.topRight,
                                    // child: Checkbox(
                                    // onChanged: (bool value) {
                                    // setState(() => this._checkBoxVal = value);
                                    // },
                                    // value: this._checkBoxVal,
                                    // ),
                                    child: CheckboxListTile(
                                        value: inputs[index],
                                        //title: new Text('item ${index}'),
                                        //controlAffinity: ListTileControlAffinity.leading,
                                        onChanged: (bool val) {
                                          ItemChange(
                                              val,
                                              index,
                                              snapshot
                                                  .data[index].data["name"]);
                                                  ItemChangeid(
                                              val,
                                              index,
                                              snapshot
                                                  .data[index].data["id"]);

                                          ItemChangeSpekerPrice (
                                              val,
                                              index,
                                              snapshot
                                                  .data[index].data["price"]);
                                        })),

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
                                      //child:Image.asset(document["image"],fit: BoxFit.fill,),////// image
                                      child: Image.network(
                                        snapshot.data[index].data["photo"],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                //Image.asset('${speakers[index]['image']}',width: 20,height: 20,),////// image
                                // Image.asset('assets/AI.jpg',width: 20,height: 10,),////// image
                                SizedBox(
                                  height: 22,
                                ),
                                Text(
                                  snapshot.data[index].data["name"],
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
                                //   snapshot.data[index].data["discreption"],
                                //   style: GoogleFonts.montserrat(
                                //       fontSize: 12.0,
                                //       fontWeight: FontWeight.w400,
                                //       textStyle:
                                //           TextStyle(color: Colors.black)),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ); /*Text('${speakers[index]['name']}');*/
                    });
              }
            }),
      ),

      /////////////////////////////////////
      floatingActionButton: FloatingActionButton(
        ////////////////
        onPressed: () async {

          
        int k = 0;
        for( k =0; k < speakerPrice.length ; k++ ){
           speakerPriceSum = speakerPriceSum + speakerPrice[k];
          }

          SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setStringList('speaker', chooise);
          await prefs.setStringList('speaker_Id', chooiseid);
          await prefs.setInt('speaker_price', speakerPriceSum);
          print(chooise);

          Navigator.pop(
            context,
          );
        },
        tooltip: 'Next',
        child: Icon(
          Icons.arrow_back,
          color: Color(0xFFFD4F99),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }

  ////////////////////////////// search app bar
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
    );
  }

  getData() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('category')
        .where("serchIndex", arrayContains: name)
        .getDocuments();
    return qn.documents;
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          onEditingComplete: () {
            setState(() {
              getdata();
              getData();
              _data;
            });
          },
          onSubmitted: (v) {
            setState(() {
              getdata();
              getData();
              _data;
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
        this._appBarTitle = new Text('Speaker');
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
