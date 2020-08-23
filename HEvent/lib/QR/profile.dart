// Marketingimport 'dart:io';

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
// import 'package:shop_app_admin/db/product.dart';
// import '../db/category.dart';
// import '../db/brand.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class addplaces extends StatefulWidget {
  @override
  _addplacesState createState() => _addplacesState();
}

class _addplacesState extends State<addplaces> {
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
      // appBar: AppBar(
      //   elevation: 0.1,
      //   backgroundColor: white,
      //   leading: Icon(
      //     Icons.close,
      //     color: black,
      //   ),
      //   title: Text(
      //     "add product",
      //     style: TextStyle(color: black),
      //   ),
      // ),
      body: Form(
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
                                    color: grey.withOpacity(0.5), width: 2.5),
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
                                    color: grey.withOpacity(0.5), width: 2.5),
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
                                  color: grey.withOpacity(0.5), width: 2.5),
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
                        decoration: InputDecoration(hintText: 'Place name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'You must enter the place name';
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
                        //controller: productNameController,
                        decoration:
                            InputDecoration(hintText: 'Place Description'),
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
                        controller: productNameController,
                        decoration: InputDecoration(hintText: 'Place Address'),
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
                        controller: priceController,
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

                    Text(
                      'Place Type',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    Row(
                      children: <Widget>[
                        Checkbox(
                            value: selectPlaceType.contains('Workshops'),
                            onChanged: (value) =>
                                changeSelctedEventType('Workshops')),
                        Text('Workshops'),
                        Checkbox(
                            value: selectPlaceType.contains('Educational'),
                            onChanged: (value) =>
                                changeSelctedEventType('Educational')),
                        Text('Educational'),

                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Checkbox(
                            value: selectPlaceType.contains('Press Conference'),
                            onChanged: (value) =>
                                changeSelctedEventType('Press Conference')),
                        Text('Press Conference'),
                        Checkbox(
                            value: selectPlaceType.contains('Trade Shows'),
                            onChanged: (value) =>
                                changeSelctedEventType('Trade Shows')),
                        Text('Trade Shows'),

                      ],
                    ),

                    
                    Row(
                      children: <Widget>[
                        Checkbox(
                            value: selectPlaceType.contains('Marketing'),
                            onChanged: (value) =>
                                changeSelctedEventType('Marketing')),
                        Text('Marketing'),
                        Checkbox(
                            value: selectPlaceType.contains('Party '),
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
                      child: Text('Add Place'),
                      onPressed: () {
                        validateAndUpload();
                      },
                    )
                  ],
                ),
        ),
      ),
    );
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
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild2() {
    if (_image2 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image2,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild3() {
    if (_image3 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image3,
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
        if (selectPlaceType.isNotEmpty) {
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

            // productService.uploadProduct({
            //   "name":productNameController.text,
            //   "price":double.parse(priceController.text),
            //   "sizes":selectedSizes,
            //   "images":imageList,
            //   "quantity":int.parse(quatityController.text),
            //   "brand":_currentBrand,
            //   "category":_currentCategory
            // });

            Firestore.instance
                .collection('place')
                .document('6OLZy3ktjVPtQ3zvSNNKSv3njJq1')
                .setData({
              'placeName': _placename,
              'placeDescription': _placedescription,
              'placeAddress': _placeaddress,
              'placecapacity': _placecapacity,
              'placePrice': _placeprice,
              "images": imageList,
              "placType": selectPlaceType,
              
            });
            _formKey.currentState.reset();
            setState(() => isLoading = false);
        //    Fluttertoast.showToast(msg: 'Place added');
                Toast.show("Place added", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

            Navigator.pop(context);
          });
        } else {
          setState(() => isLoading = false);

     //     Fluttertoast.showToast(msg: 'select atleast one size');
                     Toast.show("select atleast one size", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);


        }
      } else {
        setState(() => isLoading = false);

      //  Fluttertoast.showToast(msg: 'all the images must be provided');
                      Toast.show("all the images must be provided", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

      }
    }
  }
}
