import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class speaker_Requests extends StatefulWidget {
  String title,
      photo,
      address,
      capacity,
      place,
      desciption,
      date,
      status,
      docID,
      speaker,
      userID,
      owner,
      track;

  bool favo, join;

  var color;
  String stat;

  speaker_Requests(
      {this.photo,
      this.title,
      this.address,
      this.capacity,
      this.desciption,
      this.place,
      this.date,
      this.status,
      this.docID,
      this.favo,
      this.join,
      this.color,
      this.userID,
      this.stat,
      this.speaker,
      this.track,
      this.owner});
  @override
  _speaker_RequestsState createState() => _speaker_RequestsState();
}

enum Answers { Close }

class _speaker_RequestsState extends State<speaker_Requests> {
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

  ////////////////////////////////////////////////////////////////////////////favorite
  bool fav;
  var my_color_variable;
  String id, duID;

  f() async {
    var data =
        await Firestore.instance.collection('favorite').document(duID).get();

    if (data.exists) {
      setState(() {
        my_color_variable = Colors.red;
        fav = true;
      });
    } else {
      setState(() {
        my_color_variable = Colors.white;
        fav = false;
      });
    }
  }

  //////////////////////////////////////////////////////////////////////////////////
  ///
  //////////////////////////////////////////////////////////////////////////////////join event
  bool join;
  var my_color_variable_join = Colors.green;
  var join_text = Text("AGREE");
  //String id,duID;
  var join_icon = Icon(Icons.check);
  j() async {
    var data = await Firestore.instance
        .collection('join_event_speaker')
        .document(duID)
        .get();

    if (data.exists) {
      setState(() {
        my_color_variable_join = Colors.red;
        join = true;
        join_text = Text("you are the speaker of this Event");
        join_icon = Icon(Icons.work);
      });
    } else {
      setState(() {
        my_color_variable_join = Colors.green;
        join = false;
        join_text = Text("AGREE");
        join_icon = Icon(Icons.check);
      });
    }
  }

  String _value = '';

  void _setValue(String value) => setState(() => _value = value);

  Future _askUser() async {
    switch (await showDialog(
        context: context,
        child: new SimpleDialog(
          title: new Text("Your request has been succecfully"),
          children: <Widget>[
            new SimpleDialogOption(
              child: new Text("Close"),
              onPressed: () {
                Navigator.pop(context, Answers.Close);
              },
            ),
          ],
        ))) {
      case Answers.Close:
        _setValue('ok');
        break;
    }
  }

  Future _askUserno() async {
    switch (await showDialog(
        context: context,
        child: new SimpleDialog(
          title: new Text("you are the speaker of this Event"),
          children: <Widget>[
            new SimpleDialogOption(
              child: new Text("Close"),
              onPressed: () {
                Navigator.pop(context, Answers.Close);
              },
            ),
          ],
        ))) {
      case Answers.Close:
        _setValue('ok');
        break;
    }
  }

  join_event() {
    if (join == false) {
      Firestore.instance
          .collection('join_event_speaker')
          .document(duID)
          .setData({
        'photo': widget.photo,
        'title': widget.title,
        'address': widget.address,
        'capacity': widget.capacity,
        'description': widget.desciption,
        'date': widget.date,
        //'status': widget.status,
        'place': widget.place,
        'user': user.uid,
        'eventID': widget.docID,
        'owner': widget.owner
      });
      /* Toast.show("added", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);*/
      _askUser();
      setState(() {
        join = true;
        my_color_variable_join = Colors.pink;
        join_text = Text("you are the speaker of this Event");
        join_icon = Icon(Icons.work);
      });
    } else {
      // Firestore.instance.collection("join_event_speaker").document(duID).delete();
      _askUserno();

      setState(() {
        join = false;
        my_color_variable_join = Colors.green;
        join_text = Text("AGREE");
        join_icon = Icon(Icons.add);
      });
    }
  }

//////////////////////////////////////////////////////////////////////////////////
  @override
  initState() {
    super.initState();
    getUser();
    print(widget.docID);
    duID = widget.docID + widget.userID;
    f();
    if (widget.favo == true) {
      j();
    } else {
      setState(() {
        // join = false;
        my_color_variable_join = Colors.red;
        join_text = Text("not avalible");
        join_icon = Icon(Icons.not_interested);
      });
    }
    print(widget.stat);
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
                      child: Image(
                          fit: BoxFit.fill,
                          alignment: Alignment.topRight,
                          image: NetworkImage(widget.photo)),
                    ),
                    Positioned(
                        right: 10.0,
                        bottom: 7,
                        child: InkWell(
                          /////////////////////////////
                          onTap: () {
                            // if(widget.favo == false){
                            // setState(() {
                            //   widget.favo = true;
                            // });
                            // }else{
                            //   setState(() {
                            //   widget.favo = false;
                            // });
                            // }
                          },
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Colors.black),
                            child: Center(
                              child: Icon(Icons.favorite,
                                  color: my_color_variable),
                            ),
                          ),
                        ))
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
                              value: widget.capacity,
                              icon: Icon(
                                Icons.apps,
                              ),
                            ),
                            SpecsBlock(
                              label: "Date",
                              value: widget.date,
                              icon: Icon(
                                Icons.date_range,
                              ),
                            ),
                            SpecsBlock(
                              label: "status",
                              value: widget.stat,
                              icon: Icon(
                                Icons.help_outline,
                              ),
                            ),
                            SpecsBlock(
                              label: "Track",
                              value: widget.track,
                              icon: Icon(
                                Icons.help_outline,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                      //   child: Text(
                      //     "Free Gifts",
                      //     style: Theme.of(context).textTheme.subhead,
                      //   ),
                      // ),
                      // const SizedBox(height: 5.0),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                      //   child: Text("helmet, Gloves, Rain Coat, Bike Cover,"),
                      // ),
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
                                widget.capacity,
                                style: bold,
                                textAlign: TextAlign.left,
                                //softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //////////////////////////////////////////
                      // ///////////////////////////////////
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(4.0),
                      //     color: Colors.white,
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.grey,
                      //         blurRadius: 0.5,
                      //       )
                      //     ],
                      //   ),
                      //   padding: const EdgeInsets.all(18),
                      //   margin: const EdgeInsets.symmetric(vertical: 4.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: <Widget>[
                      //       Text(
                      //         'Speaker:',
                      //         style: TextStyle(
                      //           fontSize: 17,
                      //           fontStyle: FontStyle.normal,
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 100,
                      //         child: Text(
                      //           "$widget.speaker",
                      //           style: bold,
                      //           textAlign: TextAlign.left,
                      //           //softWrap: true,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // //////////////////////////////////////////
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
                              'Place:',
                              style: TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                widget.place,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            // alignment: Alignment.bottomCenter,
                            child: RaisedButton.icon(
                              color: my_color_variable_join,
                              textColor: Colors.white,
                              icon: join_icon,
                              label: join_text,
                              onPressed: () {
                                if (widget.favo == true) {
                                  join_event();
                                }
                              },
                            ),
                          ),
////////////////////////////////////sec
                          // SizedBox(
                          //   width: 10,
                          // ), 
                          // Container(
                          //   //alignment: Alignment.bottomLeft,
                          //   child: RaisedButton.icon(
                          //     color: Colors.red,
                          //     textColor: Colors.white,
                          //     icon: Icon(Icons.restore_from_trash),
                          //     label: Text("Refuse"),
                          //     onPressed: () {
                          //       if (widget.favo == true) {
                          //         join_event();
                          //       }
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
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
                  //if (child != null) ...[const SizedBox(height: 10.0), child]
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
