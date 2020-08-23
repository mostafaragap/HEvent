import 'package:HEvent/Profile/profile.dart';
import 'package:HEvent/scaning/subScan.dart';
import 'package:flutter/material.dart';



class SubScanPage extends StatefulWidget {
 
  String eventTitle1,eventPhoto;
  SubScanPage({this.eventTitle1,this.eventPhoto});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SubScanPage> { 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor:   Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
           Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>ProfileScreen ()));
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image(image: NetworkImage("https://media.istockphoto.com/vectors/qr-code-scan-phone-icon-in-comic-style-scanner-in-smartphone-vector-vector-id1166145556")),
            flatButton("Scan QR CODE",SubScan(eventTitle :widget.eventTitle1,eventPhoto: widget.eventPhoto)),
           
          ],
        ),
      ),
    );
  }

  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      color:Colors.black ,
      onPressed: () async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
      },
      child: Text(
        text,
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(color:Colors.black,width: 3.0),
          borderRadius: BorderRadius.circular(20.0)),
    );
  }
}

 