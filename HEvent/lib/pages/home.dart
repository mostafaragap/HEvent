import 'package:HEvent/pages/setup/detialProduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  const Home({
    Key key,
    @required this.user
    }) : super(key: key);
    final FirebaseUser user;
    @override
    _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${widget.user.email}'),
      ),
      body: 
      //ListPage(),
      
      StreamBuilder(
          stream: Firestore.instance.collection("vendor").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> docs) {
            if (docs.hasError) return Text("Error");
            if (docs.hasData != true) return Text("No Products Added");
            if (docs.connectionState == ConnectionState.waiting)
              return SpinKitChasingDots(
                size: 20,
              );
            return Container(
              margin: EdgeInsets.all(20),
              child: ListView(
                children: docs.data.documents.map((document) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return detialProduct(document: document);
                      }));
                    },
                    child: ListTile(
                        
                        title: Text(document["Title"]),
                        subtitle: Text(document["Price"]),
                        
 
                        ),
                  );
                }).toList(),
              ),
            );
          },     ));
  }
}

/*
class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {



  Future getproducts() async {

    var firestore = Firestore.instance;
    QuerySnapshot qn= await   firestore.collection("vendor").getDocuments();
    return qn.documents;
  }
    navigateToDetail(DocumentSnapshot product){

    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetialPage(product: product,)));
  }

  @override
  Widget build(BuildContext context) {    
    return Container(
      child: FutureBuilder(
        future: getproducts(),
        builder: (_, snapshot){
          

        if(snapshot.connectionState == ConnectionState.waiting){
          return Center (
            child: Text("Loading...."),
          );
        } else {

          return ListView.builder(
            
            itemCount: snapshot.data.length,
            itemBuilder: (_ , index){
 
              return ListTile(
                title: Text(snapshot.data[index].data["title"]),
                onTap: ()=>navigateToDetail(snapshot.data[index]),         
                  );
                  
              
          });
        }

      }),
      
    );
  }
}



class DetialPage extends StatefulWidget {


  final DocumentSnapshot product;

  DetialPage({this.product});



  @override
  _DetialPageState createState() => _DetialPageState();
}

class _DetialPageState extends State<DetialPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          title: Text(widget.product.data["title"]),
          subtitle: Text(widget.product.data["content"]),
        )
      )
      
    );
  }
}
*/