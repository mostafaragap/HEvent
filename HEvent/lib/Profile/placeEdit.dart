import 'dart:io';

import 'package:HEvent/Profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:some_calendar/some_calendar.dart';
import 'package:toast/toast.dart';
// import 'package:shop_app_admin/db/product.dart';
// import '../db/category.dart';
// import '../db/brand.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class placeEdit extends StatefulWidget {
  String placeID;
  placeEdit({this.placeID});
  @override
  _placeEditState createState() => _placeEditState();
}

class _placeEditState extends State<placeEdit> {
  FirebaseUser user;
  Future<void> getUser() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      print(user.uid);
    });
  } //////////////////////////////////////////////////////////////get user id

  //////////////////////////////////////////////////////////////get user id

  SharedPreferences pref;
  var ID = "non";
  loadData() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      ID = pref.getString('ID');
    });
    return ID;
  }

  @override
  void initState() {
    super.initState();

    getUser();
    loadData();
  }

  // CategoryService _categoryService = CategoryService();
  // BrandService _brandService = BrandService();
  // ProductService productService = ProductService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quatityController = TextEditingController();
  final priceController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];

  DateTime selectedDate = DateTime.now();
  List<DateTime> selectedDates = List();
  List<DateTime> finalDates = List();

  String _currentCategory;
  String _currentBrand;
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  List<String> selectPlaceType = <String>[];
  File _image1;
  File _image2;
  File _image3;
  bool isLoading = false;

  String _placename,
      _placedescription,
      _placeaddress,
      _placecapacity,
      _placeprice;

  var _placepriceparse;
  var _placecapacityparse;
  var _getimage1, _getimage2, _getimage3;

  @override
  // void initState() {
  //   _getCategories();
  //   _getBrands();
  // }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(categories[i].data['category']),
                value: categories[i].data['category']));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandosDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(brands[i].data['brand']),
                value: brands[i].data['brand']));
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Place Edit"),
          backgroundColor: Colors.blue,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('place')
                .document(widget.placeID)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('loading Data ...Please Wait');

              List<DateTime> d = new List();

              if (snapshot.data['schedule'] != null) {
                var t = snapshot.data['schedule'];
                print(t.length);

                _getimage1 = snapshot.data['images'][0];

                print(_getimage1);
                _getimage2 = snapshot.data['images'][1];
                _getimage3 = snapshot.data['images'][2];

                // fit: BoxFit.fill,

                // _getimage2 = Image.network(
                //   snapshot.data['images'][1],
                //   // fit: BoxFit.fill,
                // );
                // _getimage3 = Image.network(
                //   snapshot.data['images'][2],
                //   // fit: BoxFit.fill,
                // );

                //    print(snapshot.data['schedule'][1].toDate());
                // List d;
                // var d  = new List(t.length);

                var s;

                for (var i = 0; i < t.length; i++) {
                  //  print(t[i].toDate());
                  // d[i] = t[i].toDate();
                  d.add(t[i].toDate());
                  // s.add(d);
                  // d[i]=snapshot.data['schedule'][i].toDate();
                }
                print(d);
              }
              // if (snapshot.data['schedule'] != null) {
              //   var t = snapshot.data['schedule'];
              //   print(t.length);
              //   //    print(snapshot.data['schedule'][1].toDate());
              //   // List d;
              //   // var d  = new List(t.length);

              //   var s;

              //   for (var i = 0; i < t.length; i++) {
              //     //  print(t[i].toDate());
              //     // d[i] = t[i].toDate();
              //     d.add(t[i].toDate());
              //     // s.add(d);
              //     // d[i]=snapshot.data['schedule'][i].toDate();
              //   }
              //   print(d);
              //   }
              //  print(selectedDate);
              return new Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: OutlineButton(
                                        borderSide: BorderSide(
                                            color: grey.withOpacity(0.5),
                                            width: 2.5),
                                        onPressed: () {
                                          _selectImage(
                                              ImagePicker.pickImage(
                                                  source: ImageSource.gallery),
                                              1);
                                        },
                                        child: _displayChild1()),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: OutlineButton(
                                        borderSide: BorderSide(
                                            color: grey.withOpacity(0.5),
                                            width: 2.5),
                                        onPressed: () {
                                          _selectImage(
                                              ImagePicker.pickImage(
                                                  source: ImageSource.gallery),
                                              2);
                                        },
                                        child: _displayChild2()),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: OutlineButton(
                                      borderSide: BorderSide(
                                          color: grey.withOpacity(0.5),
                                          width: 2.5),
                                      onPressed: () {
                                        _selectImage(
                                            ImagePicker.pickImage(
                                                source: ImageSource.gallery),
                                            3);
                                      },
                                      child: _displayChild3(),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Text(
                            //     'enter a place name with 20 characters at maximum',
                            //     textAlign: TextAlign.center,
                            //     style: TextStyle(color: red, fontSize: 12),
                            //   ),
                            // ),

                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                //controller: productNameController,
                                initialValue: snapshot.data['placeName'],
                                decoration:
                                    InputDecoration(hintText: 'Place name'),

                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'You must enter the place name';
                                  } else if (value.length < 3) {
                                    return 'write more than 10 letters';
                                  } else if (value.length > 20) {
                                    return 'place name cant have more than 20 letters';
                                  }
                                },
                                onSaved: (value) => _placename = value,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                initialValue: snapshot.data['placeDescription'],
                                //controller: productNameController,
                                decoration: InputDecoration(
                                    hintText: 'Place Description'),
                                maxLength: 150,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'You must enter the place Description';
                                  } else if (value.length > 150) {
                                    return 'You must enter the Place Description';
                                  }
                                },
                                onSaved: (value) => _placedescription = value,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                initialValue: snapshot.data['placeAddress'],
                                //controller: productNameController,
                                decoration:
                                    InputDecoration(hintText: 'Place Address'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'You must enter the place Address';
                                  }
                                },
                                onSaved: (value) => _placeaddress = value,
                              ),
                            ),

