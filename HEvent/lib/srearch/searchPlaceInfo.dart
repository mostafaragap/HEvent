
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class searchPlaceInfo extends StatefulWidget {
  String title,
      photo,
      address,
      
      desciption,
      docID,
      userID;
      int price;
      List<dynamic> images= [];
   int capacity;
  String stat;
  searchPlaceInfo({
    this.photo,
    this.title,
    this.address,
    this.capacity,
    this.desciption,
    this.docID,
    this.userID,
    this.stat,
    this.images,
    this.price
  });
  @override
  _searchPlaceInfoState createState() => _searchPlaceInfoState();
}

class _searchPlaceInfoState extends State<searchPlaceInfo> {
  static final String path = "lib/src/pages/bike/bike_details.dart";
  final TextStyle bold = TextStyle(fontWeight: FontWeight.bold);

  FirebaseUser user;
  Future<void> getUser() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      print(user.uid);
    });
  }

  @override
 initState() {
    super.initState();
    print(widget.images[0]);
    print(widget.images[1]);
    
    
  }
  
  Choose() async {
    
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  await prefs.setString('place', widget.title);
  await prefs.setString('owner', widget.userID);
  await prefs.setString('address', widget.address);
  print(widget.title);
  Toast.show("Done", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
  Navigator.pop(context,);
}


  @override
  Widget build(BuildContext context) {
    final String title = widget.title;
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(title),
        //   elevation: 0,
        // ),
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 250,
                      width: double.infinity,
                      // child: PNetworkImage(
                      //   bike,
                      //   fit: BoxFit.cover,
                      // )
                      child:     Container(
            //  height: 300,
            //  color: Colors.grey.shade800,
             // padding: EdgeInsets.all(16.0),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                  //  borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      widget.images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
                itemCount: 3,
                //viewportFraction: 0.8,
                scale: 0.9,
                pagination: SwiperPagination(),
              ),
            ),
                    ),
                    
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                        child: Text(
                          "Key Specs",
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            SpecsBlock(
                              label: "Capacity",
                              value: widget.capacity.toString(),
                              icon: Icon(
                                Icons.apps,
                              ),
                            ),
                            
                            SpecsBlock(
                              label: "status",
                              value: "avalible",
                              icon: Icon(
                                Icons.help_outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                        child: Text(
                          "Details",
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      ///////////////////////////////
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Name:',
                              style: TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                widget.title,
                                style: bold,
                                textAlign: TextAlign.left,
                                //softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ///////////////////////////////////
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Address:',
                              style: TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                widget.address,
                                style: bold,
                                textAlign: TextAlign.left,
                                //softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ////////////////////////////////
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Capacity:',
                              style: TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                widget.capacity.toString(),
                                style: bold,
                                textAlign: TextAlign.left,
                                //softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ////////////////////////////////////////
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Price:',
                              style: TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                widget.price.toString(),
                                style: bold,
                                textAlign: TextAlign.left,
                                //softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      /////////////////////////////////////////
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Description:',
                              style: TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                widget.desciption,
                                style: bold,
                                textAlign: TextAlign.left,
                                //softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // BorderedContainer(
                      //   margin: const EdgeInsets.symmetric(
                      //     vertical: 4.0,
                      //   ),
                      //   padding: const EdgeInsets.all(0),
                      //   child: ListTile(
                      //     title: Text("Seat height"),
                      //     trailing: Text(
                      //       "700 mm",
                      //       style: bold,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: RaisedButton.icon(
          //     color: Colors.green,
          //     textColor: Colors.white,
          //     icon: Icon(Icons.add),
          //     label: Text('Choose'),
          //     onPressed: () {
          //      Choose();
          //     },
          //   ),
          // )
        ],
      ),
    ));
  }
}

class BorderedContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final double height;
  final double width;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color color;
  final double elevation;

  const BorderedContainer({
    Key key,
    this.title,
    this.child,
    this.height,
    this.padding,
    this.margin,
    this.color,
    this.width = double.infinity,
    this.elevation = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      margin: margin ?? const EdgeInsets.all(0),
      child: Container(
        padding: padding ?? const EdgeInsets.all(16.0),
        width: width,
        height: height,
        child: title == null
            ? child
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
                  ),
                 // if (child != null) ...[const SizedBox(height: 10.0), child]
                 SizedBox(height: 10.0),
                ],
              ),
      ),
    );
  }
}

class SpecsBlock extends StatelessWidget {
  const SpecsBlock({
    Key key,
    this.icon,
    this.label,
    this.value,
  }) : super(key: key);

  final Widget icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            icon,
            const SizedBox(height: 2.0),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
