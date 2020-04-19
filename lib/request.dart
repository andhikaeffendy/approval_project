import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  List<String> listitem = ['atu', 'dua', 'tiga','empat','lima'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requests'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(20.0),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black38,
                      size: 25.0,
                    ),
                    contentPadding: EdgeInsets.only(left: 16.0, top: 12.0),
                    hintText: 'Search'),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listitem.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Material(
                      elevation: 5.0,
                      child: Container(
                        margin: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    '2020, March 11',
                                    style: TextStyle(color: Colors.pinkAccent),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    ImageButton(
                                      children: <Widget>[],
                                      width: 50.0,
                                      height: 25.0,
                                      paddingTop: 8.0,
                                      pressedImage: Image.asset('assets/Button_recc.png'),
                                      unpressedImage: Image.asset('assets/Button_recc.png'),
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
                                      pressedImage: Image.asset('assets/Button_capex.png'),
                                      unpressedImage: Image.asset('assets/Button_capex.png'),
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
                                'R1 : Request Number 1',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                LinearPercentIndicator(
                                  width: 180.0,
                                  lineHeight: 18.0,
                                  percent: 0.5,
                                  backgroundColor: Colors.greenAccent,
                                  progressColor: Colors.green,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        'Request by :',
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        'John Doe',
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
