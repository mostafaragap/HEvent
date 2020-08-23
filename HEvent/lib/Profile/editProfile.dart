import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HEvent/Profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:io';

import 'package:toast/toast.dart';
import 'package:path/path.dart' as p;

class editProfile extends StatefulWidget {
  String photo;
  editProfile({this.photo});
  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  FirebaseUser user;
  Future<void> getUser() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      print(user.uid);
    });
  } //////////////////////////////////////////////////////////////get user id

  @override
  void initState() {
    super.initState();

    getUser();
  }

  File image;

  picker() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    // File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      //image = img;
      setState(() {
        image = img;
        // filename = basename(image.path);
      });
    }
  }

  picker2() async {
    //  File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      //image = img;
      setState(() {
        image = img;
      });
    }
  }

  //////this is fun that wprk to upload to fire storage w bakhod el url w bkzna f el database
  String URL = ""; //a  ay String lazm ykoon b value

  //async

  Future uploadPic() async {
    final String filename = p.basename(
        image.path); // lazm a3dy 3la mara7el 3shan a5od soura mn device
    final FirebaseStorage storage =
        FirebaseStorage(storageBucket: 'gs://finalecommerce-823b1.appspot.com');
    // StorageReference reference = FirebaseStorage.instance.ref().child(filename);
    StorageReference reference =
        storage.ref(). /*child('giftShopItems').*/ child(filename);
    StorageUploadTask upload = reference.putFile(image);

    var downurl = await (await upload.onComplete).ref.getDownloadURL();
    setState(() {
      this.URL = downurl.toString();
      print(this.URL);
      print(filename);
    });
  }

  String _email, _name, _bio, _phone, _address, _samePhoto = ".";
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        leading: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              // Navigator.pushReplacement(
              //     context, //////////////////////////// navigation without go back
              //     new MaterialPageRoute(builder: (context) {
              //   return new ProfileScreen();
              // }));
              Navigator.pop(context);
              //                Navigator.of(context).push(
              // new MaterialPageRoute( builder: (context){
              //   return new ProfileScreen();
              //    }
              //    )
              //    );
            }),
        backgroundColor: Colors.black,
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
            onPressed: () {
              _editProfile();
            },
          )
        ],
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('user')
              .document(user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('loading Data ...Please Wait');

            return new ListView(
              children: <Widget>[
                SizedBox(
                  height: 10, //bstd5dmha 3sahn a3ml msa7a wahmia
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Align(
                        //bstd5dmha 3shan azbt el position bta3y
                        alignment: Alignment.topCenter,
                        child: Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 55,
                              backgroundColor: Color(0xff476cfb),
                              child: ClipOval(
                                child: new SizedBox(
                                  width: 110.0,
                                  height: 110.0,
                                  child: (image != null)
                                      ? Image.file(
                                          image,
                                          fit: BoxFit.fill,
                                          //ELSE
                                        )
                                      : Image.network(
                                          snapshot.data['photo'],
                                          fit: BoxFit.fill,
                                        ),
                                  // setState(() {
                                  //   _samePhoto =
                                  //       snapshot.data['photo'];
                                  //   });
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
                                                leading: Icon(
                                                    Icons.add_photo_alternate),
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
                                    Icons.camera_alt,
                                    color: Colors.black,
                                    size: 13.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FlatButton(
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
                                      leading: Icon(Icons.add_photo_alternate),
                                      title: Text('Gallery'),
                                      onTap: () {
                                        picker();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Text(
                          'Change Profile Photo',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        color: Colors.white,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Container(
                        //height: 450,
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 30, right: 30, bottom: 30, top: 7.5),
                          child: Form(
                            key: _formkey, //el mas2ol 3n save form

                            child: Column(
                              children: <Widget>[
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Text(
                                        'Name:',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    //  SizedBox(width: MediaQuery.of(context).size.width*0.3),

                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: TextFormField(
                                          initialValue: snapshot.data['name'],
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          validator: (input) {
                                            if (input.isEmpty) {
                                              return 'please type a Name';
                                            }
                                          },
                                          onSaved: (input) => _name = input,
                                        )
                                        // ),
                                        ),
                                  ],
                                ), //row1
                                SizedBox(
                                  height: 12.5,
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 12.5,
                                ),
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Text(
                                        'BIO:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
                                    Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: TextFormField(
                                          maxLength: 150,
                                          // initialValue: snapshot.data['BIO Profile'],
                                          //  initialValue: checkbio(snapshot.data['BIO Profile']),

                                          //child:(snapshot.data['BIO Profile'] != null)? Text(snapshot.data['BIO Profile']):Text('Please fiil the info'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                          decoration: InputDecoration(
                                              hintText: '',
                                              labelText: 'BIO',
                                              labelStyle: TextStyle(
                                                  fontWeight: FontWeight.w400)),
                                          validator: (input) {
                                            if (input.isEmpty) {
                                              return 'please type a BIO';
                                            }
                                          },
                                          onSaved: (input) => _bio = input,
                                        ),
                                      ),
                                    ),
                                  ],
                                ), //row2
                                // SizedBox(
                                //   height: 12.5,
                                // ),
                                // Divider(
                                //   color: Colors.black,
                                // ),
                                // SizedBox(
                                //   height: 12.5,
                                // ),

                                // Row(
                                //     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: <Widget>[
                                //       Container(
                                //         width:
                                //             MediaQuery.of(context).size.width *
                                //                 0.3,
                                //         child: Text(
                                //           'Email:',
                                //           style: TextStyle(
                                //             fontSize: 16,
                                //             fontStyle: FontStyle.normal,
                                //             fontWeight: FontWeight.bold,
                                //           ),
                                //         ),
                                //       ),
                                //       //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
                                //       Container(
                                //         width:
                                //             MediaQuery.of(context).size.width *
                                //                 0.4,
                                //         child: TextFormField(
                                //           initialValue: snapshot.data['email'],
                                //           decoration: InputDecoration(
                                //             border: InputBorder.none,
                                //           ),
                                //           validator: (input) {
                                //             if (input.isEmpty) {
                                //               return 'please type an Email';
                                //             }
                                //           },
                                //           onSaved: (input) => _email = input,
                                //         ),
                                //       ),
                                //     ]), //row4
                                SizedBox(
                                  height: 12.5,
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 12.5,
                                ),
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Text(
                                        'Address:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: TextFormField(
                                        initialValue: snapshot.data['address'],
                                        validator: (input) {
                                          if (input.isEmpty) {
                                            return 'please type an Address';
                                          }
                                        },
                                        onSaved: (input) => _address = input,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ), //row4
                                SizedBox(
                                  height: 12.5,
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 12.5,
                                ),
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Text(
                                        'Phone:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: TextFormField(
                                        initialValue: snapshot.data['phone'],
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        validator: (input) {
                                          if (input.isEmpty) {
                                            return 'please type a phone';
                                          }
                                        },
                                        onSaved: (input) => _phone = input,
                                      ),
                                    ),
                                  ],
                                ), //row5
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  void _editProfile() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      try {
        if (image == null) {
          await Firestore.instance
              .collection('user')
              .document(user.uid)
              .updateData({
            'name': _name,
            'BIO Profile': _bio,
            'address': _address,
            // 'email': _email,
            'phone': _phone,
            'photo': widget.photo,
          });
        } else {
          await uploadPic();
          await Firestore.instance
              .collection('user')
              .document(user.uid)
              .updateData({
            'name': _name,
            'BIO Profile': _bio,
            'address': _address,
            // 'email': _email,
            'phone': _phone,
            'photo': this.URL,
          });
        }

        Toast.show("Profile Edited", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

        //Todo: Navigate to home
      } catch (e) {
        print(e);
        Toast.show("Error", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    }
  }

  void checkbio(String i) {
// (snapshot.data['BIO Profile'] != null)? Text(snapshot.data['BIO Profile']):Text('Please fiil the info'),
  }
}
