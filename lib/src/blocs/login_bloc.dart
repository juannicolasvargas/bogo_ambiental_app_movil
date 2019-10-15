import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:bogo_ambiental_app_movil/src/validators/validators.dart';

class LoginBloc with Validators {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get emailStream    => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);
  Stream<String> get nameStream     => _nameController.stream.transform(validateName);
  Stream<String> get lastNameStream     => _lastNameController.stream.transform(validateLastName);

  Stream<bool> get forValidStream =>
    Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  Stream<bool> get forRegisterValidStream =>
    Observable.combineLatest4(emailStream, passwordStream, nameStream, lastNameStream, (e, p, n, l) => true);  

  // Insertar valores al Stream
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeLastName => _lastNameController.sink.add;

  // Obtener ultimo valor ingresado
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get name => _nameController.value;
  String get lastName => _lastNameController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _nameController?.close();
    _lastNameController?.close();
  }

}

