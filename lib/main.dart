import 'package:approvalproject/api_response_model/login_response.dart';
import 'package:approvalproject/new_request_detail.dart';
import 'package:approvalproject/request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';
import 'globals/variable.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _value1 = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();


  Future<FirebaseUser> _signIn(BuildContext context) async{
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('Sign in'),
    ));

    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =await googleUser.authentication;


    print("googleSignIn : " + _googlSignIn.toString());
    print("FireBaseAuth : " + _firebaseAuth.toString());

    globalGoogleSignIn = _googlSignIn;
    globalFirebaseAuth = _firebaseAuth;

    print("globGoogleSignIn = " + globalGoogleSignIn.toString());
    print("globFirebase = " + globalFirebaseAuth.toString());

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );



    FirebaseUser userDetails = (await _firebaseAuth.signInWithCredential(credential)).user;
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);

    var googleIdToken = await userDetails.getIdToken();
    print("userDetails.getIdToken = " + googleIdToken.token);

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    UserDetails details = new UserDetails(
        userDetails.providerId,
        userDetails.displayName,
        userDetails.photoUrl,
        userDetails.email,
        providerData,
        googleIdToken.token
    );
    showCircular(context);
    loginRequest(googleIdToken.token).then((task){
      Navigator.of(context, rootNavigator: true).pop();
      if(task.status == "fail"){
        showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text("Sign Fail"),
                content: Text(task.message),
              );
            }
        );
      }else{
        globalUserDetails = details;
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new Request(googleSignIn: _googlSignIn, firebaseAuth: _firebaseAuth),
            //detailsUser: details
          ),
        );


      }

    });



    print("Google Sign In Success");
    return userDetails;
  }


  void _value1Changed(bool value) => setState(() => _value1 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body: Builder(
          builder: (BuildContext context){
            return Center(
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/logo.png', scale: 3,),
                            SizedBox(
                              height: 16.0,
                            ),
                            Container(
                              child: Text(
                                'F1 APPROVAL',
                                style: TextStyle(
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red
                                ),
                              ),
                            )
                          ],
                        ),
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
                                    onTap: () => _signIn(context)
                                        .then((FirebaseUser user) => print(user))
                                        .catchError((e) => print(e)),
                                  ),
//                                  Row(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    crossAxisAlignment: CrossAxisAlignment.center,
//                                    children: <Widget>[
//                                      Checkbox(
//                                        value: _value1,
//                                        onChanged: _value1Changed,
//                                        checkColor: Colors.white,
//                                        activeColor: Colors.red,
//                                        focusColor: Colors.red,
//                                        hoverColor: Colors.red,
//                                      ),
//                                      Text(
//                                        'remember me',
//                                        style: TextStyle(color: Colors.red),
//                                      )
//                                    ],
//                                  )
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
            );
          },
        )
    );
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

Future<LoginResponse> loginRequest(String idToken) async{
  var dio = Dio();
  String url = domain + "/api/v1/login";
  FormData formData = new FormData.fromMap({
    "id_token": idToken,
  });
  Response response = await dio.post(url, data: formData);
  print(response.data);

  LoginResponse loginResponse = loginResponseFromJson(response.toString());
  return loginResponse;
}