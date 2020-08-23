import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HEvent/createEvent/placeList.dart';
import 'package:HEvent/createEvent/speaker.dart';
import 'package:HEvent/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:HEvent/createEvent/paymentWithEmail.dart';

import '../Home.dart';

class eventName2 extends StatefulWidget {
  String name, discrebtion, trak, plaace_done = "", speaker_done = "";
  String budget;
  // eventName({this.place});
  List<String> places = new List<String>();
  eventName2(
      {this.places,
      this.name,
      this.discrebtion,
      this.trak,
      this.plaace_done,
      this.speaker_done,
      this.budget
      });
  @override
  _eventName2State createState() => _eventName2State();
}
enum Answers{Close}
class _eventName2State extends State<eventName2> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String  placeD = ".", speakerD = ".";
  String budget;///////////////
  var navigationResult;
  int capacity;

  var place_owner =[];

//   void initState() {
//   setState(() {
//         placeD = widget.plaace_done;
//         speakerD= widget.speaker_done;
//       });
// }
  //var initial_size = 5;
  //var app_list = new List();
  SharedPreferences pref;
  var placeName = "non";
  int placePrice=0 , speakerPrice=0, totalPrice=0;

  get async => null;
  loadData() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      placeName = pref.getString('place');
      // placePrice= pref.getInt('placePrice');
      // speakerPrice = pref.getInt('speaker_price');/////////////
      totalPrice = placePrice+ speakerPrice;
    });
    return placeName;
  }

  FirebaseUser user;
  Future<void> getUser() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      print(user.uid);
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    getUser();
  }

  ///////////////////////////////////////photo
  File image;

  picker() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    // File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      //image = img;
      setState(() {
        image = img;
        // filename = basename(image.path);
      });
    }
  }

  String URL = "";

  Future uploadPic() async {
    final String filename = p.basename(image.path);
    final FirebaseStorage storage =
        FirebaseStorage(storageBucket: 'gs://finalecommerce-823b1.appspot.com');
    // StorageReference reference = FirebaseStorage.instance.ref().child(filename);
    StorageReference reference =
        storage.ref(). /*child('giftShopItems').*/ child(filename);
    StorageUploadTask upload = reference.putFile(image);

    var downurl = await (await upload.onComplete).ref.getDownloadURL();
    setState(() {
      this.URL = downurl.toString();
      print(this.URL);
      print(filename);
    });
  }

  ///.//////////////////////////////////

////////////////////////////date
  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 3),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  //////////////////////////////////
  ///
  ///////////////////////////////////////////////////////list
  static const Conference = <String>[
    'Private',
    'Public',
  ];
  static const Educational = <String>[
    'Deep Learning',
    'Machine Learning',
    'IOT',
    'Reinforcement Learning',
    'Big Data',
  ];
  static const Marketing = <String>[
    'Offline Marketing',
    'Digital Marketing',
    'Social Media',
    'Business',
    'Finance',
  ];
  static const Soft_Skills = <String>[
    'Presentation Skills',
    'Commincation Skills',
    'emotional Skills',
    'Negotiation Skills',
    'Conflict resolution Skills',
  ];
  final List<DropdownMenuItem<String>> _dropDownConference = Conference
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  final List<DropdownMenuItem<String>> _dropDownEducational = Educational
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
 final List<DropdownMenuItem<String>> _dropDownMarketing = Marketing
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
final List<DropdownMenuItem<String>> _dropDownSoft_Skills = Soft_Skills
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  String _btn1SelectedVal = 'One';
  String _btn2SelectedVal;
  String _btn3SelectedVal;

////////////////////////////////////////////////////////
//////////////////////////////////////////////////////Capacity list
  static const menuItems = <int>[
    50,
    100,
    150,
    200,
    250,
    300,
    350,
    400,
    450,
    500,
    550,
    600,
    650,
    700,
    750,
    800,
    850,
    900,
    950,
    1000,
  ];
  final List<DropdownMenuItem<int>> _capacityMenuItems = menuItems
      .map(
        (int value) => DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        ),
      )
      .toList();

  String Ccapacity;

