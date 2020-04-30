import 'package:approvalproject/signature.dart';
import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';

class RequestDetail extends StatefulWidget {
  @override
  _RequestDetailState createState() => _RequestDetailState();
}

class _RequestDetailState extends State<RequestDetail> {
  List<Offset> _points = <Offset>[];

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
                height: 400.0,
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
                                '11 Maret 2020',
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
                                'Judul Request',
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
                                'John Doe',
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
                                'Rp. 10.000.000.00',
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
}
