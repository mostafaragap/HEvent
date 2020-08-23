import 'package:HEvent/createEvent/eventName2.dart';
import 'package:HEvent/createEvent/placeList.dart';
import 'package:HEvent/createEvent/speaker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class eventName extends StatefulWidget {
//  String place;
  // eventName({this.place});
  List<String> places = new List<String>();
  eventName({this.places});
  @override
  _eventNameState createState() => _eventNameState();
}

class _eventNameState extends State<eventName> {
////////////////////////////////////////////////////list
  static const menuItems = <String>[
    'Educational',
    'Conference',
    'Marketing',
    'Workshops',
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

////////////////////////////////////////////////////////

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String name;
  String discrebtion;
  String budget;/////////////
  bool _checkBoxVal = false;
  /////////////////////////////////////////////date picker
  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

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
              Image.asset(
                'assets/logo2.png', /*width: 20,height: 20,*/
              ), ////// image
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
                      TextFormField(
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'please type event name';
                          }
                        },
                        onSaved: (input) => name = input,
                        // decoration: InputDecoration(
                        //   labelText: 'Email'
                        // ),
                        // keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            //suffixIcon: Icon(Icons.check),
                            hintText: 'Event Name',
                            labelText: 'Event Name',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400)),
                        // cursorWidth:100,
                      ), /////////////////////
                      SizedBox(
                        height: 35,
                      ),
                      //DropdownButtonExample(), /////////// list
                      ///////////////////////
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
                                value: _btn2SelectedVal,
                                hint: Text('Event Type:'),
                                onChanged: ((String newValue) {
                                  setState(() {
                                    _btn2SelectedVal = newValue;
                                  });
                                }),
                                items: _dropDownMenuItems,
                              )),
                        ],
                      ),
                      //////////////////////////////
                      TextFormField(
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'please type event description';
                          }
                        },
                        onSaved: (input) => discrebtion = input,
                        // decoration: InputDecoration(
                        //   labelText: 'Password'
                        // ),
                        //obscureText: true,
                        style: TextStyle(fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            //suffixText: 'Forget',
                            hintText: 'Description',
                            labelText: 'Description',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400)),
                        maxLines: 2,
                        //maxLength: 10,
                        //  maxLengthEnforced: true,
                      ), //////////////////
                      SizedBox(
                        height: 14,
                      ),
                       //////////////////////////////
                      TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'please type event budget';
                          }
                        },
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        onSaved: (input) => budget = input,
                        // decoration: InputDecoration(
                        //   labelText: 'Password'
                        // ),
                        //obscureText: true,
                        style: TextStyle(fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            //suffixText: 'Forget',
                            hintText: 'Budget',
                            labelText: 'Budget',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400)),
                      ), //////////////////
                      SizedBox(
                        height: 14,
                      ),
                      // ////////////////////date
                      // Text("${selectedDate.toLocal()}".split(' ')[0]),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                      // RaisedButton(
                      //   onPressed: () => _selectDate(context),
                      //   child: Text('Select date'),
                      // ),
                      // //////////////////

                      // SizedBox(
                      //   height: 14,
                      // ),
                      // FlatButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(builder: (context) => speaker()),
                      //     );
                      //   },
                      //   child: Text(
                      //     'Chosse sponser',
                      //     style: TextStyle(
                      //         color: Color(0xFFFD4F99),
                      //         fontWeight: FontWeight.w400),
                      //   ),
                      // ), ///////////////////////
                      // SizedBox(
                      //   height: 14,
                      // ),
                      // FlatButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => placelist()),
                      //     );
                      //   },
                      //   child: Text(
                      //     'Chosse place',
                      //     style: TextStyle(
                      //         color: Color(0xFFFD4F99),
                      //         fontWeight: FontWeight.w400),
                      //   ),
                      // ), ////////////////////
                      //  Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     FlatButton(
                      //       onPressed: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => placelist()),
                      //         );
                      //       },
                      //       child: Text(
                      //         'Chosse place',
                      //         style: TextStyle(
                      //             color: Color(0xFFFD4F99),
                      //             fontWeight: FontWeight.w400),
                      //       ),
                      //     ), ////////////////////
                      //     Text('.'),
                      //   ],
                      // ),

                      // Divider(
                      //   height: 5,
                      //   color: Colors.black,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: RawMaterialButton(
                          onPressed: () {
                            Next();
                            //  print(widget.places);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Next',
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
                    ],
                  ),
                ),
              ),
              /////////////////////
            ]),
          ),
        ),
      ),
    ));
  }

  Future<void> Next() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      try {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => eventName2(
                    name: this.name,
                    discrebtion: this.discrebtion,
                    trak: this._btn2SelectedVal,
                    plaace_done: ".",
                    speaker_done: ".",
                    budget : this.budget,
                   // places: widget.places,
                  )),
        );
      } catch (e) {}
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////
// class DropdownButtonExample extends StatefulWidget {
//   const DropdownButtonExample({Key key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _DropdownButtonExampleState();
// }

// class _DropdownButtonExampleState extends State<DropdownButtonExample> {
//   static const menuItems = <String>[
//     'Ai',
//     'Marketing',
//     'Discovering',
//   ];
//   final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
//       .map(
//         (String value) => DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         ),
//       )
//       .toList();
//   final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
//       .map(
//         (String value) => PopupMenuItem<String>(
//           value: value,
//           child: Text(value),
//         ),
//       )
//       .toList();

//   String _btn1SelectedVal = 'One';
//   String _btn2SelectedVal;
//   String _btn3SelectedVal;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         // ListTile(
//         //   title: Text('Track Name:'),
//         //   trailing: DropdownButton(
//         //     value: _btn2SelectedVal,
//         //     hint: Text('Choose'),
//         //     onChanged: ((String newValue) {
//         //       setState(() {
//         //         _btn2SelectedVal = newValue;
//         //       });
//         //     }),
//         //     items: _dropDownMenuItems,
//         //   ),
//         //),
//         //Text('Track name'),
//         Container(
//             width: 310,
//             decoration: BoxDecoration(
//                 color: Colors.white54,
//                 border: Border.all(
//                   width: 0.3, //                   <--- border width here
//                 ),
//                 borderRadius: BorderRadius.circular(3)),
//             child: DropdownButton(
//               isExpanded: true,

//               icon: Icon(Icons.arrow_drop_down),
//               //  iconSize: 42,
//               underline: SizedBox(),
//               value: _btn2SelectedVal,
//               hint: Text('Track name:'),
//               onChanged: ((String newValue) {
//                 setState(() {
//                   _btn2SelectedVal = newValue;
//                 });
//               }),
//               items: _dropDownMenuItems,
//             )),
//       ],
//     );
//   }
// }
