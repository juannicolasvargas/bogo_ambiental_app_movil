import 'package:bogo_ambiental_app_movil/src/shared_preferences/user_preferences.dart';

class Sessions {
  final _prefs = new UserPreferences();

  String getUrl() {
    return 'https://bogo-ambiental-api.herokuapp.com/api/v1';
  }

  Map<String, String> getHeader() {
    Map<String, String> headers = new Map();
    headers['access-token'] = _prefs.token;
    headers['client'] = _prefs.client;
    headers['uid'] = _prefs.uid;
    headers['token-type'] = _prefs.type;
    return headers;
  }

    //Valida que existe un usuario
  bool isUserExists() {
    if (_isNotEmpty(_prefs.token) &&
        _isNotEmpty(_prefs.client) &&
        _isNotEmpty(_prefs.uid) &&
        _isNotEmpty(_prefs.name)
       ) {
      return true;
    } else {
      return false;
    }
  }

  bool _isNotEmpty(resource) {
    return resource != '';
  }
}