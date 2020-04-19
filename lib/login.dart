import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _value1 = false;

  void _value1Changed(bool value) => setState(() => _value1 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Container(
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Container(
                  height: 250.0,
                  color: Colors.white,
                  child: Image.asset('assets/logo.png', scale: 3,),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 300.0,
                      height: 250.0,
                      child: Material(
                        elevation: 20.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                'Please login using your google account'
                            ),
                            ImageButton(
                              children: <Widget>[],
                              width: 250.0,
                              height: 50.0,
                              paddingTop: 8.0,
                              pressedImage: Image.asset('assets/Button_google.png'),
                              unpressedImage: Image.asset('assets/Button_google.png'),
                              onTap: () {},
                            ),Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Checkbox(
                                  value: _value1,
                                  onChanged: _value1Changed,
                                  checkColor: Colors.white,
                                  activeColor: Colors.red,
                                  focusColor: Colors.red,
                                  hoverColor: Colors.red,
                                ),
                                Text(
                                  'remember me',
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
