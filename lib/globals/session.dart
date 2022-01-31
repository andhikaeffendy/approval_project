import 'package:shared_preferences/shared_preferences.dart';
import 'variable.dart';

final String _session_email = "abl_email";
final String _session_username = "abl_username";
final String _session_provider = "abl_provider";
final String _session_photo = "abl_photo";
final String _session_token = "abl_token";

storeSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(_session_email, globalUserDetails.userEmail);
  prefs.setString(_session_username, globalUserDetails.userName);
  prefs.setString(_session_provider, globalUserDetails.providerDetails);
  prefs.setString(_session_photo, globalUserDetails.photoUrl);
  prefs.setString(_session_token, globalUserDetails.idToken);
}

destroySession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future loadSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  UserDetails details = new UserDetails(
      _get_data(prefs, _session_provider),
      _get_data(prefs, _session_username),
      _get_data(prefs, _session_email),
      _get_data(prefs, _session_photo),
      null,
      _get_data(prefs, _session_token),
  );
  globalUserDetails = details;
}

_get_data(SharedPreferences prefs, key){
  return prefs.containsKey(key) ? prefs.getString(key) : "";
}