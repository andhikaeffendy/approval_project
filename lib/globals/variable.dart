import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

String domain = "http://f1.wiradipa.com";

UserDetails globalUserDetails;
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