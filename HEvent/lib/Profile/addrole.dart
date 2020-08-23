import 'package:HEvent/Profile/beSpeaker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HEvent/Profile/addplaces.dart';
import 'package:HEvent/Profile/myplaces.dart';
import 'package:HEvent/Profile/profile.dart';
import 'package:HEvent/Profile/speakerProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:toast/toast.dart';

class addRolePage extends StatefulWidget {
  static final String path = "lib/src/pages/misc/navybar.dart";
  @override
  _addRolePageState createState() => _addRolePageState();
}

class _addRolePageState extends State<addRolePage> {
  FirebaseUser user;
  Future<void> getUser() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      //print(user.uid);
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
    loadData();
  }

  List<String> selectEventType = <String>[];

  static const menuItems = <String>[
    'Ai',
    'Marketing',
    'Discovering',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btn1SelectedVal = 'One';
  String _btn2SelectedVal;
  String _btn3SelectedVal;
  /////////////////////////////////////////////////////////////////End Drop Downbutton/////////////////////////////////////////////////////
  static const selectUniversty = <String>[
    'Helwan Universty',
    'Ain Shams Universty',
    'Cairo Universty',
  ];
  final List<DropdownMenuItem<String>> _dropDownselectUniversty =
      selectUniversty
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();
  final List<PopupMenuItem<String>> _popUpselectUniversty = selectUniversty
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btn4SelectedVal = 'One';
  String _btn5SelectedVal;
  String _btn6SelectedVal;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////
  static const selectedFaculty = <String>[
    'Faculty of Computer Science',
    'Facuty of engeneering',
    'Faculty of Commerce',
  ];
  final List<DropdownMenuItem<String>> _dropDownselectedFaculty =
      selectedFaculty
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();
  final List<PopupMenuItem<String>> _popUpselectedFaculty = selectedFaculty
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btn7SelectedVal = 'One';
  String _btn8SelectedVal;
  String _btn9SelectedVal;

////////////////////////////////////////////////////////
////////////////////////////////////////////////////
  static const numOFexperiance = <String>[
    '0-1',
    '1-5',
    '5-10',
  ];
  final List<DropdownMenuItem<String>> _dropDownnumOFexperiance =
      numOFexperiance
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();
  final List<PopupMenuItem<String>> _popUpnumOFexperiance = numOFexperiance
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btn10SelectedVal = 'One';
  String _btn11SelectedVal;
  String _btn12SelectedVal;

////////////////////////////////////////////////////////

  @override
  void dispose() {
    indexcontroller.close();
    super.dispose();
  }

  PageController pageController = PageController(initialPage: 0);
  StreamController<int> indexcontroller = StreamController<int>.broadcast();
  int index = 0;
  ////////////////////////////
  DateTime selectedDate = DateTime.now();
  List<DateTime> selectedDates = List();
  List<DateTime> finalDates = List();
  // List<DateTime> d = List();
  /////////////////////////////////////

  String _bio, _experiance, _facebookUrl, _youtubeChannel, _price;
  // bool activeSpeaker=false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();
  // var finalDates;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Add Role"),
      //   leading: IconButton(
      //       icon: Icon(Icons.cancel),
      //       onPressed: () {
      //         Navigator.pushReplacement(
      //             context, //////////////////////////// navigation without go back
      //             new MaterialPageRoute(builder: (context) {
      //           return new ProfileScreen();
      //         }));
      //         //                 Navigator.of(context).push(
      //         // new MaterialPageRoute( builder: (context){
      //         //   return new ProfileScreen();
      //         //    }
      //         //    )
      //         //    );
      //       }),

      //   backgroundColor: Colors.blue,
      //   elevation: 0.0,
      //   centerTitle: true,

      //   actions: <Widget>[

      //     Switch(
      //       onChanged: (bool value){
      //       setState(() => this.beSpeaker = value);
      //     },
      //     value: this.beSpeaker,

      //     ),

      //   ],
      // ),
      body: StreamBuilder(
          stream:
              Firestore.instance.collection('user').document(ID).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('loading Data ...Please Wait');
            // DateTime myDateTime = DateTime.parse(snapshot.data['schedule'].toDate().toString());
            //  print(myDateTime);
            ////////////////////////////////
            // for(int i=0; i<;i++)
            // List<DateTime> d = List();
            //   print(snapshot.data['activeSpeaker']);
            // print(
            //     'SAEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEED');
            // List<DateTime> d = new List();
            // if (snapshot.data['schedule'] != null) {
            //   var t = snapshot.data['schedule'];
            //   print(t.length);
            //   //    print(snapshot.data['schedule'][1].toDate());
            //   // List d;
            //   // var d  = new List(t.length);

            //   var s;

            //   for (var i = 0; i < t.length; i++) {
            //     //  print(t[i].toDate());
            //     // d[i] = t[i].toDate();
            //     d.add(t[i].toDate());
            //     // s.add(d);
            //     // d[i]=snapshot.data['schedule'][i].toDate();
            //   }
            //   print(d);
            // }
            // print(selectedDate);

            // print("the data i $d");
            //      int val;

            //       if(val == true){
            // selectedDates[index] = val;
            // selectedDates.add(id);
            // }else{

            //   selectedDates.remove(id);
            // }

            // var d = t[2].toDate();
            // List<DateTime> selectedDates = List();
            // print(d);
            // print(d.toString());
            //  selectedDates.add(d);
            // var saeed =snapshot.data['schedule'];
            // print(saeed);
            // DateTime myDateTime = DateTime.parse(saeed.toString());
            //             Timestamp t = saeed;
            // DateTime d = t.toDate();
            // print(d.toString());

            return new PageView(
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                indexcontroller.add(index);
              },
              controller: pageController,
              children: <Widget>[
                Center(
                  child: beSpeaker(),
                ),
                // SingleChildScrollView(
                //   child: Container(
                //     //height: 450,
                //     margin: EdgeInsets.all(10),
                //     child: Padding(
                //       padding: EdgeInsets.only(
                //           left: 30, right: 30, bottom: 30, top: 7.5),
                //       child: Form(
                //         key: _formkey, //el mas2ol 3n save form

                //         child: Column(
                //           children: <Widget>[
                //             Row(
                //               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: <Widget>[
                //                 Container(
                //                   width:
                //                       MediaQuery.of(context).size.width * 0.27,
                //                   child: Text(
                //                     'Event Type:',
                //                     style: TextStyle(
                //                       fontSize: 17,
                //                       fontStyle: FontStyle.normal,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                 ),
                //                 //  SizedBox(width: MediaQuery.of(context).size.width*0.3),

                //                 // Container(
                //                 //     width: 200,
                //                 //     decoration: BoxDecoration(
                //                 //         color: Colors.white54,
                //                 //         border: Border.all(
                //                 //           width:
                //                 //               0.3, //                   <--- border width here
                //                 //         ),
                //                 //         borderRadius: BorderRadius.circular(3)),
                //                 //     child: DropdownButton(
                //                 //       isExpanded: true,

                //                 //       icon: Icon(Icons.arrow_drop_down),
                //                 //       //  iconSize: 42,
                //                 //       underline: SizedBox(),

                //                 //       value: _btn2SelectedVal,
                //                 //       hint: Text('Event Type'),
                //                 //       onChanged: ((String newValue) {
                //                 //         setState(() {
                //                 //           _btn2SelectedVal = newValue;
                //                 //         });
                //                 //       }),
                //                 //       items: _dropDownMenuItems,
                //                 //     )),

                //                 Checkbox(
                //                     value: selectEventType.contains('AI'),
                //                     onChanged: (value) =>
                //                         changeSelectedSize('AI')),
                //                 Text('AI'),
                //               ],
                //             ),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: <Widget>[
                //                 Checkbox(
                //                     value:
                //                         selectEventType.contains('Marketing'),
                //                     onChanged: (value) =>
                //                         changeSelectedSize('Marketing')),
                //                 Text('Marketing'),
                //               ],
                //             ),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: <Widget>[
                //                 Checkbox(
                //                     value:
                //                         selectEventType.contains('Advertising'),
                //                     onChanged: (value) =>
                //                         changeSelectedSize('Advertising')),
                //                 Text('Advertising'),
                //               ],
                //             ), //row1
                //             SizedBox(
                //               height: 12.5,
                //             ),
                //             Divider(
                //               color: Colors.black,
                //             ),
                //             SizedBox(
                //               height: 12.5,
                //             ),
                //             Row(
                //               //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: <Widget>[
                //                 Container(
                //                   width:
                //                       MediaQuery.of(context).size.width * 0.3,
                //                   child: Text(
                //                     'Add a Price:',
                //                     style: TextStyle(
                //                       fontSize: 16,
                //                       fontStyle: FontStyle.normal,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                 ),
                //                 //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
                //                 Center(
                //                   child: Container(
                //                     width: MediaQuery.of(context).size.width *
                //                         0.45,
                //                     decoration: BoxDecoration(
                //                         color: Colors.grey.shade200),
                //                     child: TextFormField(
                //                       //initialValue: snapshot.data['price'],
                //                       // keyboardType: TextInputType.multiline,
                //                       //maxLength: 150,
                //                       //maxLines: 12,
                //                       keyboardType: TextInputType.number,
                //                       style: TextStyle(
                //                           fontWeight: FontWeight.w500),

                //                       decoration: InputDecoration(
                //                         border: InputBorder.none,
                //                         hintText: "The price be EGP Currency",
                //                       ),
                //                       validator: (input) {
                //                         if (input.isEmpty) {
                //                           return 'please type a price';
                //                         }
                //                       },
                //                       onSaved: (input) => _price = input,
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ), //row2
                //             SizedBox(
                //               height: 12.5,
                //             ),
                //             Divider(
                //               color: Colors.black,
                //             ),
                //             SizedBox(
                //               height: 12.5,
                //             ),

                //             Row(
                //               //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: <Widget>[
                //                 Container(
                //                   width:
                //                       MediaQuery.of(context).size.width * 0.3,
                //                   child: Text(
                //                     'BIO:',
                //                     style: TextStyle(
                //                       fontSize: 16,
                //                       fontStyle: FontStyle.normal,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                 ),
                //                 //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
                //                 Center(
                //                   child: Container(
                //                     width: MediaQuery.of(context).size.width *
                //                         0.45,
                //                     decoration: BoxDecoration(
                //                         color: Colors.grey.shade200),
                //                     child: TextFormField(
                //                       // initialValue:
                //                       //     snapshot.data['BIO Speaker'],
                //                       keyboardType: TextInputType.multiline,
                //                       maxLength: 150,
                //                       //maxLines: 12,
                //                       decoration: InputDecoration(
                //                         border: InputBorder.none,
                //                       ),
                //                       validator: (input) {
                //                         if (input.isEmpty) {
                //                           return 'please type a BIO';
                //                         }
                //                       },
                //                       onSaved: (input) => _bio = input,
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ), //row2
                //             SizedBox(
                //               height: 12.5,
                //             ),
                //             Divider(
                //               color: Colors.black,
                //             ),
                //             SizedBox(
                //               height: 12.5,
                //             ),

                //             Row(
                //                 //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: <Widget>[
                //                   Container(
                //                     width:
                //                         MediaQuery.of(context).size.width * 0.3,
                //                     child: Text(
                //                       'Experiance:',
                //                       style: TextStyle(
                //                         fontSize: 16,
                //                         fontStyle: FontStyle.normal,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ),
                //                   //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
                //                   Container(
                //                     width: MediaQuery.of(context).size.width *
                //                         0.45,
                //                     decoration: BoxDecoration(
                //                         color: Colors.grey.shade200),
                //                     child: TextFormField(
                //                       // initialValue: snapshot.data['experiance'],
                //                       decoration: InputDecoration(
                //                         border: InputBorder.none,
                //                       ),
                //                       validator: (input) {
                //                         if (input.isEmpty) {
                //                           return 'please type an Experiance';
                //                         }
                //                       },
                //                       onSaved: (input) => _experiance = input,
                //                     ),
                //                   ),
                //                 ]),
                //             //row4
                //             SizedBox(
                //               height: 12.5,
                //             ),
                //             Row(
                //                 //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: <Widget>[
                //                   Container(
                //                     width:
                //                         MediaQuery.of(context).size.width * 0.3,
                //                     child: Text(
                //                       'Num of Experiance:',
                //                       style: TextStyle(
                //                         fontSize: 16,
                //                         fontStyle: FontStyle.normal,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ),
                //                   //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
                //                   Container(
                //                       width: MediaQuery.of(context).size.width *
                //                           0.45,
                //                       decoration: BoxDecoration(
                //                           color: Colors.white54,
                //                           border: Border.all(
                //                             width:
                //                                 0.3, //                   <--- border width here
                //                           ),
                //                           borderRadius:
                //                               BorderRadius.circular(3)),
                //                       child: DropdownButton(
                //                         isExpanded: true,

                //                         icon: Icon(Icons.arrow_drop_down),
                //                         //  iconSize: 42,
                //                         underline: SizedBox(),
                //                         value: _btn11SelectedVal,
                //                         hint: Text('Num of Experiance:'),
                //                         onChanged: ((String newValue) {
                //                           setState(() {
                //                             _btn11SelectedVal = newValue;
                //                           });
                //                         }),
                //                         items: _dropDownnumOFexperiance,
                //                       )),
                //                 ]),
                //             SizedBox(
                //               height: 12.5,
                //             ),

                //             Divider(
                //               color: Colors.black,
                //             ),
                //             SizedBox(
                //               height: 12.5,
                //             ),
                //             Row(
                //               //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: <Widget>[
                //                 Container(
                //                   width:
                //                       MediaQuery.of(context).size.width * 0.3,
                //                   child: Text(
                //                     'Education:',
                //                     style: TextStyle(
                //                       fontSize: 16,
                //                       fontStyle: FontStyle.normal,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                 ),
                //                 //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
                //                 Container(
                //                     width: MediaQuery.of(context).size.width *
                //                         0.45,
                //                     decoration: BoxDecoration(
                //                         color: Colors.white54,
                //                         border: Border.all(
                //                           width:
                //                               0.3, //                   <--- border width here
                //                         ),
                //                         borderRadius: BorderRadius.circular(3)),
                //                     child: DropdownButton(
                //                       isExpanded: true,

                //                       icon: Icon(Icons.arrow_drop_down),
                //                       //  iconSize: 42,
                //                       underline: SizedBox(),
                //                       value: _btn5SelectedVal,
                //                       hint: Text(snapshot.data['education']),
                //                       onChanged: ((String newValue) {
                //                         setState(() {
                //                           _btn5SelectedVal = newValue;
                //                         });
                //                       }),
                //                       items: _dropDownselectUniversty,
                //                     )),
                //               ],
                //             ), //row4
                //             SizedBox(
                //               height: 12.5,
                //             ),

                //             Row(
                //               //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: <Widget>[
                //                 Container(
                //                   width:
                //                       MediaQuery.of(context).size.width * 0.3,
                //                   child: Text(
                //                     'Select Faculty:',
                //                     style: TextStyle(
                //                       fontSize: 16,
                //                       fontStyle: FontStyle.normal,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                 ),
                //                 //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
                //                 Container(
                //                     width: MediaQuery.of(context).size.width *
                //                         0.45,
                //                     decoration: BoxDecoration(
                //                         color: Colors.white54,
                //                         border: Border.all(
                //                           width:
                //                               0.3, //                   <--- border width here
                //                         ),
                //                         borderRadius: BorderRadius.circular(3)),
                //                     child: DropdownButton(
                //                       isExpanded: true,

                //                       icon: Icon(Icons.arrow_drop_down),
                //                       //  iconSize: 42,
                //                       underline: SizedBox(),
                //                       value: _btn8SelectedVal,
                //                       hint: Text('Select Faculty'),
                //                       onChanged: ((String newValue) {
                //                         setState(() {
                //                           _btn8SelectedVal = newValue;
                //                         });
                //                       }),
                //                       items: _dropDownselectedFaculty,
                //                     )),
                //               ],
                //             ), //row5
                //             SizedBox(
                //               height: 12.5,
                //             ),
                //             Divider(
                //               color: Colors.black,
                //             ),
                //             SizedBox(
                //               height: 12.5,
                //             ),
                //             Row(
                //               //ROW6
                //               //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: <Widget>[
                //                 Container(
                //                   width:
                //                       MediaQuery.of(context).size.width * 0.3,
                //                   child: Text(
                //                     'Facebook Url:',
                //                     style: TextStyle(
                //                       fontSize: 17,
                //                       fontStyle: FontStyle.normal,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                 ),
                //                 //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
                //                 Container(
                //                     width: MediaQuery.of(context).size.width *
                //                         0.45,
                //                     child: TextFormField(
                //                       initialValue:
                //                           snapshot.data['facebookUrl'],
                //                       decoration: InputDecoration(
                //                         border: InputBorder.none,
                //                       ),
                //                       validator: (input) {
                //                         if (input.isEmpty) {
                //                           return 'please type a Facebook URL';
                //                         }
                //                       },
                //                       onSaved: (input) => _facebookUrl = input,
                //                     )
                //                     // ),
                //                     ),
                //               ],
                //             ), //row6
                //             SizedBox(
                //               height: 12.5,
                //             ),
                //             Divider(
                //               color: Colors.black,
                //             ),
                //             SizedBox(
                //               height: 12.5,
                //             ),
                //             Row(
                //               //Row 7
                //               //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: <Widget>[
                //                 Container(
                //                   width:
                //                       MediaQuery.of(context).size.width * 0.3,
                //                   child: Text(
                //                     'Youtube Channel:',
                //                     style: TextStyle(
                //                       fontSize: 17,
                //                       fontStyle: FontStyle.normal,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                 ),
                //                 //  SizedBox(width: MediaQuery.of(context).size.width*0.3),

                //                 Container(
                //                     width: MediaQuery.of(context).size.width *
                //                         0.45,
                //                     child: TextFormField(
                //                       initialValue:
                //                           snapshot.data['youtubeChannel'],
                //                       decoration: InputDecoration(
                //                         border: InputBorder.none,
                //                       ),
                //                       validator: (input) {
                //                         if (input.isEmpty) {
                //                           return 'please type a Text';
                //                         }
                //                       },
                //                       onSaved: (input) =>
                //                           _youtubeChannel = input,
                //                     )
                //                     // ),
                //                     ),
                //               ],
                //             ), //row7
                //             SizedBox(
                //               height: 12.5,
                //             ),
                //             Divider(
                //               color: Colors.black,
                //             ),

                //             Row(
                //               //Row 8
                //               //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: <Widget>[
                //                 Container(
                //                   width:
                //                       MediaQuery.of(context).size.width * 0.3,
                //                   child: Text(
                //                     'schedule:',
                //                     style: TextStyle(
                //                       fontSize: 17,
                //                       fontStyle: FontStyle.normal,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                 ),
                //                 //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
                //                 RaisedButton(
                //                   child: Text("please select a work time"),
                //                   onPressed: () {
                //                     showDialog(
                //                         context: context,
                //                         builder: (_) => SomeCalendar(
                //                               mode: SomeMode.Multi,
                //                               startDate:
                //                                   Jiffy().subtract(years: 2),
                //                               lastDate: Jiffy().add(months: 9),
                //                               isWithoutDialog: false,
                //                               selectedDate: selectedDate,
                //                               selectedDates:
                //                                   d, ////////////////////////////////////
                //                               done: (date) {
                //                                 setState(() {
                //                                   print(selectedDates);
                //                                   finalDates = date;
                //                                 });
                //                               },
                //                             ));
                //                   },
                //                 ),
                //               ],
                //             ), //row8
                //             SizedBox(
                //               height: 12.5,
                //             ),
                //             Divider(
                //               color: Colors.black,
                //             ),

                //             Padding(
                //               padding: const EdgeInsets.only(top: 30.0),
                //               child: RawMaterialButton(
                //                 onPressed: () {
                //                   _speakerDone();
                //                 },
                //                 child: Padding(
                //                   padding: const EdgeInsets.symmetric(
                //                       vertical: 12.0),
                //                   child: Text(
                //                     'Done',
                //                     style: TextStyle(
                //                         color: Colors.white,
                //                         fontWeight: FontWeight.w400),
                //                   ),
                //                 ),
                //                 elevation: 6.0,
                //                 fillColor: Colors.blue,
                //                 shape: StadiumBorder(),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                /////////////////////////////////////////////////////////////////////START 2) SPEAKER PROFILE///////////////////////////////////////////////////////////////////////////
                Center(
                  // child: ( snapshot.data['address'] == 'khod')?ProfileFourPage():
                  // Text('please fill the information of the form paga')
                  child: (snapshot.data['education'] == null)
                      ? Text(
                          'Please Fill the Information of the Speaker Form Page')
                      : speakerProfile(),
                ),
                Center(
                  child: addplaces(),
                ),
                Center(
                  child: myplaces(),
                ),
              ],
            );
          }),
      bottomNavigationBar: StreamBuilder<Object>(
          initialData: 0,
          stream: indexcontroller.stream,
          builder: (context, snapshot) {
            int cIndex = snapshot.data;
            return FancyBottomNavigation(
              currentIndex: cIndex,
              items: <FancyBottomNavigationItem>[
                FancyBottomNavigationItem(
                    icon: Icon(Icons.group_add), title: Text('Be Speaker')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.person), title: Text('Spaeaker Profile')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.add_location), title: Text('Add Places')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.place), title: Text('My Places')),
              ],
              onItemSelected: (int value) {
                indexcontroller.add(value);
                pageController.jumpToPage(value);
              },
            );
          }),
    );
  }

  void _speakerDone() async {
    if (_formkey.currentState.validate()) {
      if (_btn8SelectedVal != null &&
          _btn5SelectedVal != null &&
          _btn11SelectedVal != null &&
          selectEventType.isNotEmpty &&
          finalDates.isNotEmpty) {
        _formkey.currentState.save();

        try {
          final FirebaseMessaging _fcm = FirebaseMessaging();
          _fcm.getToken().then((token) async {
            Firestore.instance.collection('user').document(user.uid) //user.uid
                .updateData({
              'eventType': _btn2SelectedVal,
              'BIO Speaker': _bio,
              'experiance': _experiance,
              'numofexperiance': _btn11SelectedVal,
              'education': _btn5SelectedVal,
              'selectFaculty': _btn8SelectedVal,
              'facebookUrl': _facebookUrl,
              'youtubeChannel': _youtubeChannel,
              'price': _price,
              "eventType": selectEventType,
              "speaker": "speaker",
              "token": token,
              'schedule': finalDates,
            });
          });

          // await uploadPic();
          /*
          await Firestore.instance
              .collection('user')
              .document(user.uid)
              .updateData({
            // 'eventType': _btn2SelectedVal,
            'BIO Speaker': _bio,
            'experiance': _experiance,
            'numofexperiance': _btn11SelectedVal,
            'education': _btn5SelectedVal,
            'selectFaculty': _btn8SelectedVal,
            'facebookUrl': _facebookUrl,
            'youtubeChannel': _youtubeChannel,
            'price': _price,
            "eventType": selectEventType,
            "speaker": "speaker",
            "token" : token ,
           
          });*/

          Toast.show("Form Saved", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

          //Todo: Navigate to home
        } catch (e) {
          // print(e);
          Toast.show("Error", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      } else {
        dialogTigger(context);
      }
    }
  }

  Future<bool> dialogTigger(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text(
              '',
              style: TextStyle(fontSize: 15.0),
            ),
            content: Text(
                'Please fill the information of the dropdown button And select a event type'),
            actions: <Widget>[
              new FlatButton(
                child: new Text('ok'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  void changeSelectedSize(String size) {
    if (selectEventType.contains(size)) {
      setState(() {
        selectEventType.remove(size);
      });
    } else {
      setState(() {
        selectEventType.insert(0, size);
      });
    }
  }
}

class FancyBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final double iconSize;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final List<FancyBottomNavigationItem> items;
  final ValueChanged<int> onItemSelected;

  FancyBottomNavigation(
      {Key key,
      this.currentIndex = 0,
      this.iconSize = 24,
      this.activeColor,
      this.inactiveColor,
      this.backgroundColor,
      @required this.items,
      @required this.onItemSelected}) {
    assert(items != null);
    assert(onItemSelected != null);
  }

  @override
  _FancyBottomNavigationState createState() {
    return _FancyBottomNavigationState(
        items: items,
        backgroundColor: backgroundColor,
        currentIndex: currentIndex,
        iconSize: iconSize,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        onItemSelected: onItemSelected);
  }
}

class _FancyBottomNavigationState extends State<FancyBottomNavigation> {
  final int currentIndex;
  final double iconSize;
  Color activeColor;
  Color inactiveColor;
  Color backgroundColor;
  List<FancyBottomNavigationItem> items;
  int _selectedIndex;
  ValueChanged<int> onItemSelected;

  _FancyBottomNavigationState(
      {@required this.items,
      this.currentIndex,
      this.activeColor,
      this.inactiveColor = Colors.black,
      this.backgroundColor,
      this.iconSize,
      @required this.onItemSelected}) {
    _selectedIndex = currentIndex;
  }

  Widget _buildItem(FancyBottomNavigationItem item, bool isSelected) {
    return AnimatedContainer(
      width: isSelected ? 124 : 50,
      height: double.maxFinite,
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              color: activeColor,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconTheme(
                  data: IconThemeData(
                      size: iconSize,
                      color: isSelected ? backgroundColor : inactiveColor),
                  child: item.icon,
                ),
              ),
              isSelected
                  ? DefaultTextStyle.merge(
                      style: TextStyle(color: backgroundColor),
                      child: item.title,
                    )
                  : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    activeColor =
        (activeColor == null) ? Theme.of(context).accentColor : activeColor;

    backgroundColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var index = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              onItemSelected(index);

              setState(() {
                _selectedIndex = index;
              });
            },
            child: _buildItem(item, _selectedIndex == index),
          );
        }).toList(),
      ),
    );
  }
}

class FancyBottomNavigationItem {
  final Icon icon;
  final Text title;

  FancyBottomNavigationItem({
    @required this.icon,
    @required this.title,
  }) {
    assert(icon != null);
    assert(title != null);
  }
}
