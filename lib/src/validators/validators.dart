import 'dart:async';

class Validators {

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: ( email, sink ) {

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp   = new RegExp(pattern);

      if ( regExp.hasMatch( email ) ) {
        sink.add( email );
      } else {
        sink.addError('Email con formato incorrecto');
      }

    }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: ( password, sink ) {

      if ( password.length >= 6 ) {
        sink.add( password );
      } else {
        sink.addError('minimo 6 caracteres');
      }

    }
  );

  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: ( name, sink ) {

      Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
      RegExp regExp   = new RegExp(pattern);

      if ( regExp.hasMatch( name ) ) {
        sink.add( name );
      } else {
        sink.addError('Nombre con formato incorrecto');
      }

    }
  );

  final validateLastName = StreamTransformer<String, String>.fromHandlers(
    handleData: ( lastName, sink ) {

      Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
      RegExp regExp   = new RegExp(pattern);

      if ( regExp.hasMatch( lastName ) ) {
        sink.add( lastName );
      } else {
        sink.addError('Apellido con formato incorrecto');
      }

    }
  );

  final validateTitle = StreamTransformer<String, String>.fromHandlers(
    handleData: ( title, sink ) {

      Pattern pattern = r"^[A-Za-z0-9\s]+$";
      RegExp regExp   = new RegExp(pattern);

      if ( regExp.hasMatch( title ) ) {
        sink.add( title );
      } else {
        sink.addError('Titulo con formato incorrecto');
      }

    }
  );

  final validateDescription = StreamTransformer<String, String>.fromHandlers(
    handleData: ( description, sink ) {
      
      if ( description.length >= 30 ) {
        sink.add( description );
      } else {
        sink.addError('Descripción demasiado corta');
      }

    }
  );
}
