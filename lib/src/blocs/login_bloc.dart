import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:bogo_ambiental_app_movil/src/validators/validators.dart';

class LoginBloc with Validators {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get emailStream    => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);

  Stream<bool> get forValidStream =>
    Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener ultimo valor ingresado
  String get email => _emailController.value;
  String get password => _passwordController.value;


  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }

}

