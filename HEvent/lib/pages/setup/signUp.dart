import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:HEvent/Pages/Setup/signIn.dart';
import 'package:path/path.dart' as p;
import 'package:toast/toast.dart';

import 'Interests.dart';




class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  
String _email , _password ,_confirmpassword,_name,_phone,_address;
final GlobalKey<FormState> _formkey =GlobalKey<FormState>();
var passKey = GlobalKey<FormFieldState>();



////////////////////////////////////
File image ;


  picker()async{

      File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    // File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if(img != null){
      //image = img;
      setState(() {
       image = img;
       // filename = basename(image.path);
      });
    }
  }
picker2()async{

    //  File img = await ImagePicker.pickImage(source: ImageSource.gallery);
     File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if(img != null){
      //image = img;
      setState(() {
        image = img;
         
      });
    }
  }

 String URL="";
  
  Future uploadPic() async{
    
    final String filename = p.basename(image.path);
    final FirebaseStorage storage =FirebaseStorage(storageBucket: 'gs://finalecommerce-823b1.appspot.com');
   // StorageReference reference = FirebaseStorage.instance.ref().child(filename);  
    StorageReference reference = storage.ref()./*child('giftShopItems').*/child(filename);
    StorageUploadTask upload = reference.putFile(image);

    var downurl = await (await upload.onComplete).ref.getDownloadURL();
      setState(() {
        
       this.URL = downurl.toString();
       print(this.URL);
       print(filename);
      });
      
  }
