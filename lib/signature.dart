import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:approvalproject/globals/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

class SignatureForm extends StatefulWidget {
  SignatureForm({Key key}) : super(key: key);
  @override
  _SignatureFormState createState() => _SignatureFormState();
}

class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 0,
        Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _WatermarkPaint &&
          runtimeType == other.runtimeType &&
          price == other.price &&
          watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}

class _SignatureFormState extends State<SignatureForm> {
  ByteData _img = ByteData(0);
  var color = Colors.black;
  var strokeWidth = 3.0;
  final _sign = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Signature(
                  color: color,
                  key: _sign,
                  onSign: () {
                    final sign = _sign.currentState;
                    debugPrint('${sign.points.length} points in the signature');
                  },
                  backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                  strokeWidth: strokeWidth,
                ),
              ),
              color: Colors.black12,
            ),
          ),
          _img.buffer.lengthInBytes == 0
              ? Container()
              : LimitedBox(
                  maxHeight: 200.0,
                  child: Image.memory(_img.buffer.asUint8List())),
          Column(
            children: <Widget>[
              SizedBox(
                height: 16.0,
              ),Text(
                'Masukkan Tanda Tangan Anda',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      color: Colors.green,
                      onPressed: () async {
                        final sign = _sign.currentState;
                        //set image datanya disini, mau di sep lokal atau ngirim ke server
                        final image = await sign.getData();
                        var data = await image.toByteData(
                            format: ui.ImageByteFormat.png);
                        sign.clear();
                        final encoded =
                        base64.encode(data.buffer.asUint8List());
                        setState(() {
                          _img = data;
                        });
                        final code = base64Decode(encoded);
                        Uint8List _toImage = code;
                        ttd = _toImage;
                        debugPrint("onPressed " + code.toString());
                      },
                      child: Text("Save",
                      style: TextStyle(color: Colors.white),),),
                  MaterialButton(
                      color: Colors.red,
                      onPressed: () {
                        final sign = _sign.currentState;
                        sign.clear();
                        setState(() {
                          _img = ByteData(0);
                        });
                        debugPrint("cleared");
                      },
                      child: Text("Clear",
                      style: TextStyle(color: Colors.white),)),
                ],
              ),
              SizedBox(
                height: 18.0,
              )

//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  MaterialButton(
//                      onPressed: () {
//                        setState(() {
//                          color = color == Colors.green ? Colors.red : Colors.green;
//                        });
//                        debugPrint("change color");
//                      },
//                      child: Text("Change color")),
//                  MaterialButton(
//                      onPressed: () {
//                        setState(() {
//                          int min = 1;
//                          int max = 10;
//                          int selection = min + (Random().nextInt(max - min));
//                          strokeWidth = selection.roundToDouble();
//                          debugPrint("change stroke width to $selection");
//                        });
//                      },
//                      child: Text("Change stroke width")),
//                ],
//              ),
            ],
          )
        ],
      ),
    );
  }
}
