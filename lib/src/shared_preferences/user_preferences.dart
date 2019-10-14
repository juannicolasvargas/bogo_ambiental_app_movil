import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del usuario

  get id {
    return _prefs.getInt('id') ?? 0;
  }

  set id( int value ) {
    _prefs.setInt('id', value);
  }

  get name {
    return _prefs.getString('name') ?? '';
  }

  set name( String value ) {
    _prefs.setString('name', value);
  }

  get lastName {
    return _prefs.getString('lastName') ?? '';
  }

  set lastName( String value ) {
    _prefs.setString('lastName', value);
  }

  get image {
    return _prefs.getString('image') ?? '';
  }

  set image( String value ) {
    _prefs.setString('image', value);
  }

  // GET y SET de los headers

  get token {
    return _prefs.getString('access-token') ?? '';
  }

  set token( String value) {
    _prefs.setString('access-token', value);
  }

  get client {
    return _prefs.getString('client') ?? '';
  }

  set client( String value) {
    _prefs.setString('client', value);
  }

  get uid {
    return _prefs.getString('uid') ?? '';
  }

  set uid( String value) {
    _prefs.setString('uid', value);
  }

  get type {
    return _prefs.getString('token-type') ?? '';
  }

  set type( String value) {
    _prefs.setString('token-type', value);
  }

}
