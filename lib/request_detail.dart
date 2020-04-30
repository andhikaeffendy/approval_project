import 'dart:io';

import 'package:approvalproject/api_response_model/detail_approval_form.dart';
import 'package:approvalproject/api_response_model/form_approve.dart';
import 'package:approvalproject/api_response_model/form_reject.dart';
import 'package:approvalproject/api_response_model/form_signature.dart';
import 'package:approvalproject/signature.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:intl/intl.dart';

import 'globals/variable.dart';

class RequestDetail extends StatefulWidget {
  final String approvalFormId;

  const RequestDetail({Key key, this.approvalFormId}) : super(key : key);

  @override
  _RequestDetailState createState() => _RequestDetailState(approvalFormId);
}

class _RequestDetailState extends State<RequestDetail> {
  String approvalFormId;
  _RequestDetailState(this.approvalFormId);

  TextEditingController rejectionText = TextEditingController();
  
  DateFormat dateFormat = new DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    print("app id = " + approvalFormId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Detail'),
      ),
      body: FutureBuilder(
        future: getDetailApproval(approvalFormId),
        builder: (context, snapshot){
          if(snapshot.data==null){
            return Container();
          }else{
            Data detailApprovalForm = snapshot.data.data;
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 320.0,
                      height: 400.0,
                      child: Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.circular(14.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                detailApprovalForm.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16.0),
                              ),
                              SizedBox(
                                height: 32.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text('Tanggal Request'),
                                  ),
                                  Container(
                                    child: Text(
                                      dateFormat.format(detailApprovalForm.formDate),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 14.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text('Judul Request'),
                                  ),
                                  Container(
                                    child: Text(
                                      detailApprovalForm.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text('Requester'),
                                  ),
                                  Container(
                                    child: Text(
                                      detailApprovalForm.issuedBy,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text('Nilai Request'),
                                  ),
                                  Container(
                                    child: Text(
                                      "Rp. " + detailApprovalForm.value.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text('Field 1'),
                                  ),
                                  Container(
                                    child: Text(
                                      'Isi Field 1',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text('Field 2'),
                                  ),
                                  Container(
                                    child: Text(
                                      'Isi Field 2',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    //space
                                  ),Text(
                                    'TTD',
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 100.0,
                                  ),GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                            new SignatureForm())),
                                    child: Container(
                                      width: 100.0,
                                      child: Image.asset('assets/logo.png'),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ImageButton(
                          children: <Widget>[],
                          width: 100.0,
                          height: 50.0,
                          paddingTop: 8.0,
                          pressedImage: Image.asset('assets/Button_approve.png'),
                          unpressedImage: Image.asset('assets/Button_approve.png'),
                          onTap: () => approveForm(approvalFormId).then((task){
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
                                          onPressed: () => Navigator.of(context).pop()
                                      )
                                    ],
                                  );
                                },

                              );
                            }
                          }),
                        ),
                        ImageButton(
                          children: <Widget>[],
                          width: 100.0,
                          height: 50.0,
                          paddingTop: 8.0,
                          pressedImage: Image.asset('assets/Button_tinjau.png'),
                          unpressedImage: Image.asset('assets/Button_tinjau.png'),
                          onTap: () {},
                        ),
                        ImageButton(
                          children: <Widget>[],
                          width: 100.0,
                          height: 50.0,
                          paddingTop: 8.0,
                          pressedImage: Image.asset('assets/Button_tolak.png'),
                          unpressedImage: Image.asset('assets/Button_tolak.png'),
                          onTap: () {
                            _showAlertDialog();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 300.0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Evaluation Analisis (Rejection)',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      child: TextField(
                        controller: rejectionText,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ImageButton(
                          children: <Widget>[],
                          width: 120.0,
                          height: 50.0,
                          paddingTop: 8.0,
                          pressedImage: Image.asset('assets/Button_reject.png'),
                          unpressedImage:
                              Image.asset('assets/Button_reject.png'),
                          onTap: () => rejectForm(approvalFormId, rejectionText.text).then((task){
                            if(task.status=="fail"){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      title: Text("Rejection Fail"),
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
                                      title: Text("Rejection Success"),
                                      content: Text(task.message),
                                      actions:[
                                        FlatButton(
                                          child: Text("Close"),
                                          onPressed: () => Navigator.of(context).pop()
                                        )
                                      ],
                                    );
                                  },

                              );
                            }
                          }),
                        ),
                        ImageButton(
                          children: <Widget>[],
                          width: 120.0,
                          height: 50.0,
                          paddingTop: 8.0,
                          pressedImage: Image.asset('assets/Button_cancel.png'),
                          unpressedImage:
                              Image.asset('assets/Button_cancel.png'),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  getDetailApproval(String formId) async {
    var dio = Dio();
    print("dio jalan");
    String url = domain + "/api/v1/detail_form?form_id=" + formId;
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + globalUserDetails.idToken;
    Response response = await dio.get(url);
    print("response : "+response.toString());
    DetailApprovalForm newResponse = detailApprovalFormFromJson(response.toString());
    print("Finish");
    return newResponse;
  }

  approveForm(String formId) async{
    var dio = Dio();
    String url = domain + "/api/v1/approve_form?form_id=" + formId;
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + globalUserDetails.idToken;

    Response response = await dio.post(url);
    print(response.data);

    FormApprove newResponse = formApproveFromJson(response.toString());
    return newResponse;
  }

  rejectForm(String formId, String reason) async{
    var dio = Dio();
    String url = domain + "/api/v1/reject_form";
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + globalUserDetails.idToken;

    FormData formData = new FormData.fromMap({
      "form_id": formId,
      "reason": reason,
    });

    Response response = await dio.post(url, data: formData);
    print(response.data);

    FormReject newResponse = formRejectFromJson(response.toString());
    return newResponse;
  }

  Future<FormSignature> signForm(String formId) async{
    var dio = Dio();
    String url = domain + "/api/v1/reject_form?form_id=" + formId;
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + globalUserDetails.idToken;

    FormData formData = new FormData.fromMap({
      "signature": " ",
    });

    Response response = await dio.post(url, data: formData);
    print(response.data);

    FormSignature newResponse = formSignatureFromJson(response.toString());
    return newResponse;
  }


}
