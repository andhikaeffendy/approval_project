import 'dart:io';

import 'package:approvalproject/api_response_model/detail_approval_form.dart';
import 'package:approvalproject/signature.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:intl/intl.dart';

import 'globals/variable.dart';

class RequestDetail extends StatefulWidget {
  @override
  _RequestDetailState createState() => _RequestDetailState();
}

class _RequestDetailState extends State<RequestDetail> {
  List<Offset> _points = <Offset>[];

  DateFormat dateFormat = new DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Detail'),
      ),
      body: FutureBuilder(
        future: getDetailApproval("11"),
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
                          onTap: () {},
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
                          onTap: () {},
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

  Future<DetailApprovalForm> getDetailApproval(String formId) async {
    var dio = Dio();
    print("dio jalan");
    String url = domain + "/api/v1/detail_form?form_id=" + formId;
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + "eyJhbGciOiJSUzI1NiIsImtpZCI6IjVlOWVlOTdjODQwZjk3ZTAyNTM2ODhhM2I3ZTk0NDczZTUyOGE3YjUiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQ2FuZXNoYSBEcmFnb24iLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDUuZ29vZ2xldXNlcmNvbnRlbnQuY29tLy1Nekh1UmZQdHJKWS9BQUFBQUFBQUFBSS9BQUFBQUFBQUFBQS9BQUtXSkpNcm5OeVZkWjY4WFhOQVhWZUVDcXlleHZuR3pnL3M5Ni1jL3Bob3RvLmpwZyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9mMS1mb3JtLWFwcHJvdmFsIiwiYXVkIjoiZjEtZm9ybS1hcHByb3ZhbCIsImF1dGhfdGltZSI6MTU4ODIzODkwNiwidXNlcl9pZCI6Im1DczE2T0pvM1JWQld1OXBHUENoall6RjV5YzIiLCJzdWIiOiJtQ3MxNk9KbzNSVkJXdTlwR1BDaGpZekY1eWMyIiwiaWF0IjoxNTg4MjM4OTA2LCJleHAiOjE1ODgyNDI1MDYsImVtYWlsIjoiY2FuZXNoYS5zZWFAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZ29vZ2xlLmNvbSI6WyIxMTU5OTk1Nzg4ODI2NzU3NDI0MzEiXSwiZW1haWwiOlsiY2FuZXNoYS5zZWFAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoiZ29vZ2xlLmNvbSJ9fQ.FnnNGj8Dw4ldDECFh6Q6Vp1pKVkwWEHbJxZlC4iinSccFLYO1Wwp9n6fbNdx1T_7Mnk-K5yJ8QRDsvq6poy3gngA-qk08iaQTdzBT4rqKQAdC9jT5W2MexQoYj3-9nwz_QZ1AXmbkMJze_bzBilnS2Pj_dAiP6";
    Response response = await dio.get(url);
    print("response : "+response.toString());
    DetailApprovalForm newResponse = detailApprovalFormFromJson(response.toString());
    print("Finish");
    return newResponse;
  }
}
