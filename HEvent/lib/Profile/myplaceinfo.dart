// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class placeInfo extends StatefulWidget {
//   @override
//   _placeInfoState createState() => _placeInfoState();
// }

// class _placeInfoState extends State<placeInfo> {

//   List place = [
//     {
//       'name':'mohamed',
//       'info':'asuhdkasmdkljasdkl',
//       'image':'assets/AI.jpg',
//     },
//     {
//       'name':'ahmed',
//       'info':'asuhdk',
//       'image':'assets/Discovering.jpg',
//     },
//     {
//       'name':'khald',
//       'info':'mdkljasdkl',
//       'image':'assets/marketing.jpg',
//     },
//   ];
  


//   @override
//   Widget build(BuildContext context) {
//      return Scaffold(
//       appBar: AppBar(
//         title: Text('data',style: TextStyle(color: Colors.black),),
//         backgroundColor: Colors.white,
//       ),

//       body: ListView(
//         children: <Widget>[
//           Container(
//             height: MediaQuery.of(context).size.height*0.35,
//             width: MediaQuery.of(context).size.width*0.9,
//             margin: EdgeInsets.all(2),
//             child: ListView.builder(
//               itemCount: place.length,
//               scrollDirection: Axis.horizontal,
              
//               itemBuilder: (BuildContext context,index){
//                 return Container(
//                  margin: EdgeInsets.all(8),
//                  child: ClipRRect(
//                    borderRadius: BorderRadius.circular(18.0),
//                    child: Image.asset('${place[index]['image']}',
//                    width: MediaQuery.of(context).size.width*0.9,
//                      fit: BoxFit.fill,
//                      ),/////
//                  ),
//                 );
//               }
//               ),
//           ),///////first container
          
