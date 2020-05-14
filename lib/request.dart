import 'dart:io';
import 'dart:ui';

import 'package:approvalproject/api_response_model/list_approval_form.dart';
import 'package:approvalproject/api_response_model/logout_response.dart';
import 'package:approvalproject/main.dart';
import 'package:approvalproject/new_request_detail.dart';
import 'package:approvalproject/request_detail.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:intl/intl.dart';

import 'globals/variable.dart';

class Request extends StatefulWidget {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;

  const Request({Key key, @required this.googleSignIn, this.firebaseAuth})
      : super(key: key);

  @override
  _RequestState createState() => _RequestState(googleSignIn, firebaseAuth);
}

class _RequestState extends State<Request> {
  GoogleSignIn googleSignIn;
  FirebaseAuth firebaseAuth;
  _RequestState(this.googleSignIn, this.firebaseAuth);

  List<String> listitem = ['atu', 'dua', 'tiga', 'empat', 'lima'];

  DateFormat dateFormat = new DateFormat('yyyy-MM-dd');

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              ImageButton(
                children: <Widget>[],
                width: 23,
                height: 23,
                pressedImage: Image.asset('assets/request.png'),
                unpressedImage: Image.asset('assets/request.png'),
              ),SizedBox(
                width: 8.0,
              ),Text(
                'Request',
                style: TextStyle(fontSize: 18.0),
              )
            ],
          ),
          actions: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ImageButton(
                  children: <Widget>[],
                  width: 23,
                  height: 23,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  pressedImage: Image.asset('assets/Log_out.png'),
                  unpressedImage: Image.asset('assets/Log_out.png'),
                  onTap: (){_showAlertDialog(context);},
                ),
              ),
            )
          ],leading: new Container(),
        ),
        body: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: getListApproval(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: new CircularProgressIndicator(),
                    );
                  } else {
                    List<Datum> listApproval = snapshot.data.data;
                    return Expanded(
                      child: RefreshIndicator(
                        key: _refreshIndicatorKey,
                        onRefresh: () => getListApproval().then((task) {
                          setState(() {
                            print("refresing");
                            listApproval = task.data;
                          });
                        }),
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: listApproval.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                      new NewRequestDetail(approvalFormId: listApproval[index].id.toString(), newApprovalStatus: "0"))),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16.0),
                                child: Material(
                                  elevation: 5.0,
                                  child: Container(
                                    margin: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                dateFormat.format(
                                                    listApproval[index].formDate),
                                                style: TextStyle(
                                                    color: Colors.pinkAccent),
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                ImageButton(
                                                  children: <Widget>[],
                                                  width: 50.0,
                                                  height: 25.0,
                                                  paddingTop: 8.0,
                                                  pressedImage: Image.asset(
                                                      'assets/Button_recc.png'),
                                                  unpressedImage: Image.asset(
                                                      'assets/Button_recc.png'),
                                                  onTap: () {},
                                                ),
                                                SizedBox(
                                                  width: 8.0,
                                                ),
                                                ImageButton(
                                                  children: <Widget>[],
                                                  width: 50.0,
                                                  height: 25.0,
                                                  paddingTop: 8.0,
                                                  pressedImage: Image.asset(
                                                      'assets/Button_capex.png'),
                                                  unpressedImage: Image.asset(
                                                      'assets/Button_capex.png'),
                                                  onTap: () {},
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 12.0,
                                        ),
                                        Container(
                                          child: Text(
                                            listApproval[index].name,
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 32.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            LinearPercentIndicator(
                                              width: 180.0,
                                              lineHeight: 18.0,
                                              percent: 0.5,
                                              backgroundColor: Colors.greenAccent,
                                              progressColor: Colors.green,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    'Request by :',
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    listApproval[index].issuedBy,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }



  _showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () => logoutRequest().then((task) {
        if (task.status == 'success') {
          googleSignOut().then((task) {
            print("task = " + task.toString());
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new MyApp()));
          });
        }
      }),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Do you want to Logout?"),
      actions: [
        cancelButton,
        continueButton,
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

  Future<ListApprovalForm> getListApproval() async {
    var dio = Dio();
    print("masuk get list 2");
    String url = domain + "/api/v1/approval_forms";
    dio.options.headers[HttpHeaders.authorizationHeader] =
        'Bearer ' + globalUserDetails.idToken;
    Response response = await dio.get(url);
    print("response : " + response.toString());
    String dummyResponse =
        '{"data": [ {   "id": 11,"name": "F1 Form Approval Application 2",    "form_date": "2020-04-06",    "document_number": "11/F1-/April-IV/2020",    "cost_allocation": "Capex",    "purpose_of_issue": "New Contract",    "procurement_type": "Tender",    "issued_by": "Department Head IT",    "recurring_option": "Recurring",   "percentage": 0  }    ],    "status": "success",    "message": "Data Retrieved successfully"  }';
    //ListApprovalForm newResponse = listApprovalFormFromJson(response.toString());
    ListApprovalForm newResponse = listApprovalFormFromJson(dummyResponse);

    return newResponse;
  }

  Future<LogoutResponse> logoutRequest() async {
    var dio = Dio();
    String url = domain + "/api/v1/logout";
    dio.options.headers[HttpHeaders.authorizationHeader] =
        'Bearer ' + globalUserDetails.idToken;
    Response response = await dio.post(url);
    print("response logout: " + response.toString());
    String dummyResponse =
        '{"data": [ {   "id": 11,"name": "F1 Form Approval Application 2",    "form_date": "2020-04-06",    "document_number": "11/F1-/April-IV/2020",    "cost_allocation": "Capex",    "purpose_of_issue": "New Contract",    "procurement_type": "Tender",    "issued_by": "Department Head IT",    "recurring_option": "Recurring",   "percentage": 0  }    ],    "status": "success",    "message": "Data Retrieved successfully"  }';
    LogoutResponse newResponse = logoutResponseFromJson(response.toString());

    return newResponse;
  }

  Future googleSignOut() async {
    try {
      print("check null" + globalFirebaseAuth.toString());
      globalFirebaseAuth.signOut().then((task) {
        globalGoogleSignIn.signOut();
      });
      print("firebase signout sukses");
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