////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Create Event'),
        //   backgroundColor: Colors.white,
        //   elevation: 0.0,

        // ),
        body: SafeArea(
      child: SingleChildScrollView(
        /////////////////////////////// scroll view
        scrollDirection: Axis.vertical, /////////////////
        child: Container(
          ////////first container
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Container(
            ///////second container
            //width:100,
            //color: Colors.orange,
            child: Column(children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Stack(
                children: <Widget>[
                  //    Image.asset(
                  //   'assets/logo.png', /*width: 20,height: 20,*/
                  // ),
                  (image != null)
                      ? Image.file(
                          image,
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          'assets/logo2.png', /*width: 20,height: 20,*/
                        ),
                  Positioned(
                    right: 40,
                    bottom: 7,
                    child: FlatButton(
                      onPressed: () {
                        picker();
                      },
                      child: Text(
                        'Select photo',
                        style: TextStyle(
                            color: Color(0xFFFD4F99),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
              ////// image

              SizedBox(
                height: 0,
              ),
              Padding(
                padding: EdgeInsets.all(23),
                child: Form(
                  ///////////////////////////////////// form
                  key: _formkey, //el mas2ol 3n save form
                  child: Column(
                    children: <Widget>[
                      //bktb t7teeh el design
                      // TextFormField(
                      //   keyboardType: TextInputType.number,
                      //   validator: (input) {
                      //     if (input.isEmpty) {
                      //       return 'please type event capacity';
                      //     }
                      //   },
                      //   onSaved: (input) => capacity = input,
                      //   // decoration: InputDecoration(
                      //   //   labelText: 'Password'
                      //   // ),
                      //   //obscureText: true,
                      //   style: TextStyle(fontWeight: FontWeight.w500),
                      //   decoration: InputDecoration(
                      //       //suffixText: 'Forget',
                      //       hintText: 'Capacty',
                      //       labelText: 'Capacty',
                      //       labelStyle: TextStyle(fontWeight: FontWeight.w400)),
                      // ),
                      SizedBox(
                        height: 35,
                      ),

                    Padding(padding:EdgeInsets.only(right: 270),
                      child: Text('Capacity')
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(

                        children: <Widget>[
                          Container(
                              width: 310,
                              decoration: BoxDecoration(
                                  color: Colors.white54,
                                  border: Border.all(
                                    width:
                                        0.3, //                   <--- border width here
                                  ),
                                  borderRadius: BorderRadius.circular(3)),
                              child: DropdownButton(
                                isExpanded: true,

                                icon: Icon(Icons.arrow_drop_down),
                                //  iconSize: 42,
                                underline: SizedBox(),
                                value: capacity,
                                hint: Text('capacity'),
                                onChanged: ((int newValue) {
                                  setState(() {
                                    capacity = newValue;
                                  });
                                }),
                                items: _capacityMenuItems,
                              )),
                        ],
                      ),
                       SizedBox(
                        height: 35,
                      ), 
                       Row(//////////////////////////////////////
                        children: <Widget>[
                          Container(
                              width: 310,
                              decoration: BoxDecoration(
                                  color: Colors.white54,
                                  border: Border.all(
                                    width:
                                        0.3, //                   <--- border width here
                                  ),
                                  borderRadius: BorderRadius.circular(3)),
                              child: DropdownButton(
                                isExpanded: true,

                                icon: Icon(Icons.arrow_drop_down),
                                //  iconSize: 42,
                                underline: SizedBox(),
                                value: _btn2SelectedVal,
                                hint: Text('Track name:'),
                                onChanged: ((String newValue) { 
                                  setState(() {
                                    _btn2SelectedVal = newValue;
                                  });
                                }),
                                items: (widget.trak == "Educational")?_dropDownEducational
                                :(widget.trak == "Conference")?_dropDownConference
                                :(widget.trak == "Marketing")?_dropDownMarketing
                                :_dropDownSoft_Skills
                              )
                              ),
                        ],
                      ),
                      //////////////////////////////
                      // TextFormField(
                      //   keyboardType: TextInputType.number,
                      //   validator: (input) {
                      //     if (input.isEmpty) {
                      //       return 'please type event budget';
                      //     }
                      //   },
                      //   onSaved: (input) => budget = input,
                      //   // decoration: InputDecoration(
                      //   //   labelText: 'Password'
                      //   // ),
                      //   //obscureText: true,
                      //   style: TextStyle(fontWeight: FontWeight.w500),
                      //   decoration: InputDecoration(
                      //       //suffixText: 'Forget',
                      //       hintText: 'Budget',
                      //       labelText: 'Budget',
                      //       labelStyle: TextStyle(fontWeight: FontWeight.w400)),
                      // ), //////////////////

                      SizedBox(
                        height: 14,
                      ),

                      ////////////////////date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () => _selectDate(context),
                            child: Text(
                              'Select date',
                              style: TextStyle(
                                  color: Color(0xFFFD4F99),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Text("${selectedDate.toLocal()}".split(' ')[0]),
                        ],
                      ),
                      Divider(
                        height: 5,
                        color: Colors.black,
                      ),
                      //////////////////

                      SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                navigationResult = Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => speaker(budget: widget.budget,
                                       date:this.selectedDate,
                                       track : _btn2SelectedVal,
                                      )),
                                );
                              });
                            },
                            child: Text(
                              'Chosse speaker',
                              style: TextStyle(
                                  color: Color(0xFFFD4F99),
                                  fontWeight: FontWeight.w400),
                            ),
                          ), ///////////////////////
                          Text(speakerD),
                        ],
                      ),

                      Divider(
                        height: 5,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => placelist(
                                       budget: widget.budget,
                                       date:this.selectedDate,
                                       placeCapacity:capacity,
                                    )),
                              );
                              
                            },
                            child: Text(
                              'Chosse place',
                              style: TextStyle(
                                  color: Color(0xFFFD4F99),
                                  fontWeight: FontWeight.w400),
                            ),
                          ), ////////////////////
                          Text(placeD),
                        ],
                      ),

                      Divider(
                        height: 5,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: RawMaterialButton(
                          onPressed: () async {
                            // Navigator.push(
                            // context,
                            // MaterialPageRoute(builder: (context) => speaker()),
                            // );
                            
                             creat();
                            
                            print(widget.places);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Create',
                              style: TextStyle(
                                  color: Color(0xFFFD4F99),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          elevation: 6.0,
                          fillColor: Colors.black,
                          shape: StadiumBorder(),
                        ),
                      ),
                      //////////////////
                     
                    ],
                  ),
                ),
              ),
              /////////////////////
              ///
              
            ]),
          ),
        ),
      ),
    ));
  }
  String _value = '';

  void _setValue(String value) => setState(() => _value = value);
  Future _askUser() async {
    
    switch(
      await showDialog(
        context: context,
        child: new SimpleDialog(
          title: new Text("Event created succecfully"),
          children: <Widget>[
            new SimpleDialogOption(
              child: new Text("Close"),
              onPressed: (){
                Navigator.pop(context, Answers.Close);
              },
            ),
           
          ],
        )
      )
    ) {
      case Answers.Close:
        _setValue('ok');
        break;
    
    }
  }
  

 
  Future<void> creat() async {
    List<String> splitname = widget.name.split(" ");
    List<String> indexList = [];
    final FirebaseMessaging _fcm = FirebaseMessaging();
    var docref;
    
   
    
    for (int i = 0; i < splitname.length; i++) {
      for (int y = 1; y < splitname[i].length + 1; y++) {
        indexList.add(splitname[i].substring(0, y).toLowerCase());
      }
    }
     
    Toast.show("Please Wait", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
       try {
        //await uploadPic();
        if(image != null){
         //this.URL = "https://media.discordapp.net/attachments/610965971213090838/693213588558446602/logo.png";
        await uploadPic();///////////////
       setState(() {
         // place_owner = pref.getString('place_owner') as List;
       });
       
      docref =   await Firestore.instance.collection('Events').add({
          'name': widget.name,
          'decription': widget.discrebtion,
          'trakName': this._btn2SelectedVal,
          'capacity': this.capacity,
          'image': this.URL,
          'date': "${selectedDate.toLocal()}".split(' ')[0],
         // 'status': selectedDate,
          'address': pref.getString('address'),
          'place': pref.getString('place'),
          'serchIndex': indexList,
          'owner': user.uid,
          'speaker': pref.getStringList('speaker'),
          'speakers_id' :pref.getStringList('speaker_Id'),
          "place_owner" :  pref.getStringList('place_owner')
          
          
        });
        }else{
          docref = await Firestore.instance.collection('Events').add({
          'name': widget.name,
          'decription': widget.discrebtion,
          'trakName': this._btn2SelectedVal,
          'capacity': this.capacity,
          'image': "https://media.discordapp.net/attachments/610965971213090838/726270617988497418/received_284402816251642.png?width=434&height=434",
          'date': "${selectedDate.toLocal()}".split(' ')[0],
         // 'status': selectedDate,
          'address': pref.getString('address'),
          'place': pref.getString('place'),
          'serchIndex': indexList,
          'owner': user.uid,
          'speaker': pref.getStringList('speaker'),
          'speakers_id' :pref.getStringList('speaker_Id'),
          "place_owner" : pref.getStringList('place_owner')
          
        });

       }
        _askUser();
        /////////////////////////////////////notification
        await Firestore.instance.collection('notification').document().setData({
          'User_Id': user.uid,
         'trakName': this._btn2SelectedVal,
          'Event_Id': docref.documentID,
          'speaker': pref.getStringList('speaker'),
          'Event_name': widget.name,
          'place': pref.getString('place'),
          'date': "${selectedDate.toLocal()}".split(' ')[0],
            'capacity': this.capacity,
            'address': pref.getString('address'),
            'decription': widget.discrebtion,
           'image': "https://media.discordapp.net/attachments/610965971213090838/726270617988497418/received_284402816251642.png?width=434&height=434",
           'speakers_id' :pref.getStringList('speaker_Id'),
           "place_owner" : pref.getStringList('place_owner')
          
        });
        // await Firestore.instance.collection('Speaker_notifications').document().setData({
        //   'User_Id': pref.getString('owner'),
        //   'trakName': this._btn2SelectedVal,
        //   'Event_Id': docref.documentID,
        //   'speaker': pref.getStringList('speaker'),
        //   'Event_name': widget.name,
        //   'place': pref.getString('place'),
        //   'capacity': this.capacity,
        //   'address': pref.getString('address'),
        //   'decription': widget.discrebtion,
        //   'image': "https://media.discordapp.net/attachments/610965971213090838/726270617988497418/received_284402816251642.png?width=434&height=434",
        // });
        /////////////////////
        /////////////////////////update num of toipci
        // var firestore = Firestore.instance;
        // var data = await firestore.collection('tracks').where("track",isEqualTo: widget.trak).getDocuments();
        // var productList = data.documents;
        // print("Data length: ${productList.length}");
        // //productList.length++;
      
        // await Firestore.instance
        //       .collection('tracks')
        //       //.where("trakName",isEqualTo: widget.trak)
        //       .document("")
        //       .updateData({
        //       'num':productList.length,
        //       });
        //////////////////////////////////////////////////////
        ///
         
       placePrice= pref.getInt('placePrice');
       speakerPrice = pref.getInt('speaker_price');
       totalPrice = placePrice+ speakerPrice;

        print(widget.places);
        Navigator.of(context).pop();
        
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PaymentEmail(totalPrice: totalPrice,)));
       

        //Todo: Navigate to home
      } catch (e) {
        print(e.message);
        Toast.show("Error", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }
}
