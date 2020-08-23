
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HEvent/pages/home.dart';
import 'package:toast/toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';




class detialProduct extends StatefulWidget {

    DocumentSnapshot document;
    detialProduct({this.document});


  @override
  _detialProductState createState()
  => _detialProductState(curdocument: document);
}
class _detialProductState extends State<detialProduct> {

  CollectionReference add = Firestore.instance.collection("notification");//////// firebase ref
  var quantity;
  String name;
  int proQuantity;
  //int value1,value2;
  String imageUrl;
 


  DocumentSnapshot curdocument;
  _detialProductState({this.curdocument});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("product is "+curdocument["Title"]),
      ),
              body: StreamBuilder(
          stream: Firestore.instance.collection("vendor").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> docs) {
           var arr =  docs.data.documents.where((test) => test.documentID == curdocument.documentID).toList();
           print('our array is :$arr');
            if (docs.hasError) return Text("Error");
            if (docs.hasData != true) return Text("No Product Added");
            if (docs.connectionState == ConnectionState.waiting)
              return SpinKitChasingDots(
                size: 20,
              );
            return Container(
              margin: EdgeInsets.all(20),
              // child: ListView(
              //   children: arr.map((document) {
              //     return InkWell(
              //        child: ListTile(
              //            title: Text("the price is "+document["price"]),
              //            subtitle: Text("the Quantity is "+document["quantity"]),
              //            trailing: IconButton(
              //              icon: Icon(Icons.add), onPressed: () {},
              //               )
              //               ), 
              //               );
              //               }).toList(),
              // ),

            child: ListView(
                children: arr.map((document) {
                  return InkWell(
                    child: Column(children: <Widget>[
                           
                           Text("the Category is "+document["Category"]),
                           Text("name "+document["Title"]),
                           Text("description "+document["Description"]),
                           Text("the location is "+document["Point"]),
                           Text("the price is "+document["Price"]),
                           Text("the Quantity is "+document["Quantity"]),
                           Image.network(document["image"]),

     

                           FlatButton(child: Text('buy'),
                              textColor: Colors.blue,
                              onPressed: (){
                                dialogTigger(context);
                                this.name= document["Title"];

                                

                               print( this.proQuantity); 
                                print( this.quantity); 
                                print(this.name);
                                
                              },
                           ),
                    ],),
                    
                          
                            );
                            
                            }).toList(),
              ),
             
            );
          },
        )
    );
    

   }
  // Future checkQuantity() async {
  //   if(quantity <= proQuantity ){
  //                   ///quantity enter by user
  //                   /// print("okkkkkkkk");
  //                   add.document().setData({
  //                 "title": this.name,
  //                 "quantity": this.quantity,
  //               }).then((data){
  //                Navigator.of(context).pop(true);
  //               });

  //                   // update new quantity
                 

                   
  //                 }else{
                   
  //                  // there is not enough quantity in the store
  //                  quantitytrigger(context);

  //                 }
  //               }


  
  Future<bool>dialogTigger(BuildContext context){
  return showDialog(
    barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return new AlertDialog(
          title: new Text('', style: TextStyle(fontSize: 15.0),),
          content: Column(children: <Widget>[
            Text('pleas enter quantity'),
            TextField(
                  decoration: InputDecoration(hintText: 'Enter num of  Quantity '),
                  onChanged: (value){
                    this.quantity=value;  // this.
                  },
                  ),
                   ],
                   ), 
                   actions: <Widget>[
                     new FlatButton(
                       child: new Text('submit'),
                       textColor: Colors.blue,
                       onPressed: ()async{
                        // checkQuantity();
                        add.document().setData({
                                "title": this.name,
                               "quantity": this.quantity,
                               }).then((data){
                               Navigator.of(context).pop(true);
                               }); 
                       }
                        )
                        ],
                        );
      }
  );
}
    


// Future<bool>quantitytrigger(BuildContext context){
//   return showDialog(
//     barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context){
//         return new AlertDialog(
//           title: new Text('', style: TextStyle(fontSize: 15.0),),
//           content: Text('there is not enough quantity in the store'),
//           actions: <Widget>[
//             new FlatButton(
//               child: new Text('ok'),
//               textColor: Colors.blue,
//               onPressed: () {
//                 Navigator.of(context).pop(true);
//               },
//             ),
//           ],
//         );
//       }
//   );
// }


    
  




  


}//end of class