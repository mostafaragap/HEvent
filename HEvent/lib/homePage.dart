import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HEvent/createEvent/eventName.dart';
import 'package:HEvent/createEvent/eventName2.dart';
import 'package:HEvent/createEvent/speaker.dart';
import 'package:HEvent/homeExplore/explore.dart';
import 'package:HEvent/pages/setup/Interests.dart';
import 'package:HEvent/pages/setup/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:HEvent/dashboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HEvent/pages/suggest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class HomePage extends StatefulWidget {
  
 FirebaseUser user;
 HomePage({this.user});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {


  //     Future<List<DocumentSnapshot>> getSeedID() async{
  //        var firestore = Firestore.instance;
  //   var data = await firestore.collection('Events').getDocuments();
  //   var productList = data.documents;
  //   print("Data length: ${productList.length}");
  //   // for(int i = 0; i < productList.length; i++){
  //   //   var productId = Firestore.instance.collection('products').document(productList[i]['productId']).documentID;
  //   //   if(productId != null) {
  //   //     print("Data: " + productId);
  //   //   }
  //   // }
  //   return productList;
  // }

 List<int> tags = [1, 2, 3,4,5,7,10,11];
  var selectedItem = 0;

  List children = [
    DashboardPage(),
    DashboardPage(),
    DashboardPage(),
  //  DashboardPage()
    Interests(),
  ];

    FirebaseUser user;
  Future<void> getUser() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      print(user.uid);
    });
  } //////////////////////////////////////////////////////////////get user id

  /////////////////////////////////get intrestes


  Future getintrestesdata() async {
  var data = await Firestore.instance.collection('user').document(user.uid).get();
  
  SharedPreferences p;
  p = await SharedPreferences.getInstance();
  setState(() {
     p.setString('Interests', data['Interests'][0]);
    
    });
     print(data['Interests'][0]);
     print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
  }


//////////////////////////////////////////////////////////////في sigin in 0-1
///
///////////////////////////////////////////////////////////////////////وفيق


Future<http.Response> getHttp() async {
 
  var body = json.encode(tags);
  var response;
     response = await http.post("http://192.168.1.5:443/content",
       headers: {"Content-Type": "application/json"},
       body: body
      );
      
      var ids = json.decode(response.body);
      //print(ids);
      List idlist = ids.values.toList();
      print(idlist[0]);
      //print(response.body);
      return response;

  
}

