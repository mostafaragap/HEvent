import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Charts1 extends StatefulWidget {
  String title;
  Charts1({this.title}); 

  @override
  _Charts1State createState() => _Charts1State();
}

class _Charts1State extends State<Charts1> {

  static final String path = "lib/src/pages/dashboard/dash2.dart";
  final TextStyle whiteText = TextStyle(color: Colors.white);

  @override
  void initState() {
    favoriteData();
    joindData();
  }

  
  Future favoriteData() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore
        .collection('favorite')
        .where("title", isEqualTo: widget.title)
        .getDocuments();
    return qn.documents.length;
  }
  ////////////////////////////////////
    Future joindData() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore
        .collection('join_event')
        .where("title", isEqualTo: widget.title)
        .getDocuments();
    return qn.documents.length;
  }
  /////////////////////////////////
    Future scannData() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore
        .collection('attendees')
        .where('eventtitle', isEqualTo: widget.title)
        .getDocuments();
    return qn.documents.length;
  }

  int count=0;
  int g ;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          _buildHeader(),
          const SizedBox(height: 50.0),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 315,
                      color: Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FutureBuilder(
                              future: scannData(),
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: Text('loading...'),
                                  );
                                } else if (snapshot.hasData) {
                                //  g = snapshot.data.toString();
                                  print(snapshot.data);
                                  print(
                                      "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                                  return ListTile(
                                    title: Text(
                                      // "{($count)}",
                                      snapshot.data.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .display1
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 24.0,
                                          ),
                                    ),
                                    trailing: Icon(
                                      FontAwesomeIcons.camera,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              }),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Scann',
                              style: whiteText,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      // height: 120,
                      // color: Colors.green,
                      // child: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: <Widget>[
                      //     ListTile(
                      //       title: Text(
                      //         "70 bpm",
                      //         style:
                      //             Theme.of(context).textTheme.display1.copyWith(
                      //                   color: Colors.white,
                      //                   fontSize: 24.0,
                      //                 ),
                      //       ),
                      //       trailing: Icon(
                      //         FontAwesomeIcons.heartbeat,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 16.0),
                      //       child: Text(
                      //         'Avg. Heart Rate',
                      //         style: whiteText,
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 120,
                      color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                           FutureBuilder(
                              future: favoriteData(),
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: Text('loading...'),
                                  );
                                } else if (snapshot.hasData) {
                                //  g = snapshot.data.toString();
                                  print(snapshot.data);
                                  print(
                                      "favooooooooooooooooooooooooooooo");
                                  return ListTile(
                                    title: Text(
                                      // "{($count)}",
                                      snapshot.data.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .display1
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 24.0,
                                          ),
                                    ),
                                    trailing: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              }),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Favorite',
                              style: whiteText,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      height: 190,
                      color: Colors.yellow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FutureBuilder(
                              future: joindData(),
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: Text('loading...'),
                                  );
                                } else if (snapshot.hasData) {
                                  g = snapshot.data;
                                  count = snapshot.data;
                                  print(snapshot.data);
                                  print(
                                      "joindddddddddddddddddddddddddd");
                                  return ListTile(
                                    title: Text(
                                      // "{($count)}",
                                      snapshot.data.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .display1
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 24.0,
                                          ),
                                    ),
                                    trailing: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              }),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Joind',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }



double reciprocal(double d) => d / 10;

  Widget _buildHeader() {
    return Row(
      children: <Widget>[
        Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            value: 0.1,
          //  value: reciprocal(count.toDouble()),////مؤقتا
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            backgroundColor: Colors.grey.shade700,
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                //"Overall\nDaily Progress",
                style: whiteText.copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 20.0),
              Text(
              //  g.toString()+"%",// مؤقتا
              "1 %",
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            ],
          ),
        )
      ],
    );
  }
}
