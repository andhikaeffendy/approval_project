import 'dart:io';

import 'package:approvalproject/request.dart';
import 'package:approvalproject/signature.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'api_response_model/detail_approval_form.dart';
import 'api_response_model/form_approve.dart';
import 'api_response_model/form_reject.dart';
import 'globals/variable.dart';

class NewRequestDetail extends StatefulWidget {
  final String approvalFormId;
  final String newApprovalStatus;

  const NewRequestDetail({Key key, this.approvalFormId, this.newApprovalStatus}) : super(key: key);
  @override
  _NewRequestDetailState createState() => _NewRequestDetailState(approvalFormId, newApprovalStatus);
}

class _NewRequestDetailState extends State<NewRequestDetail> {
  List<String> listItem = ['satu', 'dua', 'tiga'];
  String approvalFormId;
  String newApprovalStatus = "0";

  TextEditingController rejectionText = TextEditingController();

  DateFormat dateFormat = new DateFormat('yyyy-MM-dd');

  _NewRequestDetailState(this.approvalFormId, this.newApprovalStatus);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new Request())),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Request Detail'),
        ),
        body: FutureBuilder(
          future: getDetailApproval(approvalFormId),
          builder: (context, snapshot){
            if(snapshot.data==null){
              return Container();
            }else{
              Data detailRequest = snapshot.data.data;
              detailRequest.myApprovalStatus = newApprovalStatus;
              print("myapprovalstatus : " + detailRequest.myApprovalStatus.toString());
              if(detailRequest.myApprovalStatus != "0"){
                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width*1,
                          height: MediaQuery.of(context).size.height*0.70,
                          child: Material(
                            elevation: 10.0,
                            borderRadius: BorderRadius.circular(14.0),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      detailRequest.name,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 18.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Form Date : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          dateFormat.format(detailRequest.formDate),
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Document Number : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.documentNumber,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Cost Allocacation : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.costAllocation,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Purposed of Issue : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.purposeOfIssue,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Procurement Type : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.procurementType,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Recurring Option : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.recurringOption,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Issued By : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.issuedBy,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Grand Total : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.value,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Supplier : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.supplier,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 24.0,
                                    ),
                                    Text(
                                      'List Of Detail',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 18,
                                    ),ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: detailRequest.details.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          Detail detailsItemList = detailRequest.details[index];
                                          return Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    detailsItemList.item+' :',
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    detailsItemList.value,
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 12.0,
                                              )
                                            ],
                                          );
                                        }),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    Text(
                                      'List Of Document',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: detailRequest.documents.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          Document document = detailRequest.documents[index];
                                          return Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    document.title,
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.black),
                                                  ),
                                                  ButtonTheme(
                                                    height: 30.0,
                                                    child: FlatButton(
                                                      color: Color(0xFF00bbb9),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          side: BorderSide(color: Color(0xFF00bbb9))
                                                      ),
                                                      onPressed: (){
                                                        print("Launch Url Jalan");
                                                        String url = document.file;
                                                        launchUrl(url);
                                                      },
                                                      child: Text(
                                                        'Download',
                                                        style: TextStyle(
                                                            color: Colors.white
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          );
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),SizedBox(
                          height: 18.0,
                        ),Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        )
                      ],
                    ),
                  ),
                );
              }else{
                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width*1,
                          height: MediaQuery.of(context).size.height*0.70,
                          child: Material(
                            elevation: 10.0,
                            borderRadius: BorderRadius.circular(14.0),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      detailRequest.name,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 18.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Form Date : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          dateFormat.format(detailRequest.formDate),
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Document Number : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.documentNumber,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Cost Allocacation : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.costAllocation,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Purposed of Issue : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.purposeOfIssue,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Procurement Type : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.procurementType,
                                          style: TextStyle(
                                              fontSize: 12.0,fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Recurring Option : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.recurringOption,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Issued By : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.issuedBy,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Grand Total : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.value,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Supplier : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          detailRequest.supplier,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 24.0,
                                    ),
                                    Text(
                                      'List Of Detail',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 18,
                                    ),ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: detailRequest.details.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          Detail detailsItemList = detailRequest.details[index];
                                          return Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    detailsItemList.item + ':',
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    detailsItemList.value,
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 12.0,
                                              )
                                            ],
                                          );
                                        }),
                                    SizedBox(
                                      height: 18.0,
                                    ),Text(
                                      'List Of Document',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: detailRequest.documents.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          Document document = detailRequest.documents[index];
                                          return Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    document.title,
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.black),
                                                  ),
                                                  ButtonTheme(
                                                    height: 30.0,
                                                    child: FlatButton(
                                                      color: Color(0xFF00bbb9),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          side: BorderSide(color: Color(0xFF00bbb9))
                                                      ),
                                                      onPressed: (){
                                                        print("Launch Url Jalan");
                                                        String url = document.file;
                                                        launchUrl(url);
                                                      },
                                                      child: Text(
                                                        'Download',
                                                        style: TextStyle(
                                                            color: Colors.white
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          );
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),SizedBox(
                          height: 18.0,
                        ),Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ButtonTheme(
                              height: 50.0,
                              minWidth: 50.0,
                              child: FlatButton(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(color: Colors.blue)
                                ),
                                onPressed: () => Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                        new SignatureForm(approvalFormId: approvalFormId))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ImageButton(
                                      children: <Widget>[],
                                      onTap: (){},
                                      pressedImage: Image.asset('assets/approved.png'),
                                      unpressedImage: Image.asset('assets/approved.png'),
                                      height: 30.0,
                                      width: 30.0,
                                    ),SizedBox(
                                      width: 8.0,
                                    ),Text(
                                      'APPROVE',
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),ButtonTheme(
                              height: 50.0,
                              minWidth: 50.0,
                              child: FlatButton(
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(color: Colors.red)
                                ),
                                onPressed: (){
                                  _showAlertDialog();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ImageButton(
                                      children: <Widget>[],
                                      pressedImage: Image.asset('assets/Reject.png'),
                                      unpressedImage: Image.asset('assets/Reject.png'),
                                      height: 30.0,
                                      width: 30.0,
                                    ),SizedBox(
                                      width: 8.0,
                                    ),Text(
                                      'REJECT',
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),

    );
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => Navigator.of(context).push(
          new MaterialPageRoute(
              builder: (BuildContext context) =>
              new SignatureForm(approvalFormId: approvalFormId))),
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () => Navigator.of(context).pop()
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Signature"),
      content: Text("You must sign first to approve"),
      actions: [
        cancelButton,
        okButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
                      'Evaluation Analisis (Optional)',
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
                          onTap: () {
                            showCircular(context);
                            return rejectForm(approvalFormId, rejectionText.text).then((task){
                              Navigator.of(context, rootNavigator: true).pop();
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
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => new Request()));
                              }
                            });
                          },
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
    String url = domain + "/api/v1/detail_form?form_id=" + formId;
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + globalUserDetails.idToken;
    Response response = await dio.get(url);

    String dummyResponse = '{"data":[{"id":11,"name":"F1 Form Approval Application 2","form_date":"2020-04-06","document_number":"11/F1-/April-IV/2020","cost_allocation":"Capex","purpose_of_issue":"New Contract","procurement_type":"Tender","issued_by":"Department Head IT","recurring_option":"Recurring","percentage":0.0},{"id":13,"name":"F1 Form Approval Application 3","form_date":"2020-04-08","document_number":"13/F1-/April-IV/2020","cost_allocation":"Capex","purpose_of_issue":"New Contract","procurement_type":"Tender","issued_by":"Department Head IT","recurring_option":"Recurring","percentage":0.0},{"id":15,"name":"F1 Form Approval System","form_date":"2020-04-27","document_number":"15/F1-/April-IV/2020","cost_allocation":"Capex","purpose_of_issue":"New Contract","procurement_type":"Comparison","issued_by":"Department Head IT","recurring_option":"Non Recurring","percentage":0.0}],"status":"success","message":"Data Retrieved successfully"}';
    DetailApprovalForm newResponse = detailApprovalFormFromJson(response.toString());
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
    String dummyResponse = '{"status": "success", "message": "Sign Form Successful"}';

    FormReject newResponse = formRejectFromJson(response.toString());
    return newResponse;
  }

  launchUrl(String url) async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  showCircular(context){
    showDialog(
        context: context,
        child: new Center(
          child: new CircularProgressIndicator(),
        )
    );
  }

}
