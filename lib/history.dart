import 'dart:io';

import 'package:approvalproject/api_response_model/approval_history_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'globals/variable.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<String> listitem = ['atu', 'dua', 'tiga', 'empat', 'lima'];

  DateFormat dateFormat = new DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.history, size: 35.0,),
            SizedBox(
              width: 8.0,
            ),
            Text(
              'History',
              style: TextStyle(
                fontSize: 18.0
              ),
            )
          ],
        ),
      ),body: Container(
        margin: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: getListHistory(),
              builder: (context, snapshot){
                if(snapshot.data==null){
                  return Container();
                }else{
                  List<Datum> historyList = snapshot.data.data;
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: historyList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: Material(
                            elevation: 8.0,
                            child: Container(
                              margin: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
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
                                              historyList[index]
                                                  .formDate),
                                          style: TextStyle(
                                              color: Colors.pinkAccent),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding:
                                            EdgeInsets.only(
                                                left: 8.0,
                                                right: 8.0,
                                                top: 6.0,
                                                bottom: 6.0),
                                            child: (Text(
                                              'NON',
                                              style: TextStyle(
                                                  color: Color(
                                                      0XFFffffff),
                                                  fontSize: 12.0),
                                            )),
                                            decoration:
                                            BoxDecoration(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  4),
                                              color: Color(
                                                  0XFFf7bc1d),
                                            ),
                                          ),
//                                                    : ImageButton(
//                                                  children: <Widget>[],
//                                                  width: 50.0,
//                                                  height: 25.0,
//                                                  paddingTop: 8.0,
//                                                  pressedImage: Image.asset(
//                                                      'assets/Button_recc.png'),
//                                                  unpressedImage: Image.asset(
//                                                      'assets/Button_recc.png'),
//                                                  onTap: () {},
//                                                ),
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
                                      historyList[index].name,
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
                                      Container(
                                        child: LinearPercentIndicator(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.50,
                                          lineHeight: 18.0,
                                          percent: 0.5,
                                          backgroundColor:
                                          Colors.greenAccent,
                                          progressColor: Colors.green,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              'Request by :',
                                            ),
                                          ),
                                          Container(
                                            width:
                                            MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.30,
                                            child: Center(
                                              child: Text(
                                                historyList[index].issuedBy,
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 14.0,
                                                ),
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
                  );
                }
              },
            ),
          )
        ],
      ),
    ),
    );
  }

  Future<ApprovalHistoryResponse> getListHistory() async {
    var dio = Dio();
    String url = domain + "/api/v1/history_forms";
    dio.options.headers[HttpHeaders.authorizationHeader] =
        'Bearer ' + globalUserDetails.idToken;
    Response response = await dio.get(url);
    print("response : " + response.toString());
    String dummyResponse =
        '{ "data": [ { "id": 11, "name": "F1 Form Approval Application 2", "form_date": "2020-04-06", "document_number": "11/F1-/April-IV/2020", "cost_allocation": "Capex", "purpose_of_issue": "New Contract", "procurement_type": "Tender", "issued_by": "Department Head IT", "recurring_option": "Recurring", "percentage": 0 } ], "status": "success", "message": "Data Retrieved successfully" }';
    ApprovalHistoryResponse newResponse =
    approvalHistoryResponseFromJson(response.toString());
    //ListApprovalForm newResponse = listApprovalFormFromJson(dummyResponse);

    return newResponse;
  }
}