//           Container(
//             height: 450,
//             margin: EdgeInsets.all(10),
            
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(18.0),
//               boxShadow: [BoxShadow(
//             color: Colors.grey,
//             blurRadius: 5.0,
//              )],
//             ),
//             child: Padding(
//             padding: EdgeInsets.all(30),
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text('Name:',style: TextStyle(
//                      fontSize: 20,
//                      fontStyle: FontStyle.normal,
//                      fontWeight: FontWeight.bold,
//                     ),
//                     ),
//                   //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
//                     Container(
//                       width: 100,
//                      child: Text('plac namer',style: TextStyle(
//                      fontSize: 15,
//                      fontStyle: FontStyle.normal,
//                     ),
//                     textAlign: TextAlign.left,
//                     //softWrap: true,
//                     ),
//                     ),
                    
//                   ],
//                 ),//row1
//                 SizedBox(height: 12.5,),
//                 Divider(color: Colors.black,),
//                 SizedBox(height: 12.5,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text('Address:',style: TextStyle(
//                      fontSize: 20,
//                      fontStyle: FontStyle.normal,
//                      fontWeight: FontWeight.bold,
//                     ),
//                     ),
//                   //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
//                     Container(
//                       width: 100,
//                      child: Text('plac namerasdasdasskjdh',style: TextStyle(
//                      fontSize: 15,
//                      fontStyle: FontStyle.normal,
//                     ),
//                     textAlign: TextAlign.left,
//                     //softWrap: true,
//                     ),
//                     ),
//                   ],
//                 ),//row2
//                 SizedBox(height: 12.5,),
//                 Divider(color: Colors.black,),
//                 SizedBox(height: 12.5,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text('Capacity:',style: TextStyle(
//                      fontSize: 20,
//                      fontStyle: FontStyle.normal,
//                      fontWeight: FontWeight.bold,
//                     ),
//                     ),
//                   //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
//                     Container(
//                       width: 100,
//                      child: Text('100',style: TextStyle(
//                      fontSize: 15,
//                      fontStyle: FontStyle.normal,
//                     ),
//                     textAlign: TextAlign.left,
//                     //softWrap: true,
//                     ),
//                     ),
//                   ],
//                 ),//row3
//                 SizedBox(height: 12.5,),
//                 Divider(color: Colors.black,),
//                 SizedBox(height: 12.5,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text('Description:',style: TextStyle(
//                      fontSize: 20,
//                      fontStyle: FontStyle.normal,
//                      fontWeight: FontWeight.bold,
//                     ),
//                     ),
//                   //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
//                     Container(
//                       width: 100,
//                      child: Text('plac namerasdasdasskjdhaskjdhjaskdh',style: TextStyle(
//                      fontSize: 15,
//                      fontStyle: FontStyle.normal,
//                     ),
//                     textAlign: TextAlign.left,
//                     //softWrap: true,
//                     ),
//                     ),
//                   ],
//                 ),//row4
//                 SizedBox(height: 12.5,),
//                 Divider(color: Colors.black,),
//                 SizedBox(height: 12.5,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text('Services:',style: TextStyle(
//                      fontSize: 20,
//                      fontStyle: FontStyle.normal,
//                      fontWeight: FontWeight.bold,
//                     ),
//                     ),
//                   //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
//                     Container(
//                       width: 100,
//                      child: Text('non',style: TextStyle(
//                      fontSize: 15,
//                      fontStyle: FontStyle.normal,
//                     ),
//                     textAlign: TextAlign.left,
//                     //softWrap: true,
//                     ),
//                     ),
//                   ],
//                 ),//row5
//               ],
//             ),
//             ),
//           ),
//         ],
//       ),

//       floatingActionButton: FloatingActionButton( ////////////////
//             onPressed: (){
//                 Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => null),
//                 );
//               },
//           tooltip: 'Back',
//           child: Icon(Icons.arrow_back,color: Color(0xFFFD4F99),),
//           backgroundColor: Colors.black,
//            ),
//      );
//   }
// }

// import 'package:flutter/material.dart';

// class moreExplore extends StatefulWidget {
//   @override
//   _moreExploreState createState() => _moreExploreState();
// }

// class _moreExploreState extends State<moreExplore> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('title'),
//       // ),
//       body: new CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             leading: Icon(Icons.arrow_back),
//             title: Text('HEvent'),
//             //floating: true,
//             expandedHeight: 250.0,
//             pinned: true,
//             flexibleSpace: new FlexibleSpaceBar(
//               background: Image.network(
//                 'https://blog.codemagic.io/uploads/Codemagic-io_Blog_Flutter-Versus-Other-Mobile-Development-Frameworks_1.png',
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           SliverFillRemaining(
//             child: SingleChildScrollView(
//               child: Container(
//                 height: 450,
//                 margin: EdgeInsets.all(10),
//                 // decoration: BoxDecoration(
//                 //   color: Colors.white,
//                 //   borderRadius: BorderRadius.circular(18.0),
//                 //   boxShadow: [
//                 //     BoxShadow(
//                 //       color: Colors.grey,
//                 //       blurRadius: 5.0,
//                 //     )
//                 //   ],
//                 // ),
//                 child: Padding(
//                   padding: EdgeInsets.all(30),
//                   child: Column(
//                     children: <Widget>[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text(
//                             'Name:',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontStyle: FontStyle.normal,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
//                           Container(
//                             width: 100,
//                             child: Text(
//                               'plac namer',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontStyle: FontStyle.normal,
//                               ),
//                               textAlign: TextAlign.left,
//                               //softWrap: true,
//                             ),
//                           ),
//                         ],
//                       ), //row1
//                       SizedBox(
//                         height: 12.5,
//                       ),
//                       Divider(
//                         color: Colors.black,
//                       ),
//                       SizedBox(
//                         height: 12.5,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text(
//                             'Address:',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontStyle: FontStyle.normal,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
//                           Container(
//                             width: 100,
//                             child: Text(
//                               'plac namerasdasdasskjdh',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontStyle: FontStyle.normal,
//                               ),
//                               textAlign: TextAlign.left,
//                               //softWrap: true,
//                             ),
//                           ),
//                         ],
//                       ), //row2
//                       SizedBox(
//                         height: 12.5,
//                       ),
//                       Divider(
//                         color: Colors.black,
//                       ),
//                       SizedBox(
//                         height: 12.5,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text(
//                             'Capacity:',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontStyle: FontStyle.normal,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
//                           Container(
//                             width: 100,
//                             child: Text(
//                               '100',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontStyle: FontStyle.normal,
//                               ),
//                               textAlign: TextAlign.left,
//                               //softWrap: true,
//                             ),
//                           ),
//                         ],
//                       ), //row3
//                       SizedBox(
//                         height: 12.5,
//                       ),
//                       Divider(
//                         color: Colors.black,
//                       ),
//                       SizedBox(
//                         height: 12.5,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text(
//                             'Description:',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontStyle: FontStyle.normal,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
//                           Container(
//                             width: 100,
//                             child: Text(
//                               'plac namerasdasdasskjdhaskjdhjaskdh',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontStyle: FontStyle.normal,
//                               ),
//                               textAlign: TextAlign.left,
//                               //softWrap: true,
//                             ),
//                           ),
//                         ],
//                       ), //row4
//                       SizedBox(
//                         height: 12.5,
//                       ),
//                       Divider(
//                         color: Colors.black,
//                       ),
//                       SizedBox(
//                         height: 12.5,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text(
//                             'Services:',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontStyle: FontStyle.normal,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
//                           Container(
//                             width: 100,
//                             child: Text(
//                               'non',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontStyle: FontStyle.normal,
//                               ),
//                               textAlign: TextAlign.left,
//                               //softWrap: true,
//                             ),
//                           ),
//                         ],
//                       ), //row5
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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

class myplaceinfo extends StatefulWidget {
  String title,
      photo,
      address,
      
      desciption,
      docID,
      userID,
      price;
      List<dynamic> images= [];
  int capacity;
  String stat;
  myplaceinfo({
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
  _myplaceinfoState createState() => _myplaceinfoState();
}

class _myplaceinfoState extends State<myplaceinfo> {
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
                                widget.price,
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
