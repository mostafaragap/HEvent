import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '././scanpage.dart';
import './searchTeam.dart';
import './scanpage.dart';

class Search extends StatefulWidget {
  String title, photo;
  Search({this.title, this.photo});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Search> {
  CrudFire crud = new CrudFire();
  int _counter = 0;
  var queryResultSet = [];
  var tempSearchStore = [];

  Object get printsearchField => null;

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

//'<center><p> $_dattaname </p></center>' +
  void sendMail(String title, String email) async {
    String body = '<h1> Hello sir</h1>' +
        '<h3> congratulation sir ,You have been chosen to be one of the event organizers   </h3>' +
        '<h3>check your account at Ｈ𝒆ν𝑒Ňⓣ to see all the details about the event </h3>' +
        '<center><p> ${title} </p></center>' +
        '<p> ${DateTime.now()}</p>';
    String username = 'ahmedshtat70@gmail.com';
    String password = 'a 50a 50a 50';
    final stmpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'shtat')
      ..recipients.add(email + '')
      //..recipients.add('mohamed.magdya109@gmail.com')
      ..subject = 'Ｈ 𝒆ν𝑒Ňⓣ'
      ..html = body;

    try {
      final sendReport = await send(message, stmpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.${e.toString()}');
    }
  }

/////////////////////////////////////////////
  Future counterteam() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore
        .collection('scanTeam')
        .where("eventTitle", isEqualTo: widget.title)
        .getDocuments();
    return qn.documents.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30))),
                height: 140.0,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back,
                              color: Colors.white, size: 30),
                          onPressed: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ScanPage()));
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 260),
                          child: IconButton(
                            icon: Icon(
                              Icons.assignment_ind,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      GetTeam(title: widget.title)));
                            },
                          ),
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                          child: Text(
                        'choose your Team',
                        style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 20.0,
                            color: Colors.white),
                      )),
                    ),
                    SizedBox(height: 60.0),
                  ],
                )),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 110.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    child: TextField(
                        onChanged: (val) {
                          initiateSearch(val);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search,
                                color: Colors.black, size: 25.0),
                            contentPadding:
                                EdgeInsets.only(left: 10.0, top: 12.0),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                                color: Colors.white, fontFamily: 'Quicksand'))),
                  ),
                ),
                SizedBox(height: 10.0),
                FutureBuilder(
                    future: counterteam(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            //  child: Text('loading...'),
                            );
                      } else if (snapshot.hasData) {
                        //  g = snapshot.data.toString();
                        //setState(() {
                        _counter = snapshot.data;
                        // });
                        print(snapshot.data);
                        print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                        return Padding(
                          padding: EdgeInsets.only(left: 300),
                          child: Container(
                            width: 36,
                            height: 40,
                            child: Center(
                                child: Text(
                              '$_counter',
                              style: TextStyle(color: Colors.white),
                            )),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      }
                    }),
                SizedBox(height: 5.0),
                GridView.count(
                    padding: EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    primary: false,
                    shrinkWrap: true,
                    children: tempSearchStore.map((element) {
                      return buildResultCard(element);
                    }).toList())
              ],
            ),
          ],
        ),
      ],
    ));
  }

  Widget buildResultCard(data) {
    return Card(
        // margin: EdgeInsets.only(top: 20),
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.elliptical(20.0, 40.0),
        //         topRight: Radius.elliptical(20.0, 40.0))),
        elevation: 20.0,
        child: Stack(children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(top: 8.0),
              child: Center(
                  child: Column(
                children: <Widget>[
                  CircleAvatar(
                    child: ClipOval(
                      //radius: 30,
                      // maxRadius: 50.0,
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        //child:Image.asset(document["image"],fit: BoxFit.fill,),////// image
                        child: Image.network(
                          data["photo"],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    /*  child: Image.network(
                                    data["photo"],
                                          fit: BoxFit.fitWidth,
                                        ),*/
                    //  child: Text(data['name'],style: TextStyle(color:Colors.white),),
                    //  backgroundColor: Colors.black,
                  ),
                  Text(
                    data['name'],
                  ),
                  Text(
                    data['email'],
                  ),
                 
                ],
              ))),
          Positioned(
            bottom: 0,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: IconButton(
                    icon:
                        Icon(Icons.account_box, color: Colors.black, size: 30),
                    onPressed: () async {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.add, color: Colors.black, size: 30),
                      onPressed: () async {
                        print(data['email']);
                        var firestore = Firestore.instance;
                        QuerySnapshot qn = await firestore
                            .collection('scanTeam')
                            .where("name", isEqualTo: data['name'])
                            .where("email", isEqualTo: data['email'])
                            .getDocuments();
                        if (qn.documents.length == 1) {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('He/She already exist')));
                        } else {
                          sendMail(widget.title, data['email']);

                          setState(() {
                            _counter++;
                          });
                          await Firestore.instance
                              .collection('scanTeam')
                              .document()
                              .setData({
                            'name': data['name'],
                            'email': data['email'],
                            'userID': data['id'],
                            'photo': data['photo'],
                            'eventTitle': widget.title,
                            'eventphoto': widget.photo,
                          });
                        }

                        ////////////////////////////////
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ]));
  }
}

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('user')
        .where('serchIndex', arrayContains: searchField)
        .getDocuments();
  }
}

class CrudFire {
  Future<void> create(data) async {
    Firestore.instance.collection('scanned').add(data);
  }
}
