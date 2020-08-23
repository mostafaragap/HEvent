import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class qrgenerate extends StatefulWidget {
  String title,id;
  qrgenerate({this.title,this.id});
  @override
  _qrgenerateState createState() => _qrgenerateState();
}

class _qrgenerateState extends State<qrgenerate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
        backgroundColor:Color(0xFF353535),
      ),
          body: Center(
        child: QrImage(
          data: widget.id+"/"+widget.title,
 ),
      ),
    );
  }
}