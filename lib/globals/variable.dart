import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

String domain = "http://f1.wiradipa.com";

UserDetails globalUserDetails;

GoogleSignIn globalGoogleSignIn;
FirebaseAuth globalFirebaseAuth;

Uint8List ttd;

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