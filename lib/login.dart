import 'package:approvalproject/request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _value1 = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async{
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('Sign in'),
    ));

    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =await googleUser.authentication;

    print("google acc token : " + googleAuth.accessToken);
    print("go0gle id token : " + googleAuth.idToken);

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

    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new Request(),
        //detailsUser: details
      ),
    );

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
                                  onTap: () => _signIn(context)
                                      .then((FirebaseUser user) => print(user))
                                      .catchError((e) => print(e)),
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
          );
        },
      )
    );
  }
}

class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final String idToken;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails,this.userName, this.photoUrl,this.userEmail, this.providerData, this.idToken);
}


class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}