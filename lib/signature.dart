import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:approvalproject/api_response_model/test_notif_response.dart';
import 'package:approvalproject/globals/variable.dart';
import 'package:approvalproject/new_request_detail.dart';
import 'package:approvalproject/request.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import 'api_response_model/form_approve.dart';
import 'api_response_model/form_signature.dart';

class SignatureForm extends StatefulWidget {
  final String approvalFormId;

  SignatureForm({Key key, this.approvalFormId}) : super(key: key);
  @override
  _SignatureFormState createState() => _SignatureFormState(approvalFormId);
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
  String approvalFormId;
  _SignatureFormState(this.approvalFormId);

  ByteData _img = ByteData(0);
  var color = Colors.black;
  var strokeWidth = 3.0;
  final _sign = GlobalKey<SignatureState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 28.0,bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 1,
                      child: MaterialButton(
                          color: Colors.red,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Back", style: TextStyle(color: Colors.white))),
                    ),
                    RotatedBox(
                      quarterTurns: 1,
                      child: MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            final sign = _sign.currentState;
                            sign.clear();
                            setState(() {
                              _img = ByteData(0);
                            });
                            debugPrint("cleared");
                          },
                          child: Text("Clear", style: TextStyle(color: Colors.white))),
                    ),
                    RotatedBox(
                      quarterTurns: 1,
                      child: MaterialButton(
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

                          showCircular(context);
                          signForm(approvalFormId, data.buffer.asUint8List()).then((task){
                            print("sign = " + task.status);
                            if(task.status=="success"){
                              approveForm(approvalFormId, data.buffer.asUint8List()).then((task) async {
                                if(task.status=="fail"){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                          title: Text("Approve Fail"),
                                          content: Text(task.message),
                                          actions:[
                                            FlatButton(
                                                child: Text("Close"),
                                                onPressed: () => Navigator.of(context).pop()
                                            )
                                          ],
                                        );
                                      }
                                  );
                                }else{
                                  testNotif();
                                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new Request()));
                                }
                              });
                            }else{
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      title: Text("Sign Fail"),
                                      content: Text(task.message),
                                      actions:[
                                        FlatButton(
                                            child: Text("Close"),
                                            onPressed: () => Navigator.of(context).pop()
                                        )
                                      ],
                                    );
                                  }
                              );
                            }

                          });

                        },
                        child: Text("Submit",
                          style: TextStyle(color: Colors.white),),),
                    ),
                  ],
                ),
                SizedBox(
                  width: 18.0,
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'Please sign here',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                  ),
                ),


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
            ),
          ),
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

        ],
      ),
    );
  }


  Future<FormSignature> signForm(String formId, var signature) async{
    var dio = Dio();
    print("signature form id = " + formId);
    String url = domain + "/api/v1/sign_form?form_id=" + formId;
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + globalUserDetails.idToken;

    var formData = FormData();
    formData.files.addAll([
    MapEntry(
    "signature",
    MultipartFile.fromBytes(signature, filename: "signature.png"),
    )]);

    Response response = await dio.post(url, data: formData);
    print(response.data);

    String dummyResponse = '{"status": "success", "message": "Sign Form Successful"}';
    FormSignature newResponse = formSignatureFromJson(response.toString());
    return newResponse;
  }



  approveForm(String formId, var signature) async{
    var dio = Dio();
    print("masuk approve, form id = " + formId);
    String url = domain + "/api/v1/approve_form?form_id=" + formId;
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + globalUserDetails.idToken;

    var formData = FormData();
    formData.files.addAll([
      MapEntry(
        "signature",
        MultipartFile.fromBytes(signature, filename: "signature.png"),
      )]);

    Response response = await dio.post(url, data: formData);
    print(response.data);

    String dummyResponse = '{"status": "success", "message": "Sign Form Successful"}';

    FormApprove newResponse = formApproveFromJson(response.toString());
    return newResponse;
  }



  testNotif() async{
    var dio = Dio();
    print("Test Notif masuk");
    String url = domain + "/api/v1/test_notification";
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + globalUserDetails.idToken;

    Response response = await dio.post(url);
    print(response.data);
    print("Test Notif Beres");

    String dummyResponse = '{"status": "success", "message": "Sign Form Successful"}';

    TestNotifResponse newResponse = testNotifResponseFromJson(response.toString());
    return newResponse;
  }


  showCircular(context){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }
    );
  }
}
