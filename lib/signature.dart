import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:approvalproject/globals/variable.dart';
import 'package:approvalproject/request.dart';
import 'package:dio/dio.dart';
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


                        signForm(approvalFormId, data.buffer.asUint8List()).then((task){
                          approveForm(approvalFormId).then((task){
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
                              showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Approve Success"),
                                    content: Text(task.message),
                                    actions:[
                                      FlatButton(
                                          child: Text("Close"),
                                          onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new Request()))
                                      )
                                    ],
                                  );
                                },

                              );
                            }
                          });
                        });

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

    FormSignature newResponse = formSignatureFromJson(response.toString());
    return newResponse;
  }

  approveForm(String formId) async{
    var dio = Dio();
    String url = domain + "/api/v1/approve_form?form_id=" + formId;
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + globalUserDetails.idToken;

    Response response = await dio.post(url);
    print(response.data);
    String dummyResponse = '{"data":[{"id":11,"name":"F1 Form Approval Application 2","form_date":"2020-04-06","document_number":"11/F1-/April-IV/2020","cost_allocation":"Capex","purpose_of_issue":"New Contract","procurement_type":"Tender","issued_by":"Department Head IT","recurring_option":"Recurring","percentage":0.0},{"id":13,"name":"F1 Form Approval Application 3","form_date":"2020-04-08","document_number":"13/F1-/April-IV/2020","cost_allocation":"Capex","purpose_of_issue":"New Contract","procurement_type":"Tender","issued_by":"Department Head IT","recurring_option":"Recurring","percentage":0.0},{"id":15,"name":"F1 Form Approval System","form_date":"2020-04-27","document_number":"15/F1-/April-IV/2020","cost_allocation":"Capex","purpose_of_issue":"New Contract","procurement_type":"Comparison","issued_by":"Department Head IT","recurring_option":"Non Recurring","percentage":0.0}],"status":"success","message":"Data Retrieved successfully"}';

    FormApprove newResponse = formApproveFromJson(response.data);
    return newResponse;
  }

}
