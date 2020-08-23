import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class GetTeam extends StatefulWidget {
  String title;
  GetTeam({this.title,});
  @override
  State<StatefulWidget> createState() {
    return AddContactState();
  }
}

class AddContactState extends State<GetTeam> {
  CrudFire crud = new CrudFire();
  QuerySnapshot contacts;

  @override
  void initState() {
    super.initState();
    crud.getdata(widget.title).then((data) {
      setState(() {
        contacts = data;
      });
    });
  }

  Widget showData() {
    if (contacts != null && contacts.documents != null) {
      return ListView.builder(
        itemCount: contacts.documents.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
              child: Column(
            children: <Widget>[
              ListTile(
              /*  onTap: ()
                {
                  Navigator.
                },*/
                  title: Text('${contacts.documents[index].data['name']}'),
                  subtitle: Text('${contacts.documents[index].data['email']}'),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        contacts.documents[index].reference.delete();
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(builder: (context) => GetTeam()),
                        //     (Route<dynamic> route) => false);
                      }),
                  leading:  CircleAvatar(
                     child: ClipOval(
                                    //radius: 30,
                                    // maxRadius: 50.0,
                                    child: SizedBox(
                                      width:70,
                                      height:70,
                                      //child:Image.asset(document["image"],fit: BoxFit.fill,),////// image
                                      child: Image.network(
                                      contacts.documents[index].data['photo'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                //  child: Text('${contacts.documents[index].data['name']}',style: TextStyle(color: Colors.white,)),
                  //backgroundColor: Colors.black,
                ),)
            ],
          ));
        },
      );
    } else if (contacts != null && contacts.documents.length == 0) {
      return Text('No data right please add data');
    } else {
      return Text('please wait while load your data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('MY Team'),
          actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () async {
              Navigator.pushNamed(context,'search');
            },
          ),
        ],
        ),
        body: showData());
  }
}

class CrudFire {
  getdata(String title) async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    return await Firestore.instance
        .collection('scanTeam')
       .where('eventTitle',isEqualTo:title)
        .getDocuments();
  }
}
