import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<String> listitem = ['atu', 'dua', 'tiga', 'empat', 'lima'];

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
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listitem.length,
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
                                    '2020-04-08',
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
                                listitem[index],
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
                                          'Copa',
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
            ),
          )
        ],
      ),
    ),
    );
  }
}
