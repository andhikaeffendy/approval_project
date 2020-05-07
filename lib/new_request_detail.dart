import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';

class NewRequestDetail extends StatefulWidget {
  @override
  _NewRequestDetailState createState() => _NewRequestDetailState();
}

class _NewRequestDetailState extends State<NewRequestDetail> {
  List<String> listItem = ['satu', 'dua', 'tiga'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Detail'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 320.0,
                height: 500.0,
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(14.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Request Name',
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
                              'Andreass',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Container()
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
                              'Max Devour',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Container()
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
                              'John Doe',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Container()
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
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: listItem.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
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
                                                'Item 1',
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                'Rp 200.000.000',
                                                style: TextStyle(
                                                    fontSize: 14.0,
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
                              Flexible(
                                flex: 2,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: listItem.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
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
                                                'Document 1',
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
                                                  onPressed: (){},
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
                                    }),
                              )
                            ],
                          ),
                        ),
                      ],
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
                      onPressed: (){showAlertDialog(context);},
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
                      onPressed: (){},
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
      ),
    );
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Signature"),
      content: Text("You must sign first to approve"),
      actions: [
        okButton,
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
}
