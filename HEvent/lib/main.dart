import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HEvent/QR/profile.dart';
import 'package:HEvent/QR/qrGenerete.dart';
import 'package:HEvent/QR/qrScann.dart';
import 'package:HEvent/createEvent/placeInfo.dart';
import 'package:HEvent/createEvent/placeList.dart';
import 'package:HEvent/createEvent/speaker.dart';
import 'package:HEvent/homeExplore/explore.dart';
import 'package:HEvent/homeExplore/moreExplore.dart';
import 'package:HEvent/homeExplore/search.dart';
import 'package:HEvent/homePage.dart';
import 'package:HEvent/pages/setup/Interests.dart';
import 'package:HEvent/QR/profile.dart';
import 'package:flutter/material.dart';
import 'package:HEvent/Pages/Setup/welcome.dart';

import 'Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,/////
        //    debugShowMaterialGrid: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: welcomePage(),
    // home: addplaces(),
    );
  }
}


class searchkey extends StatefulWidget {
  @override
  _searchkeyState createState() => _searchkeyState();
}

class _searchkeyState extends State<searchkey> {
  String q="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add '),
      ),
      body: Container(
      child:Column(
        children: <Widget>[
               TextField(
                onChanged: (Value) {
                    setState(() {
                      this.q = Value;
                     });
                  }
              ),
             SizedBox(
               height: 10,
             ),
             FlatButton(
              onPressed: (){
                add(this.q);
              }, 
             child: Text('add'))

        ],
      )
      
    ),
    );
  }
   void add(String name){
     List<String>splitname= name.split(" ");
     List<String>indexList = [];

     for(int i =0; i < splitname.length; i++){
       for(int y=1; y < splitname[i].length+1; y++){
          indexList.add(splitname[i].substring(0,y).toLowerCase());
       }

     }
     print(indexList);

     Firestore.instance
     .collection('category')
     .document()
     .setData({'title':name,'serchIndex':indexList});
   }
}