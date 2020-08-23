// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import './profile.dart';
// import './subScan.dart';



// class SubAttenneds extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return AddContactState();
//   }
// }

// class AddContactState extends State<SubAttenneds> {
//   CrudFire crud = new CrudFire();
//   QuerySnapshot contacts;
//   int _counter;
//   @override
//   void initState() {
//     super.initState();
//     crud.getdata().then((data) {
//       setState(() {
//         contacts = data;
//       });
//     });
//   }

//   Future counterteam() async {
//     var firestore = Firestore.instance;

//     QuerySnapshot qn = await firestore
//         .collection('attendees')
//         //  .where("title", isEqualTo: widget.title)
//         .getDocuments();
//     return qn.documents.length;
//   }

//   Widget showData() {
//     if (contacts != null && contacts.documents != null) {
//       return ListView.builder(
//         itemCount: contacts.documents.length,
//         itemBuilder: (BuildContext context, index) {
//           return Container(
//               child: Column(
//             children: <Widget>[
//               SizedBox(height:30,),
           
//           SizedBox(height:30,),
//               ListTile(
//                   title: Text('${contacts.documents[index].data['userID']}'),
//                   subtitle: Text('${contacts.documents[index].data['eventtitle']}'),
//                   trailing: IconButton(
//                       icon: Icon(Icons.delete,size: 30,),
//                       onPressed: () {
//                         contacts.documents[index].reference.delete();
//                         Navigator.of(context).pushAndRemoveUntil(
//                             MaterialPageRoute(
//                                 builder: (context) => SubAttenneds()),
//                             (Route<dynamic> route) => false);
//                       }),
//                   leading: IconButton(
//                       icon: Icon(Icons.account_box,size: 30,),
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => Profile()));
//                       }))
//             ],
//           ));
//         },
//       );
//     } else if (contacts != null && contacts.documents.length == 0) {
//       return Text('No data right please add data');
//     } else {
//       return Text('please wait while load your data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor:Colors.black,
//           title: Text('Attendees'),
//           centerTitle: true,
//           leading: IconButton(
//               icon: Icon(Icons.scanner, color: Colors.white,size: 35,),
//               onPressed: () async {
//                    Navigator.pushReplacement(context,
//               MaterialPageRoute(builder: (context)=>SubScan()));
//               },
//           ), 
                    
//           actions: <Widget>[

//            Container(
//              child: Row(
//            children: <Widget>[
//                        // Padding(
//                        //   padding: EdgeInsets.only(right: 10),
//                           //child:
//                                FutureBuilder(
//                       future: counterteam(),
//                       builder: (_, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.waiting) {
//                           return Center(
//                               //  child: Text('loading...'),
//                               );
//                         } else if (snapshot.hasData) {
//                           //  g = snapshot.data.toString();
//                           //setState(() {
//                           _counter = snapshot.data;
//                           // });
//                           print(snapshot.data);
//                           print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
//                           return Padding(
//                             padding: EdgeInsets.only(left:20,right: 20),
//                             child: Container(
//                               width: 36,
//                               height: 30,
//                               child: Center(child: Text('$_counter',style: TextStyle(color: Colors.black,fontSize: 20),)),
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10)),
//                             ),
//                           );
//                         }
//                       }),

//                       //  ),
                 
                     
                      

                        
//                ],
//              ),
//            ),
             
          
//         ],
//         ),
//         body: showData());
//   }
// }

// class CrudFire {
//   getdata() async {
//     //  FirebaseUser userData = await FirebaseAuth.instance.currentUser();
//     return await Firestore.instance
//         .collection('attendees')
//         // .where('userID',isEqualTo: userData.uid)
//         .getDocuments();
//   }
// }