//////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();
   // getUser();
    //page();
    getUser();
    //getintrestesdata();
  }

 Future _data;
  Future<void> page(var i){
     switch (selectedItem) {
    case 1:
      //child = FlutterLogo();
      Interests();
      break;
    case 2:
      //child = FlutterLogo(colors: Colors.orange);
      speaker();
      break;
    case 3:
      //child = FlutterLogo(colors: Colors.red);
      eventName2();
      break;
  }
  }
  

  //get floatingActionButton => null;
  @override
  Widget build(BuildContext context) {

   Widget child;
  switch (selectedItem) {
    case 1:
      child = FlutterLogo();
      break;
    case 2:
      child = FlutterLogo(colors: Colors.orange);
      break;
    case 3:
      child = FlutterLogo(colors: Colors.red);
      break;
  }

    return Scaffold(
     // backgroundColor: Color(0xFF202020),
      //body: children[selectedItem],
      body:Column(
        
      children: <Widget>[
        SizedBox(height: 20.0),
        Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                     onTap: ()async{
                    await FirebaseAuth.instance.signOut();
                     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage()));
                     },
                      child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: Color(0xFFFD4F99)),
                      child: Center(
                          child: Icon(Icons.exit_to_app, color: Colors.white))),
                ),
                Text('HOME',
                    style: GoogleFonts.montserrat(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        textStyle: TextStyle(color: Colors.black))),
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Color(0xFF353535)),
                  child: Center(
                    child: InkWell(
                      onTap: (){

                      
                        getintrestesdata();

                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return new suggest();
                        }));
                        getHttp();
                      },
                      child: Icon(Icons.format_list_bulleted, color: Colors.white)
                      ),
                  ),
                )
              ],
            )),
        SizedBox(height: 10.0),
        Container(
          height: MediaQuery.of(context).size.height - 156.0,
          child:   StreamBuilder<QuerySnapshot>(
        stream: 

        Firestore.instance.collection("tracks").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
           if (!snapshot.hasData) return Center(child: Text('loading aata ...Please Wait'),);
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return new ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return  Container(
            
           // child: ListView(
           //   children: <Widget>[
            child:    _buildListItem(document['image'], document['track'],
                    document['info']),
                // _buildListItem('assets/marketing.jpg', 'Marketing',
                //     '110 topics - 1k articles'),
                // _buildListItem('assets/Discovering.jpg', 'Discovering',/////////
                //     '56 topics - 2k articles'),

         //     ],
       //     ),
            
            //  Align(
            //   alignment: Alignment.bottomRight,
            // ),
          );
                  
                   
                }).toList(),
              );
          }
        },
      ),
        ),
      
  
       
      ],
    ),
    floatingActionButton: FloatingActionButton( ////////////////
        onPressed: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => eventName()),
                );
              },
        tooltip: 'Create Event',
        child: Icon(Icons.add,color: Color(0xFFFD4F99),),
        backgroundColor: Colors.black,
      ),


      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Color(0xFF1B1B1B),//////////////
      //   selectedItemColor: Color(0xFFFD4F99),
      //   iconSize: 27.0,
      //   currentIndex: selectedItem,
      //   unselectedLabelStyle: TextStyle(color: Color(0xFF1B1B1B)),
      //   unselectedItemColor: Color(0xFF888888),
      //   onTap: (currIndex) {
      //     page(currIndex);
      //     setState(() {
      //       selectedItem = currIndex;
      //     });
      //   },
      //   items: [
      //     BottomNavigationBarItem(
            
      //       backgroundColor: Color(0xFF1B1B1B),
      //       icon: Icon(Icons.home),
      //       title: Container(
      //         height: 5.0,
      //         width: 5.0,
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: Color(0xFFFD4F99) 
      //         ),
      //       )
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Color(0xFF1B1B1B),
      //       icon: Icon(Icons.notifications),
      //       title: Container(
      //         height: 5.0,
      //         width: 5.0,
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: Color(0xFFFD4F99) 
      //         ),
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Color(0xFF1B1B1B),
      //       icon: Icon(Icons.person_outline),
      //       title: Container(
      //         height: 5.0,
      //         width: 5.0,
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: Color(0xFFFD4F99) 
      //         ),
      //       )
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Color(0xFF1B1B1B),
      //       icon: Icon(Icons.favorite),
      //       title: Container(
      //         height: 5.0,
      //         width: 5.0,
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: Color(0xFFFD4F99) 
      //         ),
      //       )
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Color(0xFF1B1B1B),
      //       icon: Icon(Icons.search),
      //       title: Container(
      //         height: 5.0,
      //         width: 5.0,
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: Color(0xFFFD4F99) 
      //         ),
      //       )
      //     )         
      //   ],
      // ),
    );
  }
  _buildListItem(String imgPath, String category, String description) {///////////
    return Padding(
        padding: EdgeInsets.all(15.0),
        child: Stack(
          children: <Widget>[
            Container(height: 300.0),
            Container(
              height: 300.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage(imgPath),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.darken))),///opacity //
            ),
            Container(
                height: 300.0,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(category,
                        style: GoogleFonts.montserrat(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            textStyle: TextStyle(color: Colors.white))),
                    Text(description,
                        style: GoogleFonts.montserrat(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            textStyle: TextStyle(color: Colors.white))),
                    SizedBox(height: 20.0),
                    InkWell(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(/////////////////////
                          //     builder: (context) => DetailsPage(imgPath: imgPath, title: country)));
                          ///////////////
                          // Navigator.push(
                          // context,
                          // MaterialPageRoute(builder: (context) => explore()),
                          // );
                          /////////////
                            Navigator.of(context).push(
                            new MaterialPageRoute(builder: (context){
                            return new explore(type: category,);
                           })
                           );
                           },
                        child: Container(
                            height: 50.0,
                            width: 125.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),
                            child: Center(
                                child: Text('Explore now',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        textStyle: TextStyle(
                                            color: Color(0xFFFD4F99)))))))
                  ],
                )))
          ],
        ));
  }
}