// //              select category
//                     Row(
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             'Category: ',
//                             style: TextStyle(color: red),
//                           ),
//                         ),
//                         DropdownButton(
//                           items: categoriesDropDown,
//                           onChanged: changeSelectedCategory,
//                           value: _currentCategory,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             'Brand: ',
//                             style: TextStyle(color: red),
//                           ),
//                         ),
//                         DropdownButton(
//                           items: brandsDropDown,
//                           onChanged: changeSelectedBrand,
//                           value: _currentBrand,
//                         ),
//                       ],
//                     ),

//
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                initialValue: snapshot.data['placecapacity'].toString(),

                                // controller: quatityController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Place Capacity',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'You must enter the place Capacity';
                                  }
                                },
                                onSaved: (value) => _placecapacity = value,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                // controller: priceController,
                                initialValue:
                                    snapshot.data['placePrice'].toString(),

                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Place Price',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'You must enter the Place Price';
                                  }
                                },
                                onSaved: (value) => _placeprice = value,
                              ),
                            ),

                            Row(
                              //Row 8
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'schedule:',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                //  SizedBox(width: MediaQuery.of(context).size.width*0.3),
                                RaisedButton(
                                  child: Text("please select a work time"),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => SomeCalendar(
                                              mode: SomeMode.Multi,
                                              startDate:
                                                  Jiffy().subtract(years: 2),
                                              lastDate: Jiffy().add(months: 9),
                                              isWithoutDialog: false,
                                              selectedDate: selectedDate,
                                              selectedDates:
                                                  d, ////////////////////////////////////
                                              done: (date) {
                                                setState(() {
                                                  print(selectedDates);
                                                  finalDates = date;
                                                });
                                              },
                                            ));
                                  },
                                ),
                              ],
                            ), //row8
                            SizedBox(
                              height: 12.5,
                            ),
                            Divider(
                              color: Colors.black,
                            ),

                            Text(
                              'Place Type',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            Row(
                              children: <Widget>[
                                Checkbox(
                                    value:
                                        selectPlaceType.contains('Workshops'),
                                    onChanged: (value) =>
                                        changeSelctedEventType('Workshops')),
                                Text('Workshops'),
                                Checkbox(
                                    value:
                                        selectPlaceType.contains('Educational'),
                                    onChanged: (value) =>
                                        changeSelctedEventType('Educational')),
                                Text('Educational'),
                              ],
                            ),

                            Row(
                              children: <Widget>[
                                Checkbox(
                                    value: selectPlaceType
                                        .contains('Press Conference'),
                                    onChanged: (value) =>
                                        changeSelctedEventType(
                                            'Press Conference')),
                                Text('Press Conference'),
                                Checkbox(
                                    value:
                                        selectPlaceType.contains('Trade Shows'),
                                    onChanged: (value) =>
                                        changeSelctedEventType('Trade Shows')),
                                Text('Trade Shows'),
                              ],
                            ),

                            Row(
                              children: <Widget>[
                                Checkbox(
                                    value:
                                        selectPlaceType.contains('Marketing'),
                                    onChanged: (value) =>
                                        changeSelctedEventType('Marketing')),
                                Text('Marketing'),
                                Checkbox(
                                    value: selectPlaceType.contains('Party'),
                                    onChanged: (value) =>
                                        changeSelctedEventType('Party')),
                                Text('Party'),
                              ],
                            ),

                            // Row(
                            //   children: <Widget>[
                            //     Checkbox(
                            //         value: selectedSizes.contains('40'),
                            //         onChanged: (value) => changeSelectedSize('40')),
                            //     Text('40'),
                            //     Checkbox(
                            //         value: selectedSizes.contains('42'),
                            //         onChanged: (value) => changeSelectedSize('42')),
                            //     Text('42'),
                            //     Checkbox(
                            //         value: selectedSizes.contains('44'),
                            //         onChanged: (value) => changeSelectedSize('44')),
                            //     Text('44'),
                            //     Checkbox(
                            //         value: selectedSizes.contains('46'),
                            //         onChanged: (value) => changeSelectedSize('46')),
                            //     Text('46'),
                            //     Checkbox(
                            //         value: selectedSizes.contains('48'),
                            //         onChanged: (value) => changeSelectedSize('48')),
                            //     Text('48'),
                            //     Checkbox(
                            //         value: selectedSizes.contains('50'),
                            //         onChanged: (value) => changeSelectedSize('50')),
                            //     Text('50'),
                            //   ],
                            // ),

                            FlatButton(
                              color: red,
                              textColor: white,
                              child: Text('Edit Place'),
                              onPressed: () {
                                validateAndUpload();
                              },
                            )
                          ],
                        ),
                ),
              );
            }));
  }

  // _getCategories() async {
  //   List<DocumentSnapshot> data = await _categoryService.getCategories();
  //   print(data.length);
  //   setState(() {
  //     categories = data;
  //     categoriesDropDown = getCategoriesDropdown();
  //     _currentCategory = categories[0].data['category'];
  //   });
  // }

  // _getBrands() async {
  //   List<DocumentSnapshot> data = await _brandService.getBrands();
  //   print(data.length);
  //   setState(() {
  //     brands = data;
  //     brandsDropDown = getBrandosDropDown();
  //     _currentBrand = brands[0].data['brand'];
  //   });
  // }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => _currentCategory = selectedBrand);
  }

  void changeSelctedEventType(String size) {
    if (selectPlaceType.contains(size)) {
      setState(() {
        selectPlaceType.remove(size);
      });
    } else {
      setState(() {
        selectPlaceType.insert(0, size);
      });
    }
  }

  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => _image1 = tempImg);
        break;
      case 2:
        setState(() => _image2 = tempImg);
        break;
      case 3:
        setState(() => _image3 = tempImg);
        break;
    }
  }

  Widget _displayChild1() {
    if (_image1 != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.network(
        _getimage1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild2() {
    if (_image2 != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.network(
        _getimage2,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild3() {
    if (_image3 != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.network(
        _getimage3,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() => isLoading = true);
      if (_image1 != null && _image2 != null && _image3 != null) {
        if (selectPlaceType.isNotEmpty && finalDates.isNotEmpty) {
          String imageUrl1;
          String imageUrl2;
          String imageUrl3;

          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture1 =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task1 =
              storage.ref().child(picture1).putFile(_image1);
          final String picture2 =
              "2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task2 =
              storage.ref().child(picture2).putFile(_image2);
          final String picture3 =
              "3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task3 =
              storage.ref().child(picture3).putFile(_image3);

          StorageTaskSnapshot snapshot1 =
              await task1.onComplete.then((snapshot) => snapshot);
          StorageTaskSnapshot snapshot2 =
              await task2.onComplete.then((snapshot) => snapshot);

          task3.onComplete.then((snapshot3) async {
            imageUrl1 = await snapshot1.ref.getDownloadURL();
            imageUrl2 = await snapshot2.ref.getDownloadURL();
            imageUrl3 = await snapshot3.ref.getDownloadURL();
            List<String> imageList = [imageUrl1, imageUrl2, imageUrl3];

            _placepriceparse = int.parse(_placeprice);
            _placecapacityparse = int.parse(_placecapacity);

            // productService.uploadProduct({
            //   "name":productNameController.text,
            //   "price":double.parse(priceController.text),
            //   "sizes":selectedSizes,
            //   "images":imageList,
            //   "quantity":int.parse(quatityController.text),
            //   "brand":_currentBrand,
            //   "category":_currentCategory
            // });
            List<String> splitname = _placename.split(" ");
            List<String> indexList = [];
            for (int i = 0; i < splitname.length; i++) {
              for (int y = 1; y < splitname[i].length + 1; y++) {
                indexList.add(splitname[i].substring(0, y).toLowerCase());
              }
            }

            final FirebaseMessaging _fcm = FirebaseMessaging();
            _fcm.getToken().then((token) async {
              Firestore.instance
                  .collection('place')
                  .document(widget.placeID)
                  .updateData({
                'placeName': _placename,
                'placeDescription': _placedescription,
                'placeAddress': _placeaddress,
                'placecapacity': _placecapacityparse,
                'placePrice': _placepriceparse,
                "images": imageList,
                "placType": selectPlaceType,
                "PlaceOwnerId": user.uid,
                'serchIndex': indexList,
                "token": token,
                'schedule': finalDates,
                'activePlace': true,
              });
            });
            /*   await Firestore.instance.collection('place').document().setData({
              'placeName': _placename,
              'placeDescription': _placedescription,
              'placeAddress': _placeaddress,
              'placecapacity': _placecapacity,
              'placePrice': _placeprice,
              "images": imageList,
              "placType": selectPlaceType,
              "PlaceOwnerId": user.uid,
              'serchIndex': indexList,
            });*/
            _formKey.currentState.reset();
            setState(() => isLoading = false);
            //    Fluttertoast.showToast(msg: 'Place added');
            Toast.show("Place Edited", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

            //Navigator.pop(context);
          });
        } else {
          setState(() => isLoading = false);

          //     Fluttertoast.showToast(msg: 'select atleast one size');
          Toast.show("select atleast one Place Type", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      } else {
        if (selectPlaceType.isEmpty) {
          setState(() => isLoading = false);

          //     Fluttertoast.showToast(msg: 'select atleast one size');
          Toast.show("select at least one Place Type", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        } else if (finalDates.isEmpty) {
          setState(() => isLoading = false);

          //     Fluttertoast.showToast(msg: 'select atleast one size');
          Toast.show(
              "Check the Dates in Schedule before operation Done", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        } else {
          // setState(() => isLoading = false);

          // //  Fluttertoast.showToast(msg: 'all the images must be provided');
          // Toast.show("all the images must be provided", context,
          //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

          List<String> imageList = [_getimage1, _getimage2, _getimage3];

          _placepriceparse = int.parse(_placeprice);
          _placecapacityparse = int.parse(_placecapacity);

          // productService.uploadProduct({
          //   "name":productNameController.text,
          //   "price":double.parse(priceController.text),
          //   "sizes":selectedSizes,
          //   "images":imageList,
          //   "quantity":int.parse(quatityController.text),
          //   "brand":_currentBrand,
          //   "category":_currentCategory
          // });
          List<String> splitname = _placename.split(" ");
          List<String> indexList = [];
          for (int i = 0; i < splitname.length; i++) {
            for (int y = 1; y < splitname[i].length + 1; y++) {
              indexList.add(splitname[i].substring(0, y).toLowerCase());
            }
          }

          final FirebaseMessaging _fcm = FirebaseMessaging();
          _fcm.getToken().then((token) async {
            Firestore.instance
                .collection('place')
                .document(widget.placeID)
                .updateData({
              'placeName': _placename,
              'placeDescription': _placedescription,
              'placeAddress': _placeaddress,
              'placecapacity': _placecapacityparse,
              'placePrice': _placepriceparse,
              "images": imageList,
              "placType": selectPlaceType,
              "PlaceOwnerId": user.uid,
              'serchIndex': indexList,
              "token": token,
              'schedule': finalDates,
              'activePlace': true,
            });
          });
          /*   await Firestore.instance.collection('place').document().setData({
              'placeName': _placename,
              'placeDescription': _placedescription,
              'placeAddress': _placeaddress,
              'placecapacity': _placecapacity,
              'placePrice': _placeprice,
              "images": imageList,
              "placType": selectPlaceType,
              "PlaceOwnerId": user.uid,
              'serchIndex': indexList,
            });*/
          // _formKey.currentState.reset();
          setState(() => isLoading = false);
          //    Fluttertoast.showToast(msg: 'Place added');
          Toast.show("Place Edited", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

          //Navigator.pop(context);
        }
      }
    }
  }
}
