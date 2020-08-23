
import 'package:HEvent/Home.dart';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';



class  payment extends StatefulWidget {
  @override
  paymentState createState() => paymentState();
}

class paymentState extends State<payment> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title:Text('payment'),
        centerTitle: true,
      ),

       body:ListView(
         children: <Widget>[
            Container(
         width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height,
           padding: EdgeInsets.all(20),
          child:Column(
            children:<Widget>[
       
      Container(
          
      
          padding: EdgeInsets.all(20),         
           color: Colors.teal,
            height:100,
              width: 300,
              child:Row(
                children: <Widget>[
                    SizedBox(
         
          width: 30,
        ),
                  Icon(Icons.payment,color:Colors.white ,size:30,),
                  Text('your budget 4000LE',style:TextStyle(color:Colors.white ,fontSize: 20 ),)
                ],),
                 
              
                
        ),
       SizedBox(
          height: 10,
          width: 10,
        ),
         TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                   borderSide:BorderSide(
                     color: Colors.blueAccent
                   ) 
                 ),
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                   color: Colors.red
                )
                ),
               hintText: 'enter your event name',              
              ),
              obscureText: true,
            ),
                SizedBox(
          height: 20,
          width: 10,
        ),
            TextFormField(
              
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                   borderSide:BorderSide(
                     color: Colors.blueAccent
                   ) 
                 ),
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                   color: Colors.red
                )
                ),
               hintText: 'enter your card number',
               counterText: 'VISA'
              ),
            ),

             TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                   borderSide:BorderSide(
                     color: Colors.blueAccent
                   ) 
                 ),
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                   color: Colors.red
                )
                ),
               hintText: 'Cvv',
              
              ),
              obscureText: true,
            ),

             SizedBox(
          height: 20,
          width: 10,
        ),
             TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                   borderSide:BorderSide(
                     color: Colors.blueAccent
                   ) 
                 ),
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                   color: Colors.red
                )
                ),
               hintText: 'Expiry Date',
      
              ),
            ),
            Container(
              color: Colors.red,
            ),
         SizedBox(
          height: 20,
          width: 10,
             ),
             Container(
               margin: EdgeInsets.only(left: 80),
               padding: EdgeInsets.all(10),
               child:Row(
                 children: <Widget>[                 
            Card( 
             
              child:Text('Time:20:00')),
           
              Card( child:Text('Date:31/3/2020'))                            
                         ],
               )
             ),
            
             
         
              RaisedButton(
                child: Text('submit'),
                color: Colors.teal,
                textColor:Colors.white,
                onPressed:(){
                  showDialog(
                    context: context,
                     builder:(_)=>AlertDialog(
                      content: Text('your payment succeded,you will recive sms please check your email'),
                      contentPadding: EdgeInsets.all(100), 
                       backgroundColor:  Colors.teal,
                       elevation: 20.2,        
                       actions: <Widget>[
                         FlatButton(
                           onPressed:(){
                          //   Navigator.pushNamed(context,'home');//replace home to his homepage or his prof
                          //  Navigator.pop(context);
                           Navigator.of(context)
                            .pushReplacement(new MaterialPageRoute(builder: (context) {
                          return new
                          FancyBottomBarPage(
                           
                            //,color: color,
                          );
                        }));
                        Toast.show("Payment Successfully", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                           }, 
                           child:Text('next',style:  TextStyle(fontSize: 20,color: Colors.white),), )
                          
                       ],
                  )
                  );
                },
              ),
            
            ]
          )
        )

       ],
       )
       
     
      
       
    );
  }
  }