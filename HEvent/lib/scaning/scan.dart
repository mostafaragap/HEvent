

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './attenndes.dart';
import './scanpage.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Scan extends StatefulWidget {
   String title,photo;
  Scan({this.title,this.photo});
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<Scan> {
  CrudFire crud = new CrudFire();
  addContact() {
    crud.create({
      'userID':  userid ,
      'eventtitle': widget.title,
      'eventphoto' :widget.photo,
      });
  }

  String accept = 'Status';
  String result = 'founded';
  String result2 = 'not founded';
  String eventtitle, userid;
  String qrCodeResult = "Not Yet Scanned";

  Future compareContact() async {
    var firestore = Firestore.instance;

    var qn = await firestore
        .collection('join_event')
        .where("title", isEqualTo: widget.title)
        .where("user", isEqualTo: userid)
        .getDocuments();

    if (qn.documents.length == 1) {
      print(qn.documents.length);
      print('we have this doc');
      addContact();
      setState(() {
        accept = result;
      });
    } else {
      print('we  dont have this doc');
      setState(() {
        accept = result2;
      });
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
          Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) =>ScanPage() ));
          },
        ),
        title: Text('Scan',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Colors.black)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_box, color: Colors.black),
            onPressed: () async {
              Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context)=>Attenneds(eventtitle :widget.title,)));
            
            },
          ),
        ],
      ),
      body: ListView(children: [
        SizedBox(height: 50.0),
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(accept,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        SizedBox(height: 130.0),
        Center(
          child: Text('member information',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        SizedBox(height: 35.0),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text(qrCodeResult,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    color: Colors.black)),
          ),
        ),
        SizedBox(height: 150.0),
        Center(
            child: Container(
          width: MediaQuery.of(context).size.width - 50.0,
          height: 50.0,
          child: FlatButton(
            color: Colors.black,
            padding: EdgeInsets.all(15.0),
            onPressed: () async {
          // String codeSanner = await BarcodeScanner.scan(); //barcode scnner
        String codeSanner = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true,ScanMode.QR);
              setState(() {
                qrCodeResult = codeSanner;
              });
              //
              int i, count;
              List<String> tit;
              List<String> d;
              for (i = 0; i < qrCodeResult.length; i++) {
                if (qrCodeResult[i] != '/') {
                } else {
                  setState(() {
                    count = i++;
                  });
                  break;
                }
              }
              setState(() {
                userid = qrCodeResult.substring(0, count--);
                eventtitle =
                    qrCodeResult.substring(count + 2, qrCodeResult.length);
              });
              print(userid);
              print(eventtitle);
              compareContact();
            },
            child: Text(
              "Open Scanner",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Varela',
                fontSize: 18.0,
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
          ),
        ))
      ]),
    );
  }
}

class CrudFire {
  Future<void> create(data) async {
    Firestore.instance.collection('attendees').add(data);
  }
}
