import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '../Home.dart';

class PaymentEmail extends StatefulWidget {
  int totalPrice;
  PaymentEmail({
    this.totalPrice,
  });
  @override
  PaymentState createState() => PaymentState();
}

class PaymentState extends State<PaymentEmail> {
  final GlobalKey<FormState> formStatekey = GlobalKey<FormState>();
  String _name, _number, _date, _code; // _zipcode;
  String _dattaname, _dattanumber, _dattanamedate, _dattacode; //_dattazipcode;
  String ownerEmail;

  FirebaseUser user;
  Future<void> getUser() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      ownerEmail = user.email;
    });
    print(user.email);
    print("/////////////////////////////////////////////////////////////");
  } //////////////////////////////////////////////////////////////get user id

  _showdiaiog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                'your payment succeded...',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              content: Text(
                'you will recive a confirmation message please check your email',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              contentPadding: EdgeInsets.all(100),
              backgroundColor: Colors.deepPurple,
              elevation: 30.2,
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    // Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FancyBottomBarPage()));
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )
              ],
            ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  void sendMail(String owneremail) async {
    String body = '<h1> Hello sir</h1>' +
        '<h3> congratulation sir , your payment succeded </h3>' +
        '<center><h3>your payment details </h3></center>' +
        '<center><p> $_dattaname </p></center>' +
        '<center><p> $_dattanumber </p></center>' +
        '<center><p> $_dattanamedate </p></center>' +
        // '<center><p> $_dattazipcode</p></center>' +
        '<h3>If you do not cancel your reservation  befor 5 days ,you agree that you will automatically be charged</h3>' +
        '<p> ${DateTime.now()}</p>';
    String username = 'ahmedshtat70@gmail.com';
    String password = 'a 50a 50a 50';
    final stmpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'shtat')
      ..recipients.add(user.email)
      ..subject = 'Ｈ 𝒆ν𝑒Ňⓣ'
      ..html = body;

    try {
      final sendReport = await send(message, stmpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0.0,
          title: Text(
            'payment',
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ),
        body: ListView(children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(children: <Widget>[
                SizedBox(
                  height: 40,
                  width: 10,
                ),
                Material(
                    color: Colors.white,
                    elevation: 50.0,
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      child: Center(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  // height: 600,
                                  margin: EdgeInsets.only(left: 20.0),
                                  child: Center(
                                    child: Row(children: <Widget>[
                                      Text(
                                        'payment amount',
                                        style: TextStyle(
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        widget.totalPrice.toString(),
                                        style: TextStyle(
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ]),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Form(
                                        key: formStatekey,
                                        child: Column(children: <Widget>[
                                          TextFormField(
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              hintText: 'card name',
                                              suffixIcon: Icon(
                                                  Icons.credit_card,
                                                  color: Colors.black),
                                            ),
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return 'please enter the name';
                                              }
                                            },
                                            onSaved: (val) => _name = val,
                                          ),
                                          SizedBox(
                                            height: 10,
                                            width: 10,
                                          ),
                                          TextFormField(
                                             keyboardType: TextInputType.number,
                                             maxLength: 16,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              hintText: 'card number',
                                              suffixIcon: Icon(Icons.lock,
                                                  color: Colors.black),
                                            ),
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return 'please enter the card  number';
                                              } else if (val.length < 16 ) {
                                                return 'the number is short number';
                                              } 
                                            },
                                            onSaved: (val) => _number = val,
                                          ),
                                          SizedBox(
                                            height: 10,
                                            width: 10,
                                          ),
                                          TextFormField(
                                             keyboardType: TextInputType.number,
                                             maxLength: 7,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              hintText: 'ex date like 06-2020',
                                              suffixIcon: Icon(Icons.date_range,
                                                  color: Colors.black),
                                            ),
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return 'please enter the date';
                                              } else if (val.length < 7) {
                                                return 'please enter the correct date';
                                              }
                                            },
                                            onSaved: (val) => _date = val,
                                          ),
                                          SizedBox(
                                            height: 10,
                                            width: 10,
                                          ),
                                          TextFormField(
                                         keyboardType: TextInputType.number,
                                         maxLength: 3,

                                            obscureText: true,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              hintText: 'CVV',
                                              suffixIcon: Icon(
                                                  Icons.not_listed_location,
                                                  color: Colors.black),
                                            ),
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return 'please enter your Cvv';
                                              } else if (val.length < 3) {
                                                return 'the Cvv is short8';
                                              }
                                            },
                                            onSaved: (val) => _code = val,
                                          ),
                                          SizedBox(
                                            height: 10,
                                            width: 10,
                                          ),
                                          // TextFormField(
                                          //   decoration: InputDecoration(
                                          //     enabledBorder: OutlineInputBorder(
                                          //         borderSide: BorderSide(
                                          //             color:
                                          //                 Colors.deepPurple)),
                                          //     hintText: 'ZIP/postal code',
                                          //     suffixIcon: Icon(
                                          //       Icons.near_me,
                                          //       color: Colors.deepPurple,
                                          //     ),
                                          //   ),
                                          //   validator: (String val) {
                                          //     if (val.isEmpty) {
                                          //       return 'please enter the your postal code';
                                          //     }
                                          //   },
                                          //   onSaved: (val) => _zipcode = val,
                                          // ),
                                          SizedBox(
                                            height: 10,
                                            width: 10,
                                          ),
                                          RaisedButton(
                                            padding: EdgeInsets.all(15.0),
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.black,
                                                    width: 3.0),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            child: Text('PayNow'),
                                            color: Colors.black,
                                            textColor: Colors.white,
                                            onPressed: () {
                                              if (!formStatekey.currentState
                                                  .validate()) {
                                                return;
                                              }
                                              formStatekey.currentState.save();
                                              setState(() {
                                                _dattaname = _name;
                                                _dattanumber = _number;
                                                _dattanamedate = _date;
                                                _dattacode = _code;
                                                //   _dattazipcode = _zipcode;
                                              });
                                              sendMail(ownerEmail);
                                              _showdiaiog();
                                            },
                                          ),
                                        ])))
                              ]))),
                    ))
              ]))
        ]));
  }
}