/////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.yellow.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        'log in',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text(
                    'sign up',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
 //////////////////////////////////////////
     Form(
        key: _formkey, //el mas2ol 3n save form
        child: Column(
          children: <Widget>[  //bktb t7teeh el design
           Stack(
                      children: <Widget>[
                         CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xff476cfb),
                      child: ClipOval(
                        child: new SizedBox(
                          width: 110.0,
                          height: 110.0,
                          child: (image!=null)?Image.file(
                            image,
                            fit: BoxFit.fill,
                          ):Image.network(
                            "https://www.eguardtech.com/wp-content/uploads/2018/08/Network-Profile.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                        // Container(
                        //   width: 110.0,
                        //   height: 110.0,
                        //   child: CircleAvatar(
                        //   // child: (image != null)?Image.asset('assets/user.jpg',)
                        //    // :backgroundImage: AssetImage('assets/user.jpg'),
                        //   ),
                        // ),
                        Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          width: 30.0,
                          height: 30.0,
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(Icons.camera_alt),
                                            title: Text('Camera'),
                                            onTap: () {
                                              picker2();
                                            },
                                          ),
                                          ListTile(
                                            leading:
                                                Icon(Icons.add_photo_alternate),
                                            title: Text('Gallery'),
                                            onTap: () {
                                              picker();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 13.0,
                              ),
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                    SizedBox(
                          height: 10,
                        ),
            TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return 'please type an Email';
                }
              } ,
              onSaved: (input) => _email = input,
              // decoration: InputDecoration(
              //   labelText: 'Email'
              // ),
              style: TextStyle(fontWeight: FontWeight.w500),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.check),
                        hintText: 'Your Email',
                        labelText: 'Your Email',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)
                        )
            ),
            SizedBox(
                  height: 10.0,
                ),
            TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return 'please type an Password';
                }
              } ,
              onChanged: (value){
                    this._password=value;  // this.
                  },
              // decoration: InputDecoration(
              //   labelText: 'Password'
              // ),
                  style: TextStyle(fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        hintText: 'Something like 123qwe',
                        labelText: 'Password',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)
                        ),
              obscureText: true,  
            ),
            SizedBox(
                  height: 10.0,
                ),
            TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return 'please Confirm your password';
                }
              } ,
              onChanged: (value){
                    this._confirmpassword=value;  // this.
                  },
              // decoration: InputDecoration(
              //   labelText: 'Re Type Password'
              // ),
                   obscureText: true,
                    style: TextStyle(fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)), 
            ),
            SizedBox(
                  height: 10.0,
                ),
            // RaisedButton(
            //   onPressed: /*cheek*/(){},
            //   child: Text('Sign up'),
            // )
            TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return 'please type your Nmae';
                }
              } ,
              onChanged: (value){
                    this._name=value;  // this.
                  },
              // decoration: InputDecoration(
              //   labelText: 'Re Type Password'
              // ),
                 //  obscureText: true,
                    style: TextStyle(fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        hintText: 'Name',
                        labelText: 'Name',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)), 
            ),
            //////////////////////////////
            SizedBox(
                  height: 10.0,
                ),
            TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return 'please type your phone';
                }
              } ,
              onChanged: (value){
                    this._phone=value;  // this.
                  },
              // decoration: InputDecoration(
              //   labelText: 'Re Type Password'
              // ),
                  // obscureText: true,
                  keyboardType: TextInputType.number,
                    style: TextStyle(fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        hintText: 'Phone',
                        labelText: 'Phone',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)), 
            ),
            /////////////////////////
            SizedBox(
                  height: 10.0,
                ),
            TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return 'please enter your address';
                }
              } ,
              onChanged: (value){
                    this._address=value;  // this.
                  },
              // decoration: InputDecoration(
              //   labelText: 'Re Type Password'
              // ),
                  // obscureText: true,
                    style: TextStyle(fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        hintText: 'Address',
                        labelText: 'Adress',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)), 
            ),
            /////////////////////////
             Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: RawMaterialButton(
                    onPressed: cheek,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Color(0xFFFD4F99), fontWeight: FontWeight.w400),
                      ),
                    ),
                    elevation: 6.0,
                    fillColor: Colors.black,
                    shape: StadiumBorder(),
                  ),
                ),
          ],
        ),
      ),


                // TextField(/////////////////////////
                //     style: TextStyle(fontWeight: FontWeight.w500),
                //     keyboardType: TextInputType.emailAddress,
                //     decoration: InputDecoration(
                //         suffixIcon: Icon(Icons.check),
                //         hintText: 'Your Email',
                //         labelText: 'Your Email',
                //         labelStyle: TextStyle(fontWeight: FontWeight.w400))),
                // SizedBox(
                //   height: 10.0,
                // ),
                // TextField(
                //     style: TextStyle(fontWeight: FontWeight.w500),
                //     decoration: InputDecoration(
                //         hintText: 'Name',
                //         labelText: 'Name',
                //         labelStyle: TextStyle(fontWeight: FontWeight.w400))),
                // SizedBox(
                //   height: 10.0,
                // ),
                // TextField(
                //     obscureText: true,
                //     style: TextStyle(fontWeight: FontWeight.w500),
                //     decoration: InputDecoration(
                //         hintText: 'Password',
                //         labelText: 'Password',
                //         labelStyle: TextStyle(fontWeight: FontWeight.w400))),
                // Padding(
                //   padding: const EdgeInsets.only(top: 30.0),
                //   child: RawMaterialButton(
                //     onPressed: () {},
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(vertical: 12.0),
                //       child: Text(
                //         'Sign Up',
                //         style: TextStyle(
                //             color: Colors.white, fontWeight: FontWeight.w400),
                //       ),
                //     ),
                //     elevation: 6.0,
                //     fillColor: Colors.black,
                //     shape: StadiumBorder(),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Or sign up with Social account',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.0),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 140.0,
                      child: OutlineButton(
                        splashColor: Colors.black,
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Icon(Icons.android),
                            Icon(
                                MdiIcons.google,
                                color: Colors.black,
                                size: 13.0,
                              ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Google')
                          ],
                        ),
                        shape: StadiumBorder(),
                        borderSide: BorderSide(width: 1.5),
                      ),
                    ),
                    // Container(
                    //   width: 140,
                    //   child: OutlineButton(
                    //     splashColor: Colors.black,
                    //     onPressed: () {},
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: <Widget>[
                    //         Icon(Icons.android),
                    //         SizedBox(
                    //           width: 5.0,
                    //         ),
                    //         Text('Twittter')
                    //       ],
                    //     ),
                    //     shape: StadiumBorder(),
                    //     borderSide: BorderSide(width: 1.5),
                    //   ),
                    // ),
                    SizedBox(
                  height: 10.0,
                ),
                  ],
                  
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 100.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       Text(
                //         'By signing up you agree to our ',
                //         style: TextStyle(
                //           fontSize: 16.0,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Text(
                //           'Terms of Use',
                //           style: TextStyle(
                //               fontSize: 16.0,
                //               fontWeight: FontWeight.w500,
                //               decoration: TextDecoration.underline),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Text(
                //       'and ',
                //       style: TextStyle(
                //           fontSize: 16.0, fontWeight: FontWeight.w500),
                //     ),
                //     GestureDetector(
                //       onTap: () {},
                //       child: Text(
                //         'Privicy Policy',
                //         style: TextStyle(
                //             fontSize: 16.0,
                //             fontWeight: FontWeight.w500,
                //             decoration: TextDecoration.underline),
                //       ),
                //     )
                //   ],
                // )
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  

  void cheek() async{
                  if(_password == _confirmpassword){
                   
                    signUp();
                      
                   
                  }else{
                     print(_password);
                   print(_confirmpassword);
                   print("wrongpassword");
                   dialogTigger(context);

                  }
                }

    void signUp() async {
     

    List<String>splitname= _name.split(" ");
     List<String>indexList = [];

     for(int i =0; i < splitname.length; i++){
       for(int y=1; y < splitname[i].length+1; y++){
          indexList.add(splitname[i].substring(0,y).toLowerCase());
       }

     }



    if(_formkey.currentState.validate()){ 
      _formkey.currentState.save();
       Toast.show("Please Wait", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      try{
        //AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        print(user.uid);
        user.sendEmailVerification();
        // Display for the user that we send an email
      if(image != null){
         await uploadPic(); 
       await Firestore.instance.collection('user').document(user.uid).setData(
         { 
           'name': _name ,
           'phone': _phone,
           'address': _address,
           'photo': this.URL,
           'id': user.uid,
           'email': _email,
           'serchIndex':indexList,
         }
        );
      }else{
        await Firestore.instance.collection('user').document(user.uid).setData(
         { 
           'name': _name ,
           'phone': _phone,
           'address': _address,
           'photo': "https://www.eguardtech.com/wp-content/uploads/2018/08/Network-Profile.png",
           'id': user.uid,
           'email': _email,
           'serchIndex':indexList,
         }
        );
      }
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Interests())) ;
        
        
               //Todo: Navigate to home
      }catch(e){
        print(e.message);
        Toast.show("something went wrong", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      }
    }
  }
  Future<bool>dialogTigger(BuildContext context){
  return showDialog(
    barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return new AlertDialog(
          title: new Text('', style: TextStyle(fontSize: 15.0),),
          content: Text('password doesnt match'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('ok'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      }
  );
}
}  